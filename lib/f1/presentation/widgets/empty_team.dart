import 'package:flutter/material.dart';
import '../../../../l10n/app_localizations.dart';

class EmptyTeam extends StatelessWidget {
  const EmptyTeam();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.sports_score, color: Colors.white24, size: 64),
          const SizedBox(height: 16),
          Text(
            l10n.myTeamEmpty,
            style: const TextStyle(
              color: Colors.white54,
              fontSize: 16,
              fontFamily: 'TitilliumWeb',
            ),
          ),
          const SizedBox(height: 8),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              l10n.myTeamGoPickTeam,
              style: const TextStyle(
                color: Color(0xFFE10600),
                fontFamily: 'TitilliumWeb',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
