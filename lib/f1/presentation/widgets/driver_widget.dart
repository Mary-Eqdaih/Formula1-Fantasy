import 'package:flutter/material.dart';
import 'package:formula1_fantasy/f1/data/models/driver_model.dart';
import 'package:url_launcher/url_launcher.dart';

class DriverWidget extends StatelessWidget {
  const DriverWidget({super.key, required this.model});

  final DriverModel model;

  static const cardColor = Color(0xFF18191A);
  static const dark = Color(0xFF0F0F10);
  static const f1Red = Color(0xFFE10600);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: f1Red.withOpacity(0.25)),
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          CircleAvatar(
            radius: 45,
            backgroundImage: AssetImage(model.image),
          ),
          const SizedBox(width: 25),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name + points
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        model.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                          fontFamily: 'TitilliumWeb',
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                // Row to divide into two columns
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          kv('Date Of Birth', '${model.dateOfBirth}'),
                          SizedBox(height: 10),
                          kv('Permanent Number', '${model.permanentNumber}'),
                          SizedBox(height: 10),
                          kv('Nationality', '${model.nationality}'),


                        ],
                      ),
                    ),
                    const SizedBox(width: 40), // space between the columns
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 10),
                          kv('Code', '${model.code}'),
                          kv('Points', '${model.points}'),
                          SizedBox(height: 10),
                          kv('WCS', '${model.raceWins}'),
                        ],
                      ),
                    ),
                  ],
                ),

                // Align the "See more" button at the bottom-right
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton.icon(
                    onPressed: () {
                      openWikipedia(model);
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
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Widget kv(String k, String v) {
    return SizedBox(
      width: 160, // fixed width makes a neat two-column look
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            k,
            style: const TextStyle(
              color: Colors.white70,
              fontFamily: 'TitilliumWeb',
              fontSize: 11,
            ),
          ),
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
      ),
    );
  }

  Future<void> openWikipedia(DriverModel d) async {
    final primary = Uri.tryParse(d.url ?? '');
    final uri =
        primary ?? Uri.parse('https://en.wikipedia.org/w/index.php?search=${Uri.encodeComponent(d.name)}');

    await launchUrl(uri, mode: LaunchMode.inAppBrowserView);
  }

  // static String _initials(String name) {
  //   final parts = name.trim().split(RegExp(r'\s+'));
  //   if (parts.isEmpty) return '?';
  //   if (parts.length == 1) return parts.first[0].toUpperCase();
  //   return (parts.first[0] + parts.last[0]).toUpperCase();
  // }
}
