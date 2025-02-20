import 'package:flutter/material.dart';

class Responsive {
  static double screenWidth(BuildContext context) => MediaQuery.of(context).size.width;
  static double screenHeight(BuildContext context) => MediaQuery.of(context).size.height;

  // Padding and margins
  static double defaultPadding(BuildContext context) => screenWidth(context) * 0.04;
  static double defaultMargin(BuildContext context) => screenWidth(context) * 0.04;

  // Font sizes
  static double titleSize(BuildContext context) => screenWidth(context) * 0.055;
  static double bodySize(BuildContext context) => screenWidth(context) * 0.04;
  static double smallSize(BuildContext context) => screenWidth(context) * 0.035;

  // Icon sizes
  static double iconSize(BuildContext context) => screenWidth(context) * 0.06;
  static double smallIconSize(BuildContext context) => screenWidth(context) * 0.045;

  // Card dimensions
  static double cardHeight(BuildContext context) => screenHeight(context) * 0.12;
  static double cardRadius(BuildContext context) => screenWidth(context) * 0.03;

  // Bottom nav
  static double navBarHeight(BuildContext context) => screenHeight(context) * 0.08;
} 