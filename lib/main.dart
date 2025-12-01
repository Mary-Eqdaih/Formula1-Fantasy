import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formula1_fantasy/f1/cubit/auth_cubit.dart';
import 'package:formula1_fantasy/f1/cubit/auth_state.dart';
import 'package:formula1_fantasy/f1/cubit/drivers_cubit.dart';
import 'package:formula1_fantasy/f1/cubit/favs_cubit.dart';
import 'package:formula1_fantasy/f1/cubit/notes_cubit.dart';
import 'package:formula1_fantasy/f1/cubit/standings_cubit.dart';
import 'package:formula1_fantasy/f1/cubit/teams_cubit.dart';
import 'package:formula1_fantasy/f1/data/local/notes_DB.dart';
import 'package:formula1_fantasy/f1/presentation/screens/aboutF1/about.dart';
import 'package:formula1_fantasy/f1/presentation/screens/auth/sign_in.dart';
import 'package:formula1_fantasy/f1/presentation/screens/auth/sign_up.dart';
import 'package:formula1_fantasy/f1/presentation/screens/favorites/favorites.dart';
import 'package:formula1_fantasy/f1/presentation/screens/news/news.dart';
import 'package:formula1_fantasy/f1/presentation/screens/notes/add_note.dart';
import 'package:formula1_fantasy/f1/presentation/screens/profile/profile.dart';
import 'package:formula1_fantasy/f1/presentation/screens/settings/settings.dart';
import 'package:formula1_fantasy/routes/routes.dart';
import 'package:provider/provider.dart';
import 'f1/presentation/screens/home/home_screen.dart';
import 'f1/presentation/screens/notes/notes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await NotesDB.init();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [

        BlocProvider(create: (_) => StandingsCubit()..fetchStandings()),
        BlocProvider(create: (_) => NotesCubit()..fetchNotes()),
        BlocProvider(create: (_) => TeamsCubit()..fetchTeams()),
        BlocProvider(create: (_) => DriversCubit()),
        BlocProvider(create: (_) => FavoritesCubit()),




      ],

      child: BlocProvider<AuthCubit>(
        create: (_) => AuthCubit()..checkIfLoggedIn(),
        child: MaterialApp(
          theme: ThemeData(fontFamily: 'TitilliumWeb'),
          routes: {
            Routes.signIn: (context) => SignIn(),
            Routes.signUp: (context) => SignUp(),
            Routes.home: (context) => HomeScreen(),
            Routes.favs: (context) => Favorites(),
            Routes.notes: (context) => Notes(),
            Routes.aboutF1: (context) => aboutF1(),
            Routes.addNote: (context) => AddNote(),
            Routes.profile:(context) => Profile(),
            Routes.settings:(context) => Settings(),
            Routes.news:(context) => News(),
            // Routes.DriverDetails:(context) => DriverDetails(),

          },
          debugShowCheckedModeBanner: false,
          // home: HomeScreen(),
          home: BlocBuilder<AuthCubit,AuthStates>(builder: (BuildContext context, state) {

            return state is AuthSuccessState ? HomeScreen(): SignIn();
          },
          ),
        ),
      ),
    );
  }
}
