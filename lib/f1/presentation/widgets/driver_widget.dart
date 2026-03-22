import 'package:flutter/material.dart';
import 'package:formula1_fantasy/f1/data/models/driver_model.dart';
import 'package:formula1_fantasy/f1/data/local/translations.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../l10n/app_localizations.dart';

class DriverWidget extends StatelessWidget {
  const DriverWidget({super.key, required this.model});

  final DriverModel model;

  static const cardColor = Color(0xFF18191A);
  static const dark = Color(0xFF0F0F10);
  static const f1Red = Color(0xFFE10600);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Container(
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: f1Red.withOpacity(0.15)),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top row: photo + name + team pill
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: SizedBox(
                  width: 64,
                  height: 64,
                  child: Image.network(
                    model.image,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      color: Colors.white10,
                      child: const Icon(
                        Icons.person,
                        color: Colors.white38,
                        size: 32,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      translateDriver(context, model.name),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontFamily: 'TitilliumWeb',
                        fontSize: 17,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: f1Red.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: f1Red.withOpacity(0.25)),
                      ),
                      child: Text(
                        translateTeam(context, model.team),
                        style: const TextStyle(
                          color: f1Red,
                          fontFamily: 'TitilliumWeb',
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),
          const Divider(color: Colors.white12, height: 1),
          const SizedBox(height: 12),

          // info
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    kv(l10n.driverDob, '${model.dateOfBirth}'),
                    const SizedBox(height: 10),
                    kv(l10n.driverPermanentNumber, '${model.permanentNumber}'),
                    const SizedBox(height: 10),
                    kv(
                      l10n.driverNationality,
                      translateNationality(context, model.nationality),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    kv(l10n.driverCode, '${model.code}'),
                    const SizedBox(height: 10),
                    kv(l10n.driverPoints, '${model.points}'),
                    const SizedBox(height: 10),
                    kv(l10n.driverWcs, '${model.raceWins}'),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          Align(
            alignment: Alignment.centerRight,
            child: TextButton.icon(
              onPressed: () => openWikipedia(model),
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
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              ),
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Widget kv(String k, String v) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          k,
          style: const TextStyle(
            color: Colors.white38,
            fontFamily: 'TitilliumWeb',
            fontSize: 10,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          v,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: Colors.white,
            fontFamily: 'TitilliumWeb',
            fontSize: 13,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }

  Future<void> openWikipedia(DriverModel d) async {
    final primary = Uri.tryParse(d.url ?? '');
    final uri =
        primary ??
        Uri.parse(
          'https://en.wikipedia.org/w/index.php?search=${Uri.encodeComponent(d.name)}',
        );
    await launchUrl(uri, mode: LaunchMode.inAppBrowserView);
  }
}
