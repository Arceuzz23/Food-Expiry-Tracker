import 'package:flutter/material.dart';
import '../../models/item_data.dart';

class ConsumeConfirmationDialog extends StatelessWidget {
  final ItemData item;
  final bool isExpired;

  const ConsumeConfirmationDialog({
    super.key,
    required this.item,
    required this.isExpired,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(isExpired ? 'Consume Expired Item?' : 'Mark as Consumed'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Are you sure you want to mark "${item.name}" as consumed?'),
          if (isExpired) ...[
            const SizedBox(height: 8),
            Text(
              'This item has expired ${item.daysUntilExpiry.abs()} days ago.',
              style: const TextStyle(color: Colors.red),
            ),
          ],
          const SizedBox(height: 16),
          Text(
            'Note: You can undo this action later.',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: const Text('CANCEL'),
        ),
        FilledButton(
          onPressed: () => Navigator.pop(context, true),
          child: const Text('CONFIRM'),
        ),
      ],
    );
  }
} 