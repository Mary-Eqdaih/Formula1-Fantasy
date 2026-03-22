import 'package:flutter/material.dart';

// Wraps a list of [SettingsTile]s inside a rounded card container.
class SettingsGroup extends StatelessWidget {
  final List<Widget> children;

  const SettingsGroup({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    // Insert a divider between every pair of tiles automatically
    // so callers don't need to manually add Divider() between items
    final List<Widget> withDividers = [];
    for (int i = 0; i < children.length; i++) {
      withDividers.add(children[i]);
      if (i < children.length - 1) {
        withDividers.add(
          Divider(
            height: 1,
            thickness: 1,
            color: Colors.white.withOpacity(0.05),
            indent: 56, // aligns with text, not icon
          ),
        );
      }
    }

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF18191A),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.06)),
      ),
      child: Column(children: withDividers),
    );
  }
}
