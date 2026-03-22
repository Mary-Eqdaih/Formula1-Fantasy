import 'package:flutter/material.dart';
import '../../../../l10n/app_localizations.dart';

class TeamStatusBadge extends StatelessWidget {
  final bool isSaved;
  const TeamStatusBadge({required this.isSaved});

  static const _green = Color(0xFF229971);
  static const _f1Red = Color(0xFFE10600);
  static const _orange = Color(0xFFFF8000);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 24),
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: isSaved ? _green.withOpacity(0.15) : _f1Red.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isSaved ? _green.withOpacity(0.4) : _f1Red.withOpacity(0.3),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            isSaved ? Icons.check_circle : Icons.warning_amber_rounded,
            color: isSaved ? _green : _orange,
            size: 18,
          ),
          const SizedBox(width: 8),
          Text(
            isSaved ? l10n.myTeamSavedStatus : l10n.myTeamUnsavedStatus,
            style: TextStyle(
              color: isSaved ? _green : _orange,
              fontSize: 13,
              fontWeight: FontWeight.w500,
              fontFamily: 'TitilliumWeb',
            ),
          ),
        ],
      ),
    );
  }
}
