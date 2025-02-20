import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../models/item_data.dart';
import '../providers/items_provider.dart';
import '../themes/app_theme.dart';

class ItemCard extends StatelessWidget {
  final ItemData item;
  final VoidCallback? onConsume;
  final VoidCallback? onUndo;
  final VoidCallback? onTap;
  final bool showExpiredWarning;

  const ItemCard({
    super.key,
    required this.item,
    this.onConsume,
    this.onUndo,
    this.onTap,
    this.showExpiredWarning = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isExpired = item.isExpired;
    final provider = Provider.of<ItemsProvider>(context);
    final isLoading = provider.loading && provider.processingItemId == item.id;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: AppTheme.cardDecoration.copyWith(
        border: Border(
          left: BorderSide(
            width: 6,
            color: _getStatusColor(isExpired),
          ),
        ),
      ),
      child: Stack(
        children: [
          if (showExpiredWarning && isExpired)
            Positioned(
              right: 8,
              top: 8,
              child: _buildExpiryWarning(context),
            ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                // Left side - Icon and Status
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: _getStatusColor(isExpired).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    _getItemIcon(),
                    color: _getStatusColor(isExpired),
                    size: 28,
                  ),
                ),
                const SizedBox(width: 16),
                // Middle - Item Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.name,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            size: 16,
                            color: AppTheme.iconGrey,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            item.location,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: AppTheme.textGrey,
                            ),
                          ),
                          if (item.quantity > 1) ...[
                            const SizedBox(width: 16),
                            Icon(
                              Icons.inventory_2_outlined,
                              size: 16,
                              color: AppTheme.iconGrey,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              'Qty: ${item.quantity}',
                              style: theme.textTheme.bodyMedium
                                  ?.copyWith(color: AppTheme.textGrey),
                            ),
                          ],
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(
                            Icons.event_outlined,
                            size: 16,
                            color: isExpired ? Colors.red : AppTheme.iconGrey,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'Expires: ${_formatDate(item.expiryDate)}',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: isExpired ? Colors.red : AppTheme.textGrey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // Right side - Consume Button
                SizedBox(
                  width: 48,
                  height: 48,
                  child: isLoading
                      ? Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                          ),
                        )
                      : IconButton(
                          icon: Icon(
                            item.isConsumed
                                ? Icons.settings_backup_restore_outlined
                                : Icons.check_circle_outline,
                            color: item.isConsumed ? Colors.grey : Colors.grey,
                            size: 28,
                          ),
                          onPressed: item.isConsumed ? onUndo : onConsume,
                        ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExpiryWarning(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.red.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.warning_amber, color: Colors.red, size: 16),
          const SizedBox(width: 4),
          Text(
            'Expired ${item.daysUntilExpiry.abs()} days ago',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.red,
                ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(bool isExpired) {
    if (item.isConsumed) return Colors.green;
    if (isExpired) return Colors.red;
    return Colors.orange;
  }

  IconData _getItemIcon() {
    if (item.isConsumed) return Icons.check_circle;
    if (item.isPackaged) return Icons.inventory_2;
    return Icons.food_bank;
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }
}
