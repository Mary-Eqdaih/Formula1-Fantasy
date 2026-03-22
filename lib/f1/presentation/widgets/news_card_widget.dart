import 'package:flutter/material.dart';
import 'package:formula1_fantasy/f1/data/models/news_model.dart';

class NewsCardWidget extends StatelessWidget {
  final VoidCallback onTap;
  final NewsModel model;

  const NewsCardWidget({
    Key? key,
    required this.onTap,
    required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFF18191A),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: Colors.white.withOpacity(0.07)),
          ),
          clipBehavior: Clip.hardEdge,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  // Photo
                  SizedBox(
                    height: 180,
                    width: double.infinity,
                    child: Image.network(
                      model.imgUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        height: 180,
                        color: const Color(0xFF0F0F10),
                        child: const Icon(Icons.image_not_supported,
                            color: Colors.white24, size: 40),
                      ),
                    ),
                  ),
                  // Gradient so title reads over image
                  Positioned(
                    bottom: 0, left: 0, right: 0,
                    child: Container(
                      height: 60,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [Color(0xFF18191A), Colors.transparent],
                        ),
                      ),
                    ),
                  ),
                  // F1 NEWS badge
                  Positioned(
                    top: 12, left: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE10600),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text(
                        'F1 NEWS',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'TitilliumWeb',
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              // content
              Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'TitilliumWeb',
                        height: 1.3,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      model.subtitle,
                      style: const TextStyle(
                        color: Colors.white54,
                        fontSize: 13,
                        fontFamily: 'TitilliumWeb',
                        height: 1.5,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 12),

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}