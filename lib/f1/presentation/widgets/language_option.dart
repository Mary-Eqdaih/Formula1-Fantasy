import 'package:flutter/material.dart';

/// A selectable language option card used inside the language picker sheet.
/// Shows a flag, label, sublabel, and a checkmark when selected.
class LanguageOption extends StatelessWidget {
  final String flag;
  final String label;
  final String sublabel;
  final bool selected;
  final VoidCallback onTap;

  const LanguageOption({
    super.key,
    required this.flag,
    required this.label,
    required this.sublabel,
    required this.selected,
    required this.onTap,
  });

  static const _f1Red = Color(0xFFE10600);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      // AnimatedContainer smoothly animates the border/bg when selected changes
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: selected
              ? _f1Red.withOpacity(0.12)
              : Colors.white.withOpacity(0.04),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: selected
                ? _f1Red.withOpacity(0.5)
                : Colors.white.withOpacity(0.08),
          ),
        ),
        child: Row(
          children: [
            Text(flag, style: const TextStyle(fontSize: 24)),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontFamily: 'TitilliumWeb',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    sublabel,
                    style: const TextStyle(
                      color: Colors.white38,
                      fontSize: 12,
                      fontFamily: 'TitilliumWeb',
                    ),
                  ),
                ],
              ),
            ),
            // Checkmark when selected, empty circle when not
            if (selected)
              const Icon(Icons.check_circle, color: _f1Red, size: 20)
            else
              const Icon(
                Icons.radio_button_unchecked,
                color: Colors.white24,
                size: 20,
              ),
          ],
        ),
      ),
    );
  }
}
