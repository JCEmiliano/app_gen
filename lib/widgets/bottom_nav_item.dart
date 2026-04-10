import 'package:flutter/material.dart';

class BottomNavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final bool isDark;
  final VoidCallback? onTap;

  const BottomNavItem({
    super.key,
    required this.icon,
    required this.label,
    required this.isActive,
    required this.isDark,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final c = isActive 
        ? Theme.of(context).colorScheme.primary 
        : (isDark ? const Color(0xFFa5abbd) : const Color(0xFF64748b));

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: isActive
            ? BoxDecoration(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              )
            : BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(12),
              ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isActive ? Theme.of(context).colorScheme.primary : c,
              size: 24,
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                color: isActive ? Theme.of(context).colorScheme.primary : c,
                fontSize: 10,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
