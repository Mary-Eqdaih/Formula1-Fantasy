import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formula1_fantasy/f1/data/local/translations.dart';

import '../../cubit/fantasy_states.dart';
import '../../data/models/fantasy_model.dart';
import '../../cubit/fantasy_cubit.dart';

class DriverCard extends StatelessWidget {
  final FantasyDriversModel driver;
  DriverCard({required this.driver});

  static const _selectedBg = Color(0xFF18191A);
  static const _unselectedBg = Color(0xFF18191A);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FantasyCubit, FantasyState>(
      builder: (context, state) {
        final isSelected = state.isSelected(driver.id);
        final canAfford = state.remaining >= driver.price;
        final isFull = state.selectedDrivers.length >= 5;
        final isDisabled = !isSelected && (isFull || !canAfford);
        final teamColor = _hexColor(driver.teamColor);

        return GestureDetector(
          onTap: isDisabled
              ? null
              : () => context.read<FantasyCubit>().toggleDriver(driver),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            margin: const EdgeInsets.symmetric(vertical: 6),
            decoration: BoxDecoration(
              color: isSelected ? _selectedBg : _unselectedBg,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isSelected ? teamColor : Colors.white.withOpacity(0.06),
                width: 1.5,
              ),
            ),
            child: Opacity(
              opacity: isDisabled ? 0.4 : 1.0,
              child: Row(
                children: [
                  // Team color stripe
                  Container(
                    width: 4,
                    height: 72,
                    decoration: BoxDecoration(
                      color: teamColor,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        bottomLeft: Radius.circular(12),
                      ),
                    ),
                  ),
                  // Number
                  Container(
                    width: 40,
                    alignment: Alignment.center,
                    child: Text(
                      driver.number.toString(),
                      style: TextStyle(
                        color: teamColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        fontFamily: 'TitilliumWeb',
                      ),
                    ),
                  ),
                  // Photo
                  SizedBox(
                    width: 56,
                    height: 56,
                    child: Image.network(
                      driver.imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => const Icon(
                        Icons.person,
                        color: Colors.white38,
                        size: 32,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Name & team — translated
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
                        const SizedBox(height: 2),
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
                  ),
                  // Price
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Text(
                      '\$${driver.price.toStringAsFixed(1)}M',
                      style: const TextStyle(
                        color: Colors.white54,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'TitilliumWeb',
                      ),
                    ),
                  ),
                  // Check icon
                  Padding(
                    padding: const EdgeInsets.only(right: 12,left: 12),
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 200),
                      child: isSelected
                          ? Icon(
                              Icons.check_circle,
                              key: const ValueKey('checked'),
                              color: teamColor,
                              size: 24,
                            )
                          : const Icon(
                              Icons.add_circle_outline,
                              key: ValueKey('unchecked'),
                              color: Colors.white24,
                              size: 24,
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Color _hexColor(String hex) {
    final h = hex.replaceAll('#', '');
    return Color(int.parse('FF$h', radix: 16));
  }
}
