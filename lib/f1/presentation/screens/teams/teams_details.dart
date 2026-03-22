import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:formula1_fantasy/f1/cubit/drivers_cubit.dart';
import 'package:formula1_fantasy/f1/cubit/drivers_states.dart';
import 'package:formula1_fantasy/f1/data/models/teams_model.dart';
import 'package:formula1_fantasy/f1/data/local/translations.dart';
import 'package:formula1_fantasy/f1/presentation/widgets/driver_widget.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../l10n/app_localizations.dart';

class TeamDetails extends StatefulWidget {
  const TeamDetails({super.key, required this.model});
  final TeamsModel model;

  static const darkBg = Color(0xFF0F0F10);
  static const cardColor = Color(0xFF18191A);
  static const f1Red = Color(0xFFE10600);

  @override
  State<TeamDetails> createState() => _TeamDetailsState();
}

class _TeamDetailsState extends State<TeamDetails> {
  @override
  void initState() {
    super.initState();
    // لأن context ما بيكون جاهز داخل initState
    // if i want to use ModalRoute to pass data
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   final team = ModalRoute.of(context)!.settings.arguments as TeamsModel;
    //   context.read<DriversCubit>().fetchDriversFor(team.constructorId);
    // });
    context.read<DriversCubit>().fetchDriversFor(widget.model.constructorId);
    //   widget gives you access to the data passed through the constructor.
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final team = widget.model;

    return Scaffold(
      backgroundColor: TeamDetails.darkBg,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 220,
            pinned: true,
            backgroundColor: TeamDetails.darkBg,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
            title: Text(
              l10n.teamDetailsTitle,
              style: const TextStyle(
                fontFamily: 'TitilliumWeb',
                color: Colors.white,
                fontSize: 17,
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Color(0xFF1E0000), TeamDetails.darkBg],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Container(height: 3, color: TeamDetails.f1Red),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Opacity(
                      opacity: 0.9,
                      child: Image.asset(
                        team.carImage,
                        fit: BoxFit.contain,
                        height: 160,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Body
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _teamCard(team, l10n, context),
                  const SizedBox(height: 28),
                  // Drivers section header
                  Row(
                    children: [
                      Text(
                        l10n.teamDetailsDrivers.toUpperCase(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontFamily: 'TitilliumWeb',
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Container(height: 1, color: Colors.white12),
                      ),
                    ],
                  ),
                  Container(
                    height: 2,
                    width: 32,
                    color: TeamDetails.f1Red,
                    margin: const EdgeInsets.only(top: 4,),
                  ),

                  BlocBuilder<DriversCubit, DriversStates>(
                    builder: (context, state) {
                      if (state is DriversLoadingState) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: TeamDetails.f1Red,
                          ),
                        );
                      }
                      if (state is DriversErrorState) {
                        return Center(
                          child: Text(
                            l10n.teamDetailsFailedDrivers,
                            style: const TextStyle(color: Colors.red),
                          ),
                        );
                      }
                      if (state is DriversSuccessState) {
                        final drivers =
                            state.driversByTeam[widget.model.constructorId] ??
                            [];
                        if (drivers.isEmpty) {
                          return Center(
                            child: Text(
                              l10n.teamDetailsNoDrivers,
                              style: const TextStyle(color: Colors.white70),
                            ),
                          );
                        }
                        return ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: drivers.length,
                          separatorBuilder: (_, __) =>
                              const SizedBox(height: 20),
                          itemBuilder: (_, i) =>
                              DriverWidget(model: drivers[i]),
                        );
                      }
                      return const SizedBox(); // Initial state
                    },
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _teamCard(
    TeamsModel team,
    AppLocalizations l10n,
    BuildContext context,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: TeamDetails.cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: TeamDetails.f1Red.withOpacity(0.25)),
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            width: 64,
            height: 64,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: team.logo.endsWith('.svg')
                ? SvgPicture.asset(team.logo, fit: BoxFit.contain)
                : Image.asset(team.logo, fit: BoxFit.contain),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Team name → teamsAr map
                Text(
                  translateTeam(context, team.teamName),
                  style: const TextStyle(
                    color: Colors.white,
                    fontFamily: 'TitilliumWeb',
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                // Nationality → nationalitiesAr map
                Text(
                  translateNationality(context, team.nationality),
                  style: const TextStyle(
                    color: Colors.white54,
                    fontFamily: 'TitilliumWeb',
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 8),
                // Points pill
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: TeamDetails.f1Red.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                      color: TeamDetails.f1Red.withOpacity(0.3),
                    ),
                  ),
                  child: Text(
                    '${l10n.points}: ${team.points}',
                    style: const TextStyle(
                      color: TeamDetails.f1Red,
                      fontFamily: 'TitilliumWeb',
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
                Align(
                  alignment: AlignmentGeometry.bottomRight,
                  child: TextButton.icon(
                    onPressed: () => openWikipedia(team),
                    icon: const Icon(
                      Icons.open_in_new,
                      size: 14,
                      color: Colors.white38,
                    ),
                    label: Text(
                      l10n.teamDetailsSeeMore,
                      style: const TextStyle(
                        color: Colors.white54,
                        fontFamily: 'TitilliumWeb',
                        fontSize: 13,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> openWikipedia(TeamsModel team) async {
    final uri =
        Uri.tryParse(team.url) ??
        Uri.parse(
          'https://en.wikipedia.org/w/index.php?search=${Uri.encodeComponent(team.teamName)}',
        );
    await launchUrl(uri, mode: LaunchMode.inAppBrowserView);
  }
}
