import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formula1_fantasy/f1/data/local/translations.dart';
import '../../cubit/fantasy_cubit.dart';
import '../../data/models/fantasy_model.dart';

class TeamDriverTile extends StatelessWidget {
  final FantasyDriversModel driver;
  final int position;
  const TeamDriverTile({required this.driver, required this.position});

  @override
  Widget build(BuildContext context) {
    final teamColor = _hexColor(driver.teamColor);

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF18191A),
        borderRadius: BorderRadius.circular(12),
        border: Border(left: BorderSide(color: teamColor, width: 3)),
      ),
      child: Row(
        children: [
          // Position badge
          Container(
            width: 28,
            height: 28,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: teamColor.withOpacity(0.15),
              shape: BoxShape.circle,
            ),
            child: Text(
              '$position',
              style: TextStyle(
                color: teamColor,
                fontWeight: FontWeight.bold,
                fontSize: 13,
                fontFamily: 'TitilliumWeb',
              ),
            ),
          ),
          const SizedBox(width: 12),
          // Driver photo
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: SizedBox(
              width: 48,
              height: 48,
              child: Image.network(
                driver.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) =>
                    const Icon(Icons.person, color: Colors.white38),
              ),
            ),
          ),
          const SizedBox(width: 12),
          // Name & team — both translated
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  translateDriver(context, driver.name),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    fontFamily: 'TitilliumWeb',
                  ),
                ),
                const SizedBox(height: 3),
                Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      margin: const EdgeInsets.only(right: 5),
                      decoration: BoxDecoration(
                        color: teamColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                    Text(
                      translateTeam(context, driver.team),
                      style: const TextStyle(
                        color: Colors.white54,
                        fontSize: 12,
                        fontFamily: 'TitilliumWeb',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Price tag
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFF0F0F10),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '\$${driver.price.toStringAsFixed(1)}M',
              style: const TextStyle(
                color: Colors.white54,
                fontSize: 12,
                fontWeight: FontWeight.w600,
                fontFamily: 'TitilliumWeb',
              ),
            ),
          ),
          // Remove button
          const SizedBox(width: 8),
          GestureDetector(
            onTap: () => context.read<FantasyCubit>().toggleDriver(driver),
            child: const Icon(
              Icons.remove_circle_outline,
              color: Color(0xFFE10600),
              size: 22,
            ),
          ),
        ],
      ),
    );
  }

  Color _hexColor(String hex) {
    final h = hex.replaceAll('#', '');
    return Color(int.parse('FF$h', radix: 16));
  }
}
