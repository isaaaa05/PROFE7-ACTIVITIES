import 'package:flutter/material.dart';

// Task 4: Custom reusable button widget used across different screens
class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isPrimary;
  final double? width;
  final IconData? icon;
  final Color? customColor;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isPrimary = false,
    this.width,
    this.icon,
    this.customColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: customColor ??
              (isPrimary ? const Color(0xFF8B4513) : Colors.white),
          foregroundColor: isPrimary ? Colors.white : const Color(0xFF8B4513),
          elevation: isPrimary ? 8 : 2,
          shadowColor: Colors.black.withValues(alpha: 0.2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
            side: isPrimary
                ? BorderSide.none
                : BorderSide(
                    color: const Color(0xFF8B4513).withValues(alpha: 0.3)),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize:
              MainAxisSize.min, // <CHANGE> Fixed overflow by using min size
          children: [
            if (icon != null) ...[
              Icon(icon,
                  size: 18), // <CHANGE> Reduced icon size to prevent overflow
              const SizedBox(width: 6), // <CHANGE> Reduced spacing
            ],
            Flexible(
              // <CHANGE> Wrapped text in Flexible to prevent overflow
              child: Text(
                text,
                style: const TextStyle(
                  fontSize:
                      14, // <CHANGE> Reduced font size to prevent overflow
                  fontWeight: FontWeight.w600,
                ),
                overflow: TextOverflow
                    .ellipsis, // <CHANGE> Added ellipsis for long text
                maxLines: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
