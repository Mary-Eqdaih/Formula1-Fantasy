import 'package:flutter/material.dart';

class RaceCardWidget extends StatelessWidget {
  const RaceCardWidget({
    super.key,
    required this.title,
    required this.color,
    required this.subtitle,
    required this.result,
    this.onTap,
    this.fp1Date,
    this.fp2Date,
    this.fp3Date,
    this.qauliDate,
  });
  final String title;
  final Color color;
  final String subtitle;
  final String result;
  final VoidCallback? onTap;
  final String? fp1Date;
  final String? fp2Date;
  final String? fp3Date;
  final String? qauliDate;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withOpacity(0.5), width: 1),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontFamily: 'TitilliumWeb',
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              subtitle,

              style: const TextStyle(
                height: 1.8,
                fontWeight: FontWeight.bold,
                fontFamily: 'TitilliumWeb',
                color: Colors.white70,
                fontSize: 14,
              ),
            ),

            const SizedBox(height: 20),
            Text(
              "First Practice : ${fp1Date}",
              style: const TextStyle(
                height: 1.8,
                fontWeight: FontWeight.bold,
                fontFamily: 'TitilliumWeb',
                color: Colors.white70,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "Second Practice : ${fp2Date}",
              style: const TextStyle(
                height: 1.8,
                fontWeight: FontWeight.bold,
                fontFamily: 'TitilliumWeb',
                color: Colors.white70,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "Third Practice : ${fp3Date}",
              style: const TextStyle(
                height: 1.8,
                fontWeight: FontWeight.bold,
                fontFamily: 'TitilliumWeb',
                color: Colors.white70,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "Qualification : ${qauliDate}",
              style: const TextStyle(
                height: 1.8,
                fontWeight: FontWeight.bold,
                fontFamily: 'TitilliumWeb',
                color: Colors.white70,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
