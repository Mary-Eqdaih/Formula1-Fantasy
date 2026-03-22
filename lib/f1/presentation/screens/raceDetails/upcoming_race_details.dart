import 'package:flutter/material.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../data/models/race_info_model.dart';

class UpcomingRaceDetailsScreen extends StatelessWidget {
  final RaceInfoModel race;
  const UpcomingRaceDetailsScreen({super.key, required this.race});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    const darkBg = Color(0xFF0F0F10);
    const cardBg = Color(0xFF1A1A1B);
    const f1Red = Color(0xFFE10600);

    return Scaffold(
      backgroundColor: darkBg,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 220,
            pinned: true,
            backgroundColor: darkBg,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: () => Navigator.pop(context),
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
                        colors: [Color(0xFF1E0000), Color(0xFF0F0F10)],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Container(height: 3, color: f1Red),
                  ),
                  Positioned(
                    bottom: 24,
                    left: 20,
                    right: 20,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: f1Red,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            l10n.upcomingRaceBadge,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'TitilliumWeb',
                              letterSpacing: 1.5,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          race.title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'TitilliumWeb',
                            height: 1.1,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            const Icon(
                              Icons.location_on,
                              color: f1Red,
                              size: 14,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              "${race.locality} , ${race.country}",
                              style: const TextStyle(
                                color: Colors.white60,
                                fontSize: 13,
                                fontFamily: 'TitilliumWeb',
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Race date card
                  _InfoCard(
                    cardBg: cardBg,
                    child: Row(
                      children: [
                        _iconBox(Icons.flag_rounded, f1Red),
                        const SizedBox(width: 14),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              l10n.upcomingRaceDate,
                              style: const TextStyle(
                                color: Colors.white38,
                                fontSize: 11,
                                fontFamily: 'TitilliumWeb',
                                letterSpacing: 1.2,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              _formatDate(race.date),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'TitilliumWeb',
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        _CountdownBadge(raceDate: race.date, l10n: l10n),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Circuit card
                  _InfoCard(
                    cardBg: cardBg,
                    child: Row(
                      children: [
                        _iconBox(Icons.circle_outlined, f1Red),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                l10n.upcomingCircuit,
                                style: const TextStyle(
                                  color: Colors.white38,
                                  fontSize: 11,
                                  fontFamily: 'TitilliumWeb',
                                  letterSpacing: 1.2,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                race.circuit,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'TitilliumWeb',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Weekend schedule
                  Text(
                    l10n.upcomingWeekendSchedule,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'TitilliumWeb',
                      letterSpacing: 1.5,
                    ),
                  ),
                  Container(
                    height: 2,
                    width: 40,
                    color: f1Red,
                    margin: const EdgeInsets.only(top: 4, bottom: 16),
                  ),
                  _InfoCard(
                    cardBg: cardBg,
                    child: Column(
                      children: [
                        if (race.fp1Date != null)
                          _SessionRow(
                            label: l10n.upcomingPractice1,
                            date: race.fp1Date!,
                            icon: Icons.timer_outlined,
                            isLast:
                                race.fp2Date == null &&
                                race.sprintQualiDate == null,
                          ),
                        if (race.fp2Date != null)
                          _SessionRow(
                            label: l10n.upcomingPractice2,
                            date: race.fp2Date!,
                            icon: Icons.timer_outlined,
                            isLast:
                                race.sprintQualiDate == null &&
                                race.qualiDate == null,
                          ),
                        if (race.sprintQualiDate != null)
                          _SessionRow(
                            label: l10n.upcomingSprintQualifying,
                            date: race.sprintQualiDate!,
                            icon: Icons.bolt,
                            accentColor: const Color(0xFFFF8C00),
                            isLast: race.sprintDate == null,
                          ),
                        if (race.sprintDate != null)
                          _SessionRow(
                            label: l10n.upcomingSprintRace,
                            date: race.sprintDate!,
                            icon: Icons.bolt,
                            accentColor: const Color(0xFFFF8C00),
                            isLast: race.qualiDate == null,
                          ),
                        if (race.qualiDate != null)
                          _SessionRow(
                            label: l10n.upcomingQualifying,
                            date: race.qualiDate!,
                            icon: Icons.speed,
                            accentColor: Colors.amber,
                            isLast: true,
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Race day highlight
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          f1Red.withOpacity(0.15),
                          f1Red.withOpacity(0.05),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: f1Red.withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.emoji_events, color: f1Red, size: 32),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                l10n.upcomingRaceDay,
                                style: const TextStyle(
                                  color: f1Red,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'TitilliumWeb',
                                  letterSpacing: 1.5,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                _formatDate(race.date),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'TitilliumWeb',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
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

  Widget _iconBox(IconData icon, Color color) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(icon, color: color, size: 20),
    );
  }

  String _formatDate(String? date) {
    if (date == null || date == 'N/A') return 'TBA';
    try {
      final d = DateTime.parse(date);
      const months = [
        'Jan',
        'Feb',
        'Mar',
        'Apr',
        'May',
        'Jun',
        'Jul',
        'Aug',
        'Sep',
        'Oct',
        'Nov',
        'Dec',
      ];
      return '${d.day} ${months[d.month - 1]} ${d.year}';
    } catch (_) {
      return date;
    }
  }
}

class _InfoCard extends StatelessWidget {
  final Widget child;
  final Color cardBg;
  const _InfoCard({required this.child, required this.cardBg});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.06)),
      ),
      child: child,
    );
  }
}

class _SessionRow extends StatelessWidget {
  final String label;
  final String date;
  final IconData icon;
  final Color accentColor;
  final bool isLast;

  const _SessionRow({
    required this.label,
    required this.date,
    required this.icon,
    this.accentColor = const Color(0xFFE10600),
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    String formattedDate = date;
    try {
      final d = DateTime.parse(date);
      const months = [
        'Jan',
        'Feb',
        'Mar',
        'Apr',
        'May',
        'Jun',
        'Jul',
        'Aug',
        'Sep',
        'Oct',
        'Nov',
        'Dec',
      ];
      const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
      formattedDate = '${days[d.weekday - 1]}, ${d.day} ${months[d.month - 1]}';
    } catch (_) {}

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Row(
            children: [
              Container(
                width: 3,
                height: 36,
                decoration: BoxDecoration(
                  color: accentColor,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 14),
              Icon(icon, color: accentColor, size: 18),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  label,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'TitilliumWeb',
                  ),
                ),
              ),
              Text(
                formattedDate,
                style: const TextStyle(
                  color: Colors.white60,
                  fontSize: 13,
                  fontFamily: 'TitilliumWeb',
                ),
              ),
            ],
          ),
        ),
        if (!isLast)
          Divider(
            color: Colors.white.withOpacity(0.07),
            height: 1,
            thickness: 1,
          ),
      ],
    );
  }
}

class _CountdownBadge extends StatelessWidget {
  final String raceDate;
  final AppLocalizations l10n;
  const _CountdownBadge({required this.raceDate, required this.l10n});

  @override
  Widget build(BuildContext context) {
    try {
      final race = DateTime.parse(raceDate);
      final now = DateTime.now();
      final diff = race.difference(now);
      if (diff.isNegative) return _badge(l10n.upcomingDone, Colors.white24);
      final days = diff.inDays;
      if (days == 0) return _badge(l10n.upcomingToday, const Color(0xFFE10600));
      if (days == 1)
        return _badge(l10n.upcomingTomorrow, const Color(0xFFFF8C00));
      return _badge(
        '$days days',
        const Color(0xFF1A3A1A),
        textColor: const Color(0xFF4CAF50),
      );
    } catch (_) {
      return const SizedBox.shrink();
    }
  }

  Widget _badge(String text, Color bg, {Color textColor = Colors.white}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontSize: 12,
          fontWeight: FontWeight.bold,
          fontFamily: 'TitilliumWeb',
        ),
      ),
    );
  }
}
