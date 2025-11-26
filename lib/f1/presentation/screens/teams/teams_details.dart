import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:formula1_fantasy/f1/data/models/teams_model.dart';
import 'package:formula1_fantasy/f1/presentation/providers/f1_provider.dart';
import 'package:formula1_fantasy/f1/presentation/widgets/driver_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class TeamDetails extends StatefulWidget {
  const TeamDetails({super.key});

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
    // Fetch after first frame so ModalRoute is available.
    // Runs once when the screen is first created.
    // Uses ModalRoute.of(context) to access the arguments passed when navigating to this page (the
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final team = ModalRoute.of(context)!.settings.arguments as TeamsModel;
      context.read<F1Provider>().fetchDriversFor(team.constructorId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final team = ModalRoute.of(context)!.settings.arguments as TeamsModel;
    final provider = context.watch<F1Provider>();
    final drivers = provider.driversFor(team.constructorId);

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
            Image.asset(team.carImage),

            SizedBox(height: 20),
            Container(
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
                        SizedBox(height: 6),
                        Text(
                          " points : ${team.points}",
                          style: TextStyle(color: Colors.white),
                        ),
                        TextButton.icon(
                          onPressed: () {
                            openWikipedia(team);
                          },
                          icon: const Icon(
                            Icons.open_in_new,
                            size: 16,
                            color: Colors.white70,
                          ),
                          label: const Text(
                            'See more',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'TitilliumWeb',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: TeamDetails.f1Red.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: TeamDetails.f1Red.withOpacity(0.35),
                      ),
                    ),
                    child: const Text(
                      'Selected Team',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontFamily: 'TitilliumWeb',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),
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

            if (drivers.isEmpty)
              const SizedBox.shrink()
            else
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: drivers.length,
                separatorBuilder: (_, __) => const SizedBox(height: 20),
                itemBuilder: (_, i) => DriverWidget(model: drivers[i]),
              ),
          ],
        ),
      ),
    );
  }

  Future<void> openWikipedia(TeamsModel team) async {
    final primary = Uri.tryParse(team.url);
    final uri =
        primary ??
        Uri.parse(
          'https://en.wikipedia.org/w/index.php?search=${Uri.encodeComponent(team.teamName)}',
        );

    await launchUrl(uri, mode: LaunchMode.inAppBrowserView);
  }
}
