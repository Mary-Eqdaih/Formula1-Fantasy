import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:formula1_fantasy/f1/data/models/news_model.dart';
import 'package:formula1_fantasy/f1/presentation/widgets/news_card_widget.dart';


class News extends StatelessWidget {
  const News({super.key});

  @override
  Widget build(BuildContext context) {
    final List<NewsModel> newsList =
        ModalRoute.of(context)!.settings.arguments as List<NewsModel>;
    const darkBg = Color(0xFF0F0F10);
    return Scaffold(

      backgroundColor: darkBg,
      appBar: AppBar(
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: Padding(
            padding: EdgeInsetsGeometry.symmetric(vertical: 10,horizontal: 16 ),
            child: Align(
              alignment: AlignmentGeometry.topLeft,
              child: const Text(
                "Latest News",
                style: TextStyle(
                  fontFamily: 'TitilliumWeb',
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),

        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
        backgroundColor: darkBg,
        elevation: 0,
        title: Row(
          children: [
            SvgPicture.asset('assets/images/F1_logo.svg', height: 28),
            const SizedBox(width: 8),
            const Text(
              "Fantasy",
              style: TextStyle(
                fontFamily: 'TitilliumWeb',
                fontWeight: FontWeight.bold,
                fontSize: 22,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: newsList.length,
          itemBuilder: (BuildContext context, int index) {
            final newsItem = newsList[index]; // Get the individual news item
            return NewsCardWidget(
              onTap: () {},
              model: newsItem,
            );
          },
        ),
      ),
    );
  }
}
