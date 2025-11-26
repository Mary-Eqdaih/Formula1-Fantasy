import 'package:flutter/material.dart';
import 'package:formula1_fantasy/f1/data/models/driver_standings_model.dart';

class LeaderboardWidget extends StatelessWidget {
  final int rank;
  final DriverStandingModel driver;

  const LeaderboardWidget({
    super.key,
    required this.rank,
    required this.driver,
  });

  @override
  Widget build(BuildContext context) {
    const baseColor = Color(0xFF18191A);
    const f1Red = Color(0xFFE10600);
    Color borderColor;
    Gradient? gradient;

    if (rank == 1) {
      borderColor = f1Red;
      gradient = const LinearGradient(
        colors: [
          Color(0xFFE10600),
          Color(0xFF3A0D11),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    } else if (rank == 2) {
      borderColor = Colors.grey.shade400;
      gradient = LinearGradient(
        colors: [
          Colors.grey.shade700,
          baseColor,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    } else if (rank == 3) {
      borderColor = const Color(0xFFCD7F32); // Bronze
      gradient = LinearGradient(
        colors: [
          const Color(0xFFCD7F32),
          baseColor,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    } else {
      borderColor = Colors.white.withOpacity(0.18);
      gradient = null;
    }

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: baseColor,
        gradient: gradient,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderColor, width: 1.2),
      ),
      child: Row(
        children: [
          // Rank badge
          Container(
            width: 36,
            height: 36,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.06),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              '$rank',
              style: const TextStyle(
                color: Colors.white,
                fontFamily: 'TitilliumWeb',
                fontWeight: FontWeight.w800,
                fontSize: 18,
              ),
            ),
          ),
          const SizedBox(width: 16),

          // Driver image
          CircleAvatar(
            radius: 26,
            backgroundImage: AssetImage(driver.image),
          ),
          const SizedBox(width: 16),

          // Name + team + code
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  driver.fullName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontFamily: 'TitilliumWeb',
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  driver.constructorName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.7),
                    fontFamily: 'TitilliumWeb',
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Code: ${driver.code}',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.5),
                    fontFamily: 'TitilliumWeb',
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),

          // Points + wins
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${driver.points} PTS',
                style: const TextStyle(
                  color: Colors.white,
                  fontFamily: 'TitilliumWeb',
                  fontWeight: FontWeight.w800,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Wins: ${driver.wins}',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.6),
                  fontFamily: 'TitilliumWeb',
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
