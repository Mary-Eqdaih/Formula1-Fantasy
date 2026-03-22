import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../l10n/app_localizations.dart';
import '../../cubit/fantasy_cubit.dart';
import '../../cubit/fantasy_states.dart';

class BudgetBanner extends StatelessWidget {
  static const _cardBg = Color(0xFF18191A);
  static const _f1Red = Color(0xFFE10600);
  static const _orange = Color(0xFFFF8000);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocBuilder<FantasyCubit, FantasyState>(
      builder: (context, state) {
        final pct = (state.spent / state.budget).clamp(0.0, 1.0);
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: _cardBg,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.white.withOpacity(0.06)),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _statChip(
                    label: l10n.myTeamDrivers,
                    value: '${state.selectedDrivers.length}/5',
                    icon: Icons.person,
                  ),
                  _statChip(
                    label: l10n.fantasyBudgetLeft,
                    value: '\$${state.remaining.toStringAsFixed(1)}M',
                    icon: Icons.account_balance_wallet,
                    highlight: state.remaining < 10,
                  ),
                  _statChip(
                    label: l10n.fantasySpent,
                    value: '\$${state.spent.toStringAsFixed(1)}M',
                    icon: Icons.payments,
                  ),
                ],
              ),
              const SizedBox(height: 10),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: pct,
                  minHeight: 6,
                  backgroundColor: Colors.white12,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    pct > 0.9 ? _f1Red : _orange,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _statChip({
    required String label,
    required String value,
    required IconData icon,
    bool highlight = false,
  }) {
    const f1Red = Color(0xFFE10600);
    return Column(
      children: [
        Icon(icon, color: highlight ? f1Red : Colors.white54, size: 18),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            color: highlight ? f1Red : Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 15,
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
}
