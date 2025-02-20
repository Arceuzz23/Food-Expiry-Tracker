import 'package:expyr_assignment_1/constants/ui_constants.dart';
import 'package:flutter/material.dart';

class EmptyStateWidget extends StatelessWidget {
  final IconData icon;
  final String message;
  final Color? color;

  const EmptyStateWidget({
    super.key,
    required this.icon,
    required this.message,
    this.color = Colors.grey,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: UIConstants.emptyStateIconSize, color: color),
          const SizedBox(height: 16),
          Text(message),
        ],
      ),
    );
  }
}
