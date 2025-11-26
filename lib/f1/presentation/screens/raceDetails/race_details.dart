import 'package:flutter/material.dart';
import 'package:formula1_fantasy/f1/data/models/race_details_model.dart';

class RaceDetailsScreen extends StatelessWidget {
  final RaceDetails race;

  const RaceDetailsScreen({super.key, required this.race});

  static const darkBg = Color(0xFF0F0F10);
  static const cardColor = Color(0xFF18191A);
  static const f1Red = Color(0xFFE10600);

  @override
  Widget build(BuildContext context) {
    final dateStr =
        '${race.dateTime.year}-${race.dateTime.month.toString().padLeft(2, '0')}-${race.dateTime.day.toString().padLeft(2, '0')}';

    return Scaffold(
      backgroundColor: darkBg,
      appBar: AppBar(
        backgroundColor: darkBg,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          race.raceName,
          style: const TextStyle(
            color: Colors.white,
            fontFamily: 'TitilliumWeb',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 📌 معلومات عامة عن السباق
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: f1Red.withOpacity(0.3)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${race.circuit.circuitName}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontFamily: 'TitilliumWeb',
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${race.circuit.locality}, ${race.circuit.country}',
                    style: const TextStyle(
                      color: Colors.white70,
                      fontFamily: 'TitilliumWeb',
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Season: ${race.season}  •  Round: ${race.round}',
                    style: const TextStyle(
                      color: Colors.white70,
                      fontFamily: 'TitilliumWeb',
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Date: $dateStr',
                    style: const TextStyle(
                      color: Colors.white70,
                      fontFamily: 'TitilliumWeb',
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            const Text(
              'Race Results',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'TitilliumWeb',
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 12),

            // 🏁 قائمة النتائج
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: race.results.length,
              separatorBuilder: (_, __) => const SizedBox(height: 15),
              itemBuilder: (context, index) {
                final result = race.results[index];
                final isPodium = result.position <= 3;

                return Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: cardColor,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isPodium
                          ? f1Red.withOpacity(0.6)
                          : Colors.white24,
                    ),
                  ),
                  child: Row(
                    children: [
                      // Position
                      Container(
                        width: 32,
                        height: 32,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: isPodium
                              ? f1Red.withOpacity(0.9)
                              : Colors.white10,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          '${result.position}',
                          style: TextStyle(
                            color: isPodium ? Colors.white : Colors.white70,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'TitilliumWeb',
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),

                      // Driver + team + status
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              result.driver.fullName,
                              style: const TextStyle(
                                color: Colors.white,
                                fontFamily: 'TitilliumWeb',
                                fontWeight: FontWeight.w700,
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${result.constructor.name} • Grid: ${result.grid} • Laps: ${result.laps}',
                              style: const TextStyle(
                                color: Colors.white70,
                                fontFamily: 'TitilliumWeb',
                                fontSize: 15,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Status: ${result.status}',
                              style: const TextStyle(
                                color: Colors.white60,
                                fontFamily: 'TitilliumWeb',
                                fontSize: 15,
                              ),
                            ),
                            if (result.fastestLapTime != null)
                              Text(
                                'Fastest Lap: ${result.fastestLapTime} (P${result.fastestLapRank})',
                                style: const TextStyle(
                                  color: Colors.white60,
                                  fontFamily: 'TitilliumWeb',
                                  fontSize: 15,
                                ),
                              ),
                          ],
                        ),
                      ),

                      // Points
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '${result.points} PTS',
                            style: const TextStyle(
                              color: Colors.white,
                              fontFamily: 'TitilliumWeb',
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          if (result.finishTime != null)
                            Text(
                              result.finishTime!,
                              style: const TextStyle(
                                color: Colors.white70,
                                fontFamily: 'TitilliumWeb',
                                fontSize: 11,
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
