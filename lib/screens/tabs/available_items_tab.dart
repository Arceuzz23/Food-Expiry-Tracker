import 'package:expyr_assignment_1/widgets/item_details_sheet.dart';
import 'package:flutter/material.dart';
import '../../models/item_data.dart';
import '../../widgets/item_card.dart';

class AvailableItemsTab extends StatelessWidget {
  final List<ItemData> items;
  final Function(ItemData) onConsume;
  final Function(ItemData) onItemTap;

  const AvailableItemsTab({
    super.key,
    required this.items,
    required this.onConsume,
    required this.onItemTap,
  });

  void _showItemDetails(BuildContext context, ItemData item) {
    showModalBottomSheet(
      context: context,
      builder: (context) => ItemDetailsSheet(item: item),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.no_food, size: 48, color: Colors.grey),
            SizedBox(height: 16),
            Text('No available items'),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) => InkWell(
        onTap: () => _showItemDetails(context, items[index]),
        child: ItemCard(
          item: items[index],
          onConsume: () => onConsume(items[index]),
        ),
      ),
    );
  }
}
