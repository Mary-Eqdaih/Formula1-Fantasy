import 'package:flutter/material.dart';
import '../../../../l10n/app_localizations.dart';
import '../../cubit/fantasy_states.dart';

class TeamSummaryHeader extends StatelessWidget {
  final FantasyState state;
  const TeamSummaryHeader({required this.state});

  static const _f1Red = Color(0xFFE10600);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF18191A), Color(0xFF1E0A0A)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _f1Red.withOpacity(0.25)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _infoBlock(
                l10n.myTeamDrivers,
                '${state.selectedDrivers.length}/5',
                Icons.group,
              ),
              _infoBlock(
                l10n.myTeamTotalCost,
                '\$${state.spent.toStringAsFixed(1)}M',
                Icons.payments,
              ),
              _infoBlock(
                l10n.myTeamRemaining,
                '\$${state.remaining.toStringAsFixed(1)}M',
                Icons.savings,
              ),
            ],
          ),
          if (state.isComplete) ...[
            const SizedBox(height: 16),
            const Divider(color: Colors.white12),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // It takes a list of widgets and inserts them into another list.
                // children: [
                //   [Widget1, Widget2]
                // ]
                // ❌ Wrong because it's a list inside a list.
                ...state.selectedDrivers.map((d) {
                  // It maps through every driver in the list and creates a widget
                  // that is a small circle colored with that driver's team color
                  // children: [
                  //   ...[Widget1, Widget2]
                  // ]
                  final color = _hexColor(d.teamColor);
                  return Container(
                    width: 10,
                    height: 10,
                    margin: const EdgeInsets.symmetric(horizontal: 3),
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                    ),
                  );
                }),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _infoBlock(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: _f1Red, size: 20),
        const SizedBox(height: 6),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
            fontFamily: 'TitilliumWeb',
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white38,
            fontSize: 11,
            fontFamily: 'TitilliumWeb',
          ),
        ),
      ],
    );
  }

  Color _hexColor(String hex) {
    final h = hex.replaceAll('#', '');
    return Color(int.parse('FF$h', radix: 16));
  }
}
