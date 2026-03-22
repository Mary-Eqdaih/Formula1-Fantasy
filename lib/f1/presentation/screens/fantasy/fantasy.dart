import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../cubit/fantasy_cubit.dart';
import '../../../cubit/fantasy_states.dart';
import '../../../data/models/fantasy_model.dart';
import '../../widgets/budget_banner.dart';
import '../../widgets/fantasy_driver_card.dart';
import 'my_team.dart';

class Fantasy extends StatelessWidget {
  const Fantasy({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => FantasyCubit(),
      child: const _DriverSelectionView(),
    );
  }
}

class _DriverSelectionView extends StatelessWidget {
  const _DriverSelectionView();

  static const _darkBg = Color(0xFF0F0F10);
  static const _f1Red = Color(0xFFE10600);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: _darkBg,
      appBar: AppBar(
        backgroundColor: _darkBg,
        automaticallyImplyLeading: false,
        title: Text(
          l10n.fantasyPickYourTeam,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontFamily: 'TitilliumWeb',
          ),
        ),
        actions: [
          // Trash — disabled when team is empty
          BlocBuilder<FantasyCubit, FantasyState>(
            builder: (context, state) {
              return IconButton(
                tooltip: l10n.fantasyClearTeam,
                onPressed: state.selectedDrivers.isEmpty
                    ? null
                    : () => context.read<FantasyCubit>().clearTeam(),
                icon: Icon(
                  Icons.delete_outline,
                  color: state.selectedDrivers.isEmpty
                      ? Colors.white24
                      : Colors.white54,
                ),
              );
            },
          ),

          Builder(
            builder: (context) => IconButton(
              tooltip: l10n.fantasyMyTeam,
              onPressed: () => _goToMyTeam(context),
              icon: const Icon(Icons.sports_score, color: _f1Red),
            ),
          ),
          // Save — only active when team is complete and not yet saved
          BlocBuilder<FantasyCubit, FantasyState>(
            builder: (context, state) {
              return IconButton(
                tooltip: state.isSaved
                    ? l10n.fantasyTeamSaved
                    : l10n.fantasySaveTeam,
                onPressed: !state.isComplete || state.isSaved
                    ? null
                    : () async {
                        await context.read<FantasyCubit>().saveTeam();
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                l10n.fantasyTeamSavedSnackbar,
                                style: const TextStyle(
                                  fontFamily: 'TitilliumWeb',
                                ),
                              ),
                              backgroundColor: const Color(0xFF229971),
                            ),
                          );
                        }
                      },
                icon: Icon(
                  state.isSaved ? Icons.check_circle : Icons.save_outlined,
                  color: !state.isComplete
                      ? Colors.white24
                      : state.isSaved
                      ? const Color(0xFF229971)
                      : _f1Red,
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // state chips + linear progress bar
          BudgetBanner(),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric( vertical: 8),
              // fake data till true data is available
              itemCount: FantasyDriverData.drivers.length,
              itemBuilder: (context, index) {
                final driver = FantasyDriverData.drivers[index];
                return DriverCard(driver: driver);
              },
            ),
          ),
        ],
      ),
    );
  }

  // Navigates to MyTeamScreen while passing the SAME cubit instance.
  // We can't just push a new route because the new screen would be in a
  // separate widget tree with no access to the existing cubit.
  // BlocProvider.value injects the already-created cubit into the new route
  // so both screens share the same data (same selected drivers, same budget).
  void _goToMyTeam(BuildContext context) {
    final cubit = context.read<FantasyCubit>();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) =>
            BlocProvider.value(value: cubit, child: const MyTeamScreen()),
      ),
    );
  }
}
