import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formula1_fantasy/f1/cubit/profile_cubit.dart';
import 'package:formula1_fantasy/f1/cubit/profile_states.dart';
import 'package:formula1_fantasy/f1/data/models/news_model.dart';
import 'package:formula1_fantasy/f1/data/models/race_details_model.dart';
import 'package:formula1_fantasy/f1/data/models/race_info_model.dart';
import 'package:formula1_fantasy/f1/data/remote/f1_api.dart';
import 'package:formula1_fantasy/f1/presentation/screens/raceDetails/latest_race_details.dart';
import 'package:formula1_fantasy/f1/presentation/widgets/news_card_widget.dart';
import 'package:formula1_fantasy/f1/presentation/widgets/race_widget.dart';
import 'package:formula1_fantasy/routes/routes.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../data/local/translations.dart';
import '../raceDetails/upcoming_race_details.dart';

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

  fetchData() async {
    if (!mounted) return;
    setState(() => loading = true);
    try {
      final next = await F1Api.fetchNextRace();
      if (!mounted) return;
      setState(() => nextRace = next);
      try {
        final latest = await F1Api.fetchLatestRace();
        if (!mounted) return;
        setState(() => latestRace = latest);
      } catch (_) {
        if (!mounted) return;
        setState(() => latestRace = null);
      }
      try {
        final details = await F1Api.fetchLatestRaceDetails();
        if (!mounted) return;
        setState(() => raceDetails = details);
      } catch (_) {
        if (!mounted) return;
        setState(() => raceDetails = null);
      }
    } finally {
      if (!mounted) return;
      setState(() => loading = false);
    }
  }

  // News content is static data (not ARB strings) so we handle translation
  // by keeping two separate lists and picking based on the current locale.
  List<NewsModel> _getNews(BuildContext context) {
    final isAr = Localizations.localeOf(context).languageCode == 'ar';

    if (isAr) {
      return [
        NewsModel(
          title: 'لاندو نوريس يفوز ببطولة العالم للفورمولا 1 لعام 2025',
          subtitle:
              'أنهى لاندو نوريس سباق أبوظبي في المركز الثالث، لكن أداءه المتسق طوال الموسم أهّله للفوز ببطولة العالم 2025، ليصبح أول سائق بريطاني يحقق اللقب منذ لويس هاميلتون.',
          imgUrl:
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR5w31MEtn1GlJl8UpGyMEts8O_2RfgaSfJaA&s',
        ),
        NewsModel(
          title: 'ماكس فيرستابن يفوز بسباق أبوظبي 2025',
          subtitle:
              'حقق ماكس فيرستابن انتصاره الثاني في موسم 2025 في جائزة أبوظبي الكبرى بحلبة ياس مارينا.',
          imgUrl:
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR7UmFDDWZMcYMZ_BEQJALJiqvHyk2JZwRK8g&s',
        ),
        NewsModel(
          title: 'استبعاد ماكلارين من نتائج السباق',
          subtitle:
              'أُقصيت ماكلارين من نتائج سباق لاس فيغاس 2025 بعد فشل سيارتيها في فحص ما بعد السباق.',
          imgUrl:
              'https://fansbrands.com/cdn/shop/articles/mclaren_auto_7_2a3f8809-05b4-437b-b723-51f073965a6f.jpg?v=1758158815&width=1600',
        ),
        NewsModel(
          title: 'فيرستابن يفوز بلاس فيغاس بعد الاستبعاد المزدوج لماكلارين',
          subtitle:
              'حصد ماكس فيرستابن الفوز في جائزة لاس فيغاس الكبرى 2025 إثر استبعاد سيارتَي ماكلارين.',
          imgUrl:
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTjpV1F7rqrWdCIkGMuIeCHwGSiCd5cryJ8uA&s',
        ),
        NewsModel(
          title: 'ماكلارين تعتذر عن الاستبعاد المزدوج في لاس فيغاس',
          subtitle: 'أكدت ماكلارين أن استبعاد نوريس وبياستري لم يكن مقصوداً.',
          imgUrl:
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQjKiGrxsacYpo3C8vcMzND84FD5JJlpwV0lw&s',
        ),
        NewsModel(
          title: 'تغيّر في موازين البطولة بعد استبعاد لاس فيغاس',
          subtitle:
              'مع إلغاء نتائج ماكلارين اشتدت المنافسة على اللقب وتقلّص الفارق بشكل ملحوظ.',
          imgUrl:
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSHsT6HaaMfpwEqoFY6avgFJe_9fnl7uAiioA&s',
        ),
        NewsModel(
          title: 'ترقية راسل وأنتونيلي إلى منصة التتويج في لاس فيغاس',
          subtitle:
              'عقب استبعاد ماكلارين ارتقى جورج راسل وكيمي أنتونيلي إلى المركزين الثاني والثالث.',
          imgUrl:
              'https://cdn-5.motorsport.com/images/amp/0mb4DnG2/s1000/andrea-kimi-antonelli-mercedes.jpg',
        ),
      ];
    }

    return [
      NewsModel(
        title: 'Lando Norris Wins 2025 F1 World Championship',
        subtitle:
            'Lando Norris finishes 3rd in the 2025 Abu Dhabi GP, but his consistent performance throughout the season secured him the 2025 World Championship title, becoming the first British driver to win the championship since Lewis Hamilton.',
        imgUrl:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR5w31MEtn1GlJl8UpGyMEts8O_2RfgaSfJaA&s',
      ),
      NewsModel(
        title: 'Max Verstappen Wins 2025 Abu Dhabi GP',
        subtitle:
            'Max Verstappen claimed his second victory of the 2025 season at the Abu Dhabi Grand Prix, securing a remarkable win at the Yas Marina Circuit.',
        imgUrl:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR7UmFDDWZMcYMZ_BEQJALJiqvHyk2JZwRK8g&s',
      ),
      NewsModel(
        title: 'McLaren Disqualified from the Race',
        subtitle:
            'McLaren removed from 2025 Las Vegas GP results after both cars failed post‑race inspection.',
        imgUrl:
            'https://fansbrands.com/cdn/shop/articles/mclaren_auto_7_2a3f8809-05b4-437b-b723-51f073965a6f.jpg?v=1758158815&width=1600',
      ),
      NewsModel(
        title:
            'Verstappen Wins Las Vegas GP After McLaren Double Disqualification',
        subtitle:
            'Max Verstappen claimed victory at the 2025 Las Vegas Grand Prix after both McLaren cars were excluded post‑race.',
        imgUrl:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTjpV1F7rqrWdCIkGMuIeCHwGSiCd5cryJ8uA&s',
      ),
      NewsModel(
        title: 'McLaren Issues Apology Following Double DSQ in Vegas',
        subtitle:
            'McLaren acknowledged the disqualification of Lando Norris and Oscar Piastri was unintentional.',
        imgUrl:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQjKiGrxsacYpo3C8vcMzND84FD5JJlpwV0lw&s',
      ),
      NewsModel(
        title: 'Championship Shake‑Up: Norris\' Lead Cut After Vegas DSQ',
        subtitle:
            'With the Las Vegas Grand Prix results voided for McLaren, the title battle tightens.',
        imgUrl:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSHsT6HaaMfpwEqoFY6avgFJe_9fnl7uAiioA&s',
      ),
      NewsModel(
        title: 'Full Vegas GP Results: Russell and Antonelli Promote to Podium',
        subtitle:
            'After McLaren\'s exclusion, George Russell and Kimi Antonelli were elevated to 2nd and 3rd place.',
        imgUrl:
            'https://cdn-5.motorsport.com/images/amp/0mb4DnG2/s1000/andrea-kimi-antonelli-mercedes.jpg',
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final news = _getNews(context);

    const f1Red = Color(0xFFE10600);
    const gray = Color(0xFF424242);
    const darkBg = Color(0xFF0F0F10);

    if (loading) {
      return const Center(child: CircularProgressIndicator(color: f1Red));
    }
    return Scaffold(
      backgroundColor: darkBg,
      body: RefreshIndicator(
        color: f1Red,
        onRefresh: () {
          fetchData();
          return Future.delayed(const Duration(seconds: 1));
        },
        child: ListView(
          children: [
            // Greeting
            Row(
              children: [
                Text(
                  l10n.homeHello,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'TitilliumWeb',
                  ),
                ),
                const SizedBox(width: 5),
                BlocBuilder<ProfileCubit, ProfileStates>(
                  builder: (context, state) {
                    if (state is ProfileSuccessState) {
                      return Text(
                        '${state.profileModel.name}',
                        style: const TextStyle(
                          color: Colors.yellow,
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'TitilliumWeb',
                        ),
                      );
                    }
                    if (state is ProfileErrorState) {
                      return Text(
                        l10n.homeGuest,
                        style: const TextStyle(
                          color: Colors.yellow,
                          fontSize: 23,
                        ),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
                const SizedBox(width: 10),
                const Icon(
                  Icons.sports_motorsports,
                  color: Colors.white,
                  size: 30,
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Latest race
            Text(
              l10n.homeLatestRace,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontFamily: 'TitilliumWeb',
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            if (latestRace != null && latestRace!.title != 'No upcoming race')
              RaceCardWidget(
                title: translateRaceName(context, latestRace!.title),
                color: f1Red,
                subtitle:
                    '${translateLocation(context, latestRace!.locality)} • ${translateLocation(context, latestRace!.country)} • ${translateCircuit(context, latestRace!.circuit)} • ${latestRace!.date}',
                result:
                    '${l10n.homeWinner}: ${translateDriver(context, latestRace!.winner ?? '')} (${translateTeam(context, latestRace!.team ?? '')})',
                onTap: () async => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => RaceDetailsScreen(race: raceDetails!),
                  ),
                ),
              )
            else
              Card(
                color: gray,
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Center(
                    child: Text(
                      l10n.homeNoLatestRace,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ),

            const SizedBox(height: 30),

            //Upcoming race
            Text(
              l10n.homeUpcomingRace,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontFamily: 'TitilliumWeb',
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            nextRace != null && nextRace!.title != 'No upcoming race'
                ? RaceCardWidget(
                    title: translateRaceName(context, nextRace!.title),
                    color: gray,
                    subtitle:
                        '${translateLocation(context, nextRace!.locality)} • ${translateLocation(context, nextRace!.country)} • ${translateCircuit(context, nextRace!.circuit)} • ${nextRace!.date}',
                    result: 'Upcoming',
                    sprintQualiDate: nextRace!.sprintQualiDate,
                    sprintDate: nextRace!.sprintDate,
                    qualiDate: nextRace!.qualiDate,
                    fp2Date: nextRace!.fp2Date,
                    fp1Date: nextRace!.fp1Date,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            UpcomingRaceDetailsScreen(race: nextRace!),
                      ),
                    ),
                  )
                : Card(
                    color: gray,
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Center(
                        child: Text(
                          l10n.homeSeasonEnded,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),

            const SizedBox(height: 30),

            //News
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  l10n.homeLatestNews,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontFamily: 'TitilliumWeb',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.pushNamed(
                    context,
                    Routes.news,
                    arguments: news,
                  ),
                  child: Text(
                    l10n.homeSeeMore,
                    style: const TextStyle(color: f1Red),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            NewsCardWidget(onTap: () {}, model: news[0]),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
