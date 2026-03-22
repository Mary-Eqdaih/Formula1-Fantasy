import 'package:flutter/material.dart';
import 'package:formula1_fantasy/f1/data/models/race_details_model.dart';
import '../../../../l10n/app_localizations.dart';

class RaceDetailsScreen extends StatelessWidget {
  final RaceDetails race;
  const RaceDetailsScreen({super.key, required this.race});

  static const darkBg = Color(0xFF0F0F10);
  static const cardColor = Color(0xFF18191A);
  static const f1Red = Color(0xFFE10600);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final dateStr =
        '${race.dateTime.year}-${race.dateTime.month.toString().padLeft(2, '0')}-${race.dateTime.day.toString().padLeft(2, '0')}';

    return Scaffold(
      backgroundColor: darkBg,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            backgroundColor: darkBg,
            elevation: 0,
            iconTheme: const IconThemeData(color: Colors.white),
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Color(0xFF2A0000), Color(0xFF0F0F10)],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 20,
                    left: 20,
                    right: 20,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            _pill('${race.season}', Colors.white12),
                            const SizedBox(width: 8),
                            _pill('ROUND ${race.round}', f1Red),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          race.raceName,
                          style: const TextStyle(
                            color: Colors.white,
                            fontFamily: 'TitilliumWeb',
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                            height: 1.1,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            const Icon(
                              Icons.location_on,
                              color: f1Red,
                              size: 13,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '${race.circuit.locality}, ${race.circuit.country}',
                              style: const TextStyle(
                                color: Colors.white60,
                                fontFamily: 'TitilliumWeb',
                                fontSize: 13,
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
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: cardColor,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: f1Red.withOpacity(0.25)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: f1Red.withOpacity(0.12),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(
                                Icons.circle_outlined,
                                color: f1Red,
                                size: 18,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                race.circuit.circuitName,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'TitilliumWeb',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            _statChip(
                              Icons.calendar_today,
                              l10n.raceDate,
                              dateStr,
                            ),
                            const SizedBox(width: 10),
                            _statChip(
                              Icons.sports_score,
                              l10n.raceSeason,
                              race.season,
                            ),
                            const SizedBox(width: 10),
                            _statChip(
                              Icons.tag,
                              l10n.raceRoundLabel,
                              race.round.toString(),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 28),
                  Row(
                    children: [
                      Text(
                        l10n.raceResultsTitle,
                        style: const TextStyle(
                          color: Colors.white,
                          fontFamily: 'TitilliumWeb',
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
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
                    width: 36,
                    color: f1Red,
                    margin: const EdgeInsets.only(top: 4, bottom: 16),
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: race.results.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 10),
                    itemBuilder: (context, index) {
                      final result = race.results[index];
                      final isPodium = result.position <= 3;
                      final medalColor = result.position == 1
                          ? const Color(0xFFFFD700)
                          : result.position == 2
                          ? const Color(0xFFC0C0C0)
                          : result.position == 3
                          ? const Color(0xFFCD7F32)
                          : null;
                      return Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: cardColor,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: isPodium
                                ? (medalColor ?? f1Red).withOpacity(0.45)
                                : Colors.white.withOpacity(0.06),
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 36,
                              height: 36,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: isPodium
                                    ? (medalColor ?? f1Red).withOpacity(0.15)
                                    : Colors.white.withOpacity(0.06),
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: isPodium
                                      ? (medalColor ?? f1Red).withOpacity(0.6)
                                      : Colors.white24,
                                  width: 1.5,
                                ),
                              ),
                              child: Text(
                                '${result.position}',
                                style: TextStyle(
                                  color: isPodium
                                      ? (medalColor ?? Colors.white)
                                      : Colors.white60,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'TitilliumWeb',
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        result.driver.fullName,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'TitilliumWeb',
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16,
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 3,
                                        ),
                                        decoration: BoxDecoration(
                                          color: result.points > 0
                                              ? f1Red.withOpacity(0.15)
                                              : Colors.white.withOpacity(0.05),
                                          borderRadius: BorderRadius.circular(
                                            6,
                                          ),
                                        ),
                                        child: Text(
                                          '${result.points} PTS',
                                          style: TextStyle(
                                            color: result.points > 0
                                                ? f1Red
                                                : Colors.white38,
                                            fontFamily: 'TitilliumWeb',
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    '${result.constructor.name}  •  Grid ${result.grid}  •  ${result.laps} laps',
                                    style: const TextStyle(
                                      color: Colors.white54,
                                      fontFamily: 'TitilliumWeb',
                                      fontSize: 13,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      _statusBadge(result.status),
                                      if (result.finishTime != null) ...[
                                        const SizedBox(width: 8),
                                        Text(
                                          result.finishTime!,
                                          style: const TextStyle(
                                            color: Colors.white38,
                                            fontFamily: 'TitilliumWeb',
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ],
                                  ),
                                  if (result.fastestLapTime != null) ...[
                                    const SizedBox(height: 4),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.timer,
                                          color: Color(0xFFBB00FF),
                                          size: 12,
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          '${result.fastestLapTime}  •  P${result.fastestLapRank}',
                                          style: const TextStyle(
                                            color: Color(0xFFBB00FF),
                                            fontFamily: 'TitilliumWeb',
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
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

  Widget _pill(String text, Color bg) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 11,
          fontWeight: FontWeight.bold,
          fontFamily: 'TitilliumWeb',
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _statChip(IconData icon, String label, String value) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.04),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.white.withOpacity(0.07)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: f1Red, size: 14),
            const SizedBox(height: 5),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white38,
                fontSize: 10,
                fontFamily: 'TitilliumWeb',
                letterSpacing: 0.8,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.bold,
                fontFamily: 'TitilliumWeb',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _statusBadge(String status) {
    final isFinished = status == 'Finished';
    final isLapped = status == 'Lapped';
    final color = isFinished
        ? const Color(0xFF1A3A1A)
        : isLapped
        ? const Color(0xFF2A2A00)
        : Colors.white.withOpacity(0.08);
    final textColor = isFinished
        ? const Color(0xFF4CAF50)
        : isLapped
        ? const Color(0xFFFFD700)
        : Colors.white38;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: textColor,
          fontSize: 11,
          fontFamily: 'TitilliumWeb',
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
