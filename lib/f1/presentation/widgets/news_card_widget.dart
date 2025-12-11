import 'package:flutter/material.dart';
import 'package:formula1_fantasy/f1/data/models/news_model.dart';
class NewsCardWidget extends StatelessWidget {// New parameter for image URL
  final VoidCallback onTap;
  final NewsModel model;

  const NewsCardWidget({
    Key? key,

    required this.onTap, required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Card(
        color: Color(0xFF424242),
        child: InkWell(
          onTap: onTap,
          child: Column(
            children: [
              Container(
                height: 150,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(model.imgUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              ListTile(
                // contentPadding: EdgeInsetsGeometry.all(10),
                title: Text(
                  model.title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: "TitilliumWeb",
                  ),
                ),
                subtitle: Text(
                  model.subtitle,
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                    fontFamily: "TitilliumWeb",
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }}
