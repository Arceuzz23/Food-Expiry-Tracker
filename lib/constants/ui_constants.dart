import 'package:flutter/material.dart';

class UIConstants {
  static const cardPadding = EdgeInsets.symmetric(horizontal: 12, vertical: 6);
  static const contentPadding = EdgeInsets.all(16);
  static const borderRadius = BorderRadius.vertical(top: Radius.circular(20));
  
  static const emptyStateIconSize = 48.0;
  static const statusBarWidth = 6.0;
  
  static const statusColors = {
    'available': Colors.blue,
    'consumed': Colors.green,
    'expired': Colors.red,
  };
} 