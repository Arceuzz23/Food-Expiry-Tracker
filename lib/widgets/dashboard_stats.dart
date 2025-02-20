import 'package:expyr_assignment_1/models/item_data.dart';
import 'package:flutter/material.dart';

class DashboardStats extends StatelessWidget {
  final List<ItemData> items;

  const DashboardStats({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final expiredCount = items.where((item) => item.isExpired).length;
    final consumedCount = items.where((item) => item.isConsumed).length;
    final availableCount = items.where((item) => !item.isConsumed).length;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Overview', style: theme.textTheme.titleLarge),
            const SizedBox(height: 16),
            _buildStatRow(
              icon: Icons.food_bank,
              label: 'Available Items',
              value: availableCount.toString(),
              color: Colors.blue,
            ),
            _buildStatRow(
              icon: Icons.check_circle,
              label: 'Consumed Items',
              value: consumedCount.toString(),
              color: Colors.green,
            ),
            _buildStatRow(
              icon: Icons.warning_amber,
              label: 'Expired Items',
              value: expiredCount.toString(),
              color: Colors.red,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatRow({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(icon, color: color),
          const SizedBox(width: 8),
          Text(label),
          const Spacer(),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
