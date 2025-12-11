import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formula1_fantasy/f1/cubit/profile_cubit.dart';
import 'package:formula1_fantasy/f1/cubit/profile_states.dart';
import 'package:formula1_fantasy/f1/data/models/news_model.dart';
import 'package:formula1_fantasy/f1/data/models/race_details_model.dart';
import 'package:formula1_fantasy/f1/data/models/race_info_model.dart';
import 'package:formula1_fantasy/f1/data/remote/f1_api.dart';
import 'package:formula1_fantasy/f1/presentation/screens/raceDetails/race_details.dart';
import 'package:formula1_fantasy/f1/presentation/widgets/news_card_widget.dart';
import 'package:formula1_fantasy/f1/presentation/widgets/race_widget.dart';
import 'package:formula1_fantasy/routes/routes.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  RaceInfoModel? latestRace;
  RaceInfoModel? nextRace;
  RaceDetails? raceDetails;

  bool loading = true;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  // Fetch the race data
  fetchData() async {
    try {
      final latest = await F1Api.fetchLatestRace();
      final next = await F1Api.fetchNextRace(); // This fetches the next race
      final details = await F1Api.fetchLatestRaceDetails();

      setState(() {
        latestRace = latest;
        nextRace = next;
        raceDetails = details;
        loading = false;
      });
    } catch (e) {
      setState(() {
        loading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to load data: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    List<NewsModel> news = [
      NewsModel(
        title: "Lando Norris Wins 2025 F1 World Championship",
        subtitle:
        "Lando Norris finishes 3rd in the 2025 Abu Dhabi GP, but his consistent performance throughout the season secured him the 2025 World Championship title, becoming the first British driver to win the championship since Lewis Hamilton.",
        imgUrl:
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR5w31MEtn1GlJl8UpGyMEts8O_2RfgaSfJaA&s",
      ),
      NewsModel(
        title: "Max Verstappen Wins 2025 Abu Dhabi GP",
        subtitle:
        "Max Verstappen claimed his second victory of the 2025 season at the Abu Dhabi Grand Prix, securing a remarkable win at the Yas Marina Circuit. He is now only 2 points behind in the World Championship standings, setting up an exciting finale to the season.",
        imgUrl:
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR7UmFDDWZMcYMZ_BEQJALJiqvHyk2JZwRK8g&s",
      ),
      NewsModel(
        title: "McLaren Disqualified from the Race",
        subtitle:
        "McLaren removed from 2025 Las Vegas GP results after both cars failed post‑race inspection — skid‑block wear below the 9 mm minimum triggered disqualification.",
        imgUrl:
        "https://fansbrands.com/cdn/shop/articles/mclaren_auto_7_2a3f8809-05b4-437b-b723-51f073965a6f.jpg?v=1758158815&width=1600",
      ),
      NewsModel(
        title:
        "Verstappen Wins Las Vegas GP After McLaren Double Disqualification",
        subtitle:
        "Max Verstappen claimed victory at the 2025 Las Vegas Grand Prix after both McLaren cars were excluded post‑race due to excessive skid‑block wear.",
        imgUrl:
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTjpV1F7rqrWdCIkGMuIeCHwGSiCd5cryJ8uA&s",
      ),

      NewsModel(
        title: "McLaren Issues Apology Following Double DSQ in Vegas",
        subtitle:
        "McLaren acknowledged the disqualification of Lando Norris and Oscar Piastri was unintentional, citing unexpected plank wear due to circuit conditions in Las Vegas.",
        imgUrl:
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQjKiGrxsacYpo3C8vcMzND84FD5JJlpwV0lw&s",
      ),

      NewsModel(
        title: "Championship Shake‑Up: Norris’ Lead Cut After Vegas DSQ",
        subtitle:
        "With the Las Vegas Grand Prix results voided for McLaren, the title battle tightens — Verstappen now closes in, while Piastri moves level on points.",
        imgUrl:
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSHsT6HaaMfpwEqoFY6avgFJe_9fnl7uAiioA&s",
      ),

      NewsModel(
        title: "Full Vegas GP Results: Russell and Antonelli Promote to Podium",
        subtitle:
        "After McLaren’s exclusion, George Russell and Kimi Antonelli were elevated to 2nd and 3rd place respectively in the adjusted 2025 Las Vegas Grand Prix standings.",
        imgUrl:
        "https://cdn-5.motorsport.com/images/amp/0mb4DnG2/s1000/andrea-kimi-antonelli-mercedes.jpg",
      ),
    ];
    const f1Red = Color(0xFFE10600);
    const gray = Color(0xFF424242);
    const darkBg = Color(0xFF0F0F10);

    // If the data is still loading, show a loading spinner
    if (loading) {
      return const Center(child: CircularProgressIndicator(color: f1Red));
    }


    return Scaffold(
      backgroundColor: darkBg,
      body: RefreshIndicator( color: f1Red,
        onRefresh: (){
        fetchData();

        return Future.delayed(Duration(seconds: 1));
      },child: ListView(
        children: [
          // Display user profile and greeting
          Row(
            children: [
              Text(
                "Hello",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  fontFamily: "TitilliumWeb",
                ),
              ),
              SizedBox(width: 5),
              BlocBuilder<ProfileCubit, ProfileStates>(
                builder: (context, state) {
                  if (state is ProfileSuccessState) {
                    return Text(
                      "${state.profileModel.name}",
                      style: TextStyle(
                        color: Colors.yellow,
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                        fontFamily: "TitilliumWeb",
                      ),
                    );
                  }
                  if (state is ProfileErrorState) {
                    return Text("Guest", style: TextStyle(color: Colors.yellow, fontSize: 23));
                  }
                  return SizedBox.shrink(); // Fallback if profile state is loading
                },
              ),
              SizedBox(width: 10),
              Icon(Icons.sports_motorsports, color: Colors.white, size: 30),
            ],
          ),
          SizedBox(height: 20),
          const Text(
            "Latest Race Result",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontFamily: 'TitilliumWeb',
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          RaceCardWidget(
            title: latestRace!.title,
            color: f1Red,
            subtitle:
            '${latestRace!.location} • ${latestRace!.circuit} • ${latestRace!.date}',
            result: 'Winner: ${latestRace!.winner} (${latestRace!.team})',
            onTap: () async {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => RaceDetailsScreen(race: raceDetails!),
                ),
              );
            },
          ),

          const SizedBox(height: 30),
          const Text(
            "Upcoming Race",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontFamily: 'TitilliumWeb',
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),

          nextRace != null && nextRace!.title != 'No upcoming race'
              ? RaceCardWidget(
            title: nextRace!.title,
            color: gray,
            subtitle: '${nextRace!.location} • ${nextRace!.circuit} • ${nextRace!.date}',
            result: "Upcoming",
          )
              : Card(
            color: gray,
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Padding(
              padding: EdgeInsets.all(20.0),
              child: Center(
                child: Text(
                  "The F1 season for this year has concluded. See you next year!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Latest F1 News",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontFamily: 'TitilliumWeb',
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, Routes.news, arguments: news);
                },
                child: Text("See More", style: TextStyle(color: f1Red)),
              ),
            ],
          ),
          const SizedBox(height: 12),
          NewsCardWidget(onTap: () {}, model: news[0]),
          const SizedBox(height: 30),
        ],
      ),)
    );
  }
}
