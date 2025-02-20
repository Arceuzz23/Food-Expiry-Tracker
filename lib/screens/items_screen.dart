import 'package:expyr_assignment_1/screens/tabs/available_items_tab.dart';
import 'package:expyr_assignment_1/screens/tabs/consumed_items_tab.dart';
import 'package:expyr_assignment_1/screens/tabs/expired_items_tab.dart';
import 'package:expyr_assignment_1/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/item_data.dart';
import '../providers/items_provider.dart';
import '../widgets/dialogs/consume_confirmation_dialog.dart';
import '../widgets/item_details_sheet.dart';
import '../widgets/navigation/custom_bottom_nav_bar.dart';

class ItemsScreen extends StatefulWidget {
  const ItemsScreen({super.key});

  @override
  State<ItemsScreen> createState() => _ItemsScreenState();
}

class _ItemsScreenState extends State<ItemsScreen> {
  int _selectedIndex = 0;

  static const _navItems = [
    NavItem(icon: Icons.food_bank, label: 'Available'),
    NavItem(icon: Icons.history, label: 'Consumed'),
    NavItem(icon: Icons.warning_amber, label: 'Expired'),
  ];

  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => Provider.of<ItemsProvider>(context, listen: false).loadItems());
  }

  String _getTitle() {
    switch (_selectedIndex) {
      case 0:
        return 'Available Items';
      case 1:
        return 'Consumed Items';
      case 2:
        return 'Expired Items';
      default:
        return 'Food Tracker';
    }
  }

  void _handleConsume(BuildContext context, ItemData item) async {
    if (item.isExpired) {
      final shouldConsume = await showDialog<bool>(
        context: context,
        builder: (context) => ConsumeConfirmationDialog(
          item: item,
          isExpired: true,
        ),
      );
      if (shouldConsume != true) return;
    }

    final scaffoldMessenger = ScaffoldMessenger.of(context);
    final provider = Provider.of<ItemsProvider>(context, listen: false);

    try {
      final undoFunction = await provider.consumeItem(item.id!);
      if (undoFunction != null) {
        scaffoldMessenger.hideCurrentSnackBar();
        scaffoldMessenger.showSnackBar(
          SnackBar(
            content: Text('Marked "${item.name}" as consumed'),
            action: SnackBarAction(
              label: 'UNDO',
              onPressed: () async {
                await undoFunction();
                scaffoldMessenger.hideCurrentSnackBar();
                scaffoldMessenger.showSnackBar(
                  SnackBar(content: Text('Restored "${item.name}"')),
                );
              },
            ),
          ),
        );
      }
    } catch (e) {
      scaffoldMessenger.showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }

  void _handleUndo(BuildContext context, ItemData item) async {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    final provider = Provider.of<ItemsProvider>(context, listen: false);

    try {
      // Store the original state
      final originalItem = item;

      // Update the item to available state
      await provider.updateItem(item.copyWith(
        isConsumed: false,
        consumedAt: null,
      ));

      scaffoldMessenger.hideCurrentSnackBar();
      scaffoldMessenger.showSnackBar(
        SnackBar(
          content: Text('Restored "${item.name}" to available items'),
          action: SnackBarAction(
            label: 'UNDO',
            onPressed: () async {
              try {
                // Restore to consumed state
                await provider.updateItem(originalItem);
                scaffoldMessenger.hideCurrentSnackBar();
                scaffoldMessenger.showSnackBar(
                  SnackBar(
                    content:
                        Text('Moved "${item.name}" back to consumed items'),
                  ),
                );
              } catch (e) {
                scaffoldMessenger.showSnackBar(
                  SnackBar(content: Text('Error: ${e.toString()}')),
                );
              }
            },
          ),
        ),
      );
    } catch (e) {
      scaffoldMessenger.showSnackBar(
        SnackBar(content: Text('Error restoring item: $e')),
      );
    }
  }

  void _showItemDetails(BuildContext context, ItemData item) {
    showModalBottomSheet(
      context: context,
      builder: (context) => ItemDetailsSheet(item: item),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _getTitle(),
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
        ),
        centerTitle: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Consumer<ItemsProvider>(
        builder: (context, provider, child) {
          if (provider.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.error != null) {
            return Center(child: Text('Error: ${provider.error}'));
          }

          return switch (_selectedIndex) {
            0 => AvailableItemsTab(
                items: provider.items,
                onConsume: (item) => _handleConsume(context, item),
                onItemTap: (item) => _showItemDetails(context, item),
              ),
            1 => ConsumedItemsTab(
                items: provider.consumedItems,
                onItemTap: (item) => _showItemDetails(context, item),
                onUndo: (item) => _handleUndo(context, item),
              ),
            2 => ExpiredItemsTab(
                items: provider.expiredItems,
                onConsume: (item) => _handleConsume(context, item),
                onItemTap: (item) => _showItemDetails(context, item),
              ),
            _ => const SizedBox.shrink(),
          };
        },
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: _navItems,
      ),
    );
  }
}
