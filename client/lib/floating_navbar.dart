import 'dart:ui';
import 'package:flutter/material.dart';

class FloatingBottomNav extends StatelessWidget {
  final int selectedIndex;
  final Function(int)? onTap;

  const FloatingBottomNav({
    super.key,
    required this.selectedIndex,
    this.onTap,
  });

  final List<_NavItem> items = const [
    _NavItem(Icons.home_rounded, "Home"),
    _NavItem(Icons.shopping_bag_outlined, "Order Again"),
    _NavItem(Icons.grid_view_rounded, "Categories"),
    _NavItem(Icons.print_outlined, "Print"),
  ];

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 20,
      left: 20,
      right: 20,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(35),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.25),
              borderRadius: BorderRadius.circular(35),
              border: Border.all(color: Colors.white.withOpacity(0.4)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(
                items.length,
                (index) => _buildNavItem(context, index),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, int index) {
    final isActive = selectedIndex == index;

    return GestureDetector(
      onTap: () {
        onTap?.call(index);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isActive
              ? Colors.white.withOpacity(0.6)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Row(
          children: [
            Icon(
              items[index].icon,
              size: 22,
              color:
                  isActive ? Colors.orange : Colors.black87,
            ),
            if (isActive) ...[
              const SizedBox(width: 8),
              Text(
                items[index].label,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }
}

class _NavItem {
  final IconData icon;
  final String label;

  const _NavItem(this.icon, this.label);
}