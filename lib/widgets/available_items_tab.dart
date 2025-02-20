import 'package:flutter/material.dart';
import '../models/item_data.dart';
import 'item_card.dart';

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
      itemBuilder: (context, index) => ItemCard(
        item: items[index],
        onTap: () => onItemTap(items[index]),
        onConsume: () => onConsume(items[index]),
      ),
    );
  }
}
