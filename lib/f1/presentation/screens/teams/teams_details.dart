import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:formula1_fantasy/f1/cubit/drivers_cubit.dart';
import 'package:formula1_fantasy/f1/cubit/drivers_states.dart';
import 'package:formula1_fantasy/f1/data/models/teams_model.dart';
import 'package:formula1_fantasy/f1/presentation/widgets/driver_widget.dart';
import 'package:url_launcher/url_launcher.dart';

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

    return Scaffold(
      backgroundColor: TeamDetails.darkBg,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: TeamDetails.darkBg,
        elevation: 0,
        title: const Text(
          'Team Details',
          style: TextStyle(fontFamily: 'TitilliumWeb', color: Colors.white),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Image.asset(widget.model.carImage),
            const SizedBox(height: 20),

            teamCard(widget.model),
            const SizedBox(height: 25),

            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Drivers',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.95),
                  fontFamily: 'TitilliumWeb',
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(height: 10),

            BlocBuilder<DriversCubit,DriversStates>(
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
                      "Failed to load drivers...",
                      style: const TextStyle(color: Colors.red),
                    ),
                  );
                }

                if (state is DriversSuccessState) {
                  final drivers =
                      state.driversByTeam[widget.model.constructorId] ?? [];

                  if (drivers.isEmpty) {
                    return const Center(
                      child: Text(
                        "No drivers available",
                        style: TextStyle(color: Colors.white70),
                      ),
                    );
                  }

                  return ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: drivers.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 20),
                    itemBuilder: (_, i) => DriverWidget(model: drivers[i]),
                  );
                }

                return const SizedBox(); // Initial state
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget teamCard(TeamsModel team) {
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
            width: 70,
            height: 70,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: team.logo.endsWith('.svg')
                ? SvgPicture.asset(team.logo, fit: BoxFit.contain)
                : Image.asset(team.logo, fit: BoxFit.contain),
          ),
          const SizedBox(width: 30),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  team.teamName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontFamily: 'TitilliumWeb',
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  team.nationality,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontFamily: 'TitilliumWeb',
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  "Points: ${team.points}",
                  style: const TextStyle(color: Colors.white),
                ),
                Align(
                  alignment: AlignmentGeometry.bottomRight,
                  child: TextButton.icon(
                    onPressed: () => openWikipedia(team),
                    icon: const Icon(Icons.open_in_new,
                        size: 16, color: Colors.white70),
                    label: const Text(
                      'See more',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'TitilliumWeb',
                        fontWeight: FontWeight.w700,
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
    final uri = Uri.tryParse(team.url) ??
        Uri.parse(
          "https://en.wikipedia.org/w/index.php?search=${Uri.encodeComponent(team.teamName)}",
        );

    await launchUrl(uri, mode: LaunchMode.inAppBrowserView);
  }
}
