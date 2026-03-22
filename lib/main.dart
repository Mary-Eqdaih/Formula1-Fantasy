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
import 'package:formula1_fantasy/f1/presentation/screens/fantasy/my_team.dart';
import 'package:formula1_fantasy/f1/presentation/screens/favorites/favorites.dart';
import 'package:formula1_fantasy/f1/presentation/screens/news/news.dart';
import 'package:formula1_fantasy/f1/presentation/screens/notes/add_note.dart';
import 'package:formula1_fantasy/f1/presentation/screens/notifications/notifications.dart';
import 'package:formula1_fantasy/f1/presentation/screens/profile/profile.dart';
import 'package:formula1_fantasy/f1/presentation/screens/settings/settings.dart';
import 'package:formula1_fantasy/routes/routes.dart';
import 'package:provider/provider.dart';
import 'f1/data/local/local_storage.dart';
import 'f1/presentation/screens/home/home_screen.dart';
import 'f1/presentation/screens/notes/notes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'l10n/app_localizations.dart';

// Top-level key — lives for the entire app lifetime.
// Declared here (outside any function/class) so any file can import it and
// call: appStateKey.currentState?.setLocale(Locale('ar'))
// If it were inside main() it would be a local variable and get garbage
// collected. Being top-level means it's always reachable.
final GlobalKey<MyAppState> appStateKey = GlobalKey<MyAppState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Supabase.initialize(
    url: 'https://mofuaahxusmuydqyqizj.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im1vZnVhYWh4dXNtdXlkcXlxaXpqIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzQyMDA5MzEsImV4cCI6MjA4OTc3NjkzMX0.3BgncU1bF3iY2q_iaVnSIx8vis13b87zdWWx-qe-nf8',
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

  // Load the saved locale BEFORE runApp so the app starts in the correct
  // language without any flicker or delay.
  // If nothing was saved yet, loadLocale() returns 'en' as the default.
  final savedLangCode = await LocalStorageData.loadLocale();

  runApp(MyApp(key: appStateKey, initialLocale: Locale(savedLangCode)));
}

class MyApp extends StatefulWidget {
  // Accept the saved locale from main() so the first frame renders correctly
  final Locale initialLocale;
  const MyApp({super.key, required this.initialLocale});

  @override
  // State class is PUBLIC (MyAppState not _MyAppState) so other files can
  // write GlobalKey<MyAppState>. A private class (_MyAppState) cannot be
  // referenced outside this file.
  State<MyApp> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  // Will be set in initState from widget.initialLocale (loaded from storage)
  late Locale _locale;

  @override
  void initState() {
    super.initState();
    // Start with whatever locale was loaded from SharedPreferences in main()
    _locale = widget.initialLocale;
  }

  // Called from settings.dart via appStateKey.currentState?.setLocale(...)
  // 1. Updates UI immediately via setState
  // 2. Persists to SharedPreferences so the choice survives app restarts
  Future<void> setLocale(Locale locale) async {
    setState(() => _locale = locale);
    await LocalStorageData.saveLocale(locale.languageCode);
  }

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
          // When setLocale() is called, this rebuilds and the new locale
          // propagates down to every widget in the tree instantly
          locale: _locale,
          supportedLocales: const [
            Locale('en'), // English
            Locale('ar'), // Arabic
          ],
          localizationsDelegates: const [
            // Our generated translations from the ARB files
            AppLocalizations.delegate,
            // Flutter's built-in material/cupertino/widgets translations
            // (handles things like date pickers, back button labels, etc.)
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
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
            Routes.myTeam: (context) => MyTeamScreen(),
          },
          debugShowCheckedModeBanner: false,
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
