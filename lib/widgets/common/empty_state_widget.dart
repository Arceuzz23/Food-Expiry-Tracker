import 'package:flutter/material.dart';
import '../../constants/ui_constants.dart';
import '../../constants/responsive_constants.dart';

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
          Icon(
            icon,
            size: Responsive.iconSize(context) * 2,
            color: color,
          ),
          SizedBox(height: Responsive.defaultPadding(context)),
          Text(
            message,
            style: TextStyle(fontSize: Responsive.bodySize(context)),
          ),
        ],
      ),
    );
  }
}
