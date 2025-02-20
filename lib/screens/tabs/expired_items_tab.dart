import 'package:flutter/material.dart';
import '../../models/item_data.dart';
import '../../widgets/item_card.dart';

class ExpiredItemsTab extends StatelessWidget {
  final List<ItemData> items;
  final Function(ItemData) onConsume;
  final Function(ItemData) onItemTap;

  const ExpiredItemsTab({
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
            Icon(
              Icons.warning_amber,
              size: 48,
              color: Colors.grey,
            ),
            SizedBox(height: 16),
            Text(
              'No expired items',
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
        onConsume: () => onConsume(items[index]),
        onTap: () => onItemTap(items[index]),
      ),
    );
  }
} 