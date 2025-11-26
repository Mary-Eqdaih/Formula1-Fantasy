import 'package:flutter/material.dart';
class RaceCardWidget extends StatelessWidget {
  const RaceCardWidget({super.key, required this.title, required this.color, required this.subtitle, required this.result,this.onTap});
final String title;
final Color color;
final String subtitle;
final String result;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return  InkWell(
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
              result,
              style: const TextStyle(
                fontFamily: 'TitilliumWeb',
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}



