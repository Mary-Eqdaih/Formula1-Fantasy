import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../cubit/fantasy_cubit.dart';
import '../../../cubit/fantasy_states.dart';
import '../../widgets/empty_team.dart';
import '../../widgets/fantasy_driver_tile.dart';
import '../../widgets/fantasy_status_badge.dart';
import '../../widgets/fantasy_summary_header.dart';

class MyTeamScreen extends StatelessWidget {
  const MyTeamScreen({super.key});

  static const _darkBg = Color(0xFF0F0F10);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: _darkBg,
      appBar: AppBar(
        backgroundColor: _darkBg,
        title: Text(
          l10n.myTeamTitle,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontFamily: 'TitilliumWeb',
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: BlocBuilder<FantasyCubit, FantasyState>(
        builder: (context, state) {
          if (state.selectedDrivers.isEmpty) return const EmptyTeam();
          return Column(
            children: [
              TeamSummaryHeader(state: state),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: state.selectedDrivers.length,
                  itemBuilder: (context, index) => TeamDriverTile(
                    driver: state.selectedDrivers[index],
                    position: index + 1,
                  ),
                ),
              ),
              if (state.isComplete) TeamStatusBadge(isSaved: state.isSaved),
            ],
          );
        },
      ),
    );
  }
}
