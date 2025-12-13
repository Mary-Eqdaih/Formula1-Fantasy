import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formula1_fantasy/f1/cubit/auth_cubit.dart';
import 'package:formula1_fantasy/f1/cubit/auth_state.dart';
import 'package:formula1_fantasy/f1/cubit/drivers_cubit.dart';
import 'package:formula1_fantasy/f1/cubit/favs_cubit.dart';
import 'package:formula1_fantasy/f1/cubit/notes_cubit.dart';
import 'package:formula1_fantasy/f1/cubit/profile_cubit.dart';
import 'package:formula1_fantasy/f1/cubit/standings_cubit.dart';
import 'package:formula1_fantasy/f1/cubit/teams_cubit.dart';
import 'package:formula1_fantasy/f1/data/local/notes_DB.dart';
import 'package:formula1_fantasy/f1/presentation/screens/aboutF1/about.dart';
import 'package:formula1_fantasy/f1/presentation/screens/auth/sign_in.dart';
import 'package:formula1_fantasy/f1/presentation/screens/auth/sign_up.dart';
import 'package:formula1_fantasy/f1/presentation/screens/favorites/favorites.dart';
import 'package:formula1_fantasy/f1/presentation/screens/news/news.dart';
import 'package:formula1_fantasy/f1/presentation/screens/notes/add_note.dart';
import 'package:formula1_fantasy/f1/presentation/screens/notifications/notifications.dart';
import 'package:formula1_fantasy/f1/presentation/screens/profile/profile.dart';
import 'package:formula1_fantasy/f1/presentation/screens/settings/settings.dart';
import 'package:formula1_fantasy/routes/routes.dart';
import 'package:provider/provider.dart';
import 'f1/presentation/screens/home/home_screen.dart';
import 'f1/presentation/screens/notes/notes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Supabase.initialize(
    url: 'https://eifbpydagmgzilcphuwi.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImVpZmJweWRhZ21nemlsY3BodXdpIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjQ4NDUzMjYsImV4cCI6MjA4MDQyMTMyNn0.buEAp_KJhNQb8MOYlGP-y51y4E73a8iHQ4dC3T1Gvf4',
    authOptions: const FlutterAuthClientOptions(
      // This is important for session persistence
      autoRefreshToken: true,
    ),
  );

  // 3. Bridge Firebase Auth with Supabase Auth
  // This listens to Firebase auth state changes and updates Supabase client.
  FirebaseAuth.instance.idTokenChanges().listen((user) {
    if (user != null) {
      // When a user is logged in with Firebase, get their token
      user.getIdToken().then((jwt) {
        if (jwt != null) {
          // Use the JWT to sign in to Supabase
          Supabase.instance.client.auth.setSession(jwt);
        }
      });
    } else {
      // When the user logs out from Firebase, sign out from Supabase as well
      Supabase.instance.client.auth.signOut();
    }
  });
  await NotesDB.init();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

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
        BlocProvider(create: (_) => ProfileCubit()..fetchUserData()),
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
            Routes.profile: (context) => Profile(),
            Routes.settings: (context) => Settings(),
            Routes.news: (context) => News(),
            Routes.notifications: (context) => Notifications(),

            // Routes.DriverDetails:(context) => DriverDetails(),
          },
          debugShowCheckedModeBanner: false,
          // home: HomeScreen(),
          home: BlocBuilder<AuthCubit, AuthStates>(
            builder: (BuildContext context, state) {
              return state is AuthSuccessState ? HomeScreen() : SignIn();
            },
          ),
        ),
      ),
    );
  }
}
