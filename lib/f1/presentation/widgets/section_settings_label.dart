import 'package:flutter/material.dart';

/// A small uppercase section label with a red left bar accent.
/// Used above each [SettingsGroup] to label the section.
class SettingsSectionLabel extends StatelessWidget {
  final String text;

  const SettingsSectionLabel(this.text, {super.key});

  static const _f1Red = Color(0xFFE10600);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24, bottom: 10, left: 4,right: 4),
      child: Row(
        children: [
          // Left red bar — consistent with section headers across the app
          Container(
            width: 3,
            height: 14,
            color: _f1Red,
            margin: const EdgeInsets.symmetric(horizontal: 8),
          ),
          Text(
            text,
            style: const TextStyle(
              color: Colors.white38,
              fontSize: 11,
              fontWeight: FontWeight.bold,
              fontFamily: 'TitilliumWeb',
              letterSpacing: 2,
            ),
          ),
        ],
      ),
    );
  }
}
