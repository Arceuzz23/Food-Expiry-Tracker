import 'package:flutter/material.dart';
import '../../models/item_data.dart';
import '../../widgets/item_card.dart';

class ConsumedItemsTab extends StatelessWidget {
  final List<ItemData> items;
  final Function(ItemData) onItemTap;
  final Function(ItemData) onUndo;

  const ConsumedItemsTab({
    super.key,
    required this.items,
    required this.onItemTap,
    required this.onUndo,
  });

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.history,
              size: 48,
              color: Colors.grey,
            ),
            SizedBox(height: 16),
            Text(
              'No consumption history',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) => ItemCard(
        item: items[index],
        onTap: () => onItemTap(items[index]),
        onUndo: () => onUndo(items[index]),
      ),
    );
  }
} 