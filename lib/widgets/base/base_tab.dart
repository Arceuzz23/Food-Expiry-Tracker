import 'package:flutter/material.dart';
import '../../models/item_data.dart';

abstract class BaseTab extends StatelessWidget {
  final List<ItemData> items;
  final Widget Function(ItemData) itemBuilder;
  final Widget emptyStateWidget;

  const BaseTab({
    super.key,
    required this.items,
    required this.itemBuilder,
    required this.emptyStateWidget,
  });

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return emptyStateWidget;
    }

    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) => itemBuilder(items[index]),
    );
  }
} 