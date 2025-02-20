import 'package:flutter/material.dart';
import '../../themes/app_theme.dart';
import '../../constants/responsive_constants.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  final List<NavItem> items;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kBottomNavigationBarHeight,
      margin: EdgeInsets.symmetric(
        horizontal: Responsive.defaultMargin(context),
        vertical: 8,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: onTap,
          backgroundColor: Colors.white,
          selectedItemColor: Theme.of(context).primaryColor,
          unselectedItemColor: AppTheme.iconGrey,
          selectedFontSize: 10,
          unselectedFontSize: 10,
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          elevation: 0,
          items: items
              .map((item) =>
                  _buildNavItem(item, currentIndex == items.indexOf(item)))
              .toList(),
        ),
      ),
    );
  }

  BottomNavigationBarItem _buildNavItem(NavItem item, bool isSelected) {
    return BottomNavigationBarItem(
      icon: Icon(item.icon, size: 24),
      activeIcon: Builder(
        builder: (context) => Icon(
          item.icon,
          size: 24,
          color: Theme.of(context).primaryColor,
        ),
      ),
      label: item.label,
    );
  }
}

class NavItem {
  final IconData icon;
  final String label;

  const NavItem({
    required this.icon,
    required this.label,
  });
}
