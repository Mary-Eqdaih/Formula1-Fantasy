import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Fantasy'**
  String get appTitle;

  /// No description provided for @aboutF1Title.
  ///
  /// In en, this message translates to:
  /// **'About F1'**
  String get aboutF1Title;

  /// No description provided for @aboutOriginsTitle.
  ///
  /// In en, this message translates to:
  /// **'Origins (1950)'**
  String get aboutOriginsTitle;

  /// No description provided for @aboutOriginsBody.
  ///
  /// In en, this message translates to:
  /// **'• Formula One is the top class of single-seater motor racing governed by the FIA.\n• The first World Championship season was in 1950 (opening race at Silverstone, UK).\n• The annual title is awarded to Drivers (since 1950) and Constructors (since 1958).'**
  String get aboutOriginsBody;

  /// No description provided for @aboutErasTitle.
  ///
  /// In en, this message translates to:
  /// **'Eras at a glance'**
  String get aboutErasTitle;

  /// No description provided for @aboutErasBody.
  ///
  /// In en, this message translates to:
  /// **'• 1950s–60s  Front-engine → rear-engine cars; mechanical grip; legends like Fangio & Clark.\n• 1970s  Aerodynamics, wings, early ground effect; major safety improvements.\n• 1980s  Turbo era power; electronics rise; Senna vs. Prost rivalry.\n• 1990s  Refined aero & electronics; Schumacher dominance; active suspension ban.\n• 2000s  High downforce; V10 → V8; Ferrari golden age; refuelling era (now banned).\n• 2014–2021  1.6 L V6 turbo-hybrids; ERS systems define efficiency.\n• 2022 → New ground-effect aero rules for closer racing.'**
  String get aboutErasBody;

  /// No description provided for @aboutGrandPrixTitle.
  ///
  /// In en, this message translates to:
  /// **'How a Grand Prix works'**
  String get aboutGrandPrixTitle;

  /// No description provided for @aboutGrandPrixBody.
  ///
  /// In en, this message translates to:
  /// **'• Fri: Practice sessions.\n• Sat: Qualifying (Q1→Q2→Q3) or Sprint Shootout + Sprint Race on Sprint weekends.\n• Sun: Grand Prix Race.\n• Tyres: Teams must balance performance vs. degradation; pit stops are strategic.\n• Points pay down to P10, plus a bonus for fastest lap (top 10 only).'**
  String get aboutGrandPrixBody;

  /// No description provided for @aboutPointsTitle.
  ///
  /// In en, this message translates to:
  /// **'Points system (current)'**
  String get aboutPointsTitle;

  /// No description provided for @aboutPointsBody.
  ///
  /// In en, this message translates to:
  /// **'• Grand Prix (top 10): 25 – 18 – 15 – 12 – 10 – 8 – 6 – 4 – 2 – 1.\n• Fastest Lap: +1 point (if in top 10).\n• Sprint (top 8): 8 – 7 – 6 – 5 – 4 – 3 – 2 – 1.\n• Constructors score combined points from both drivers.'**
  String get aboutPointsBody;

  /// No description provided for @aboutCarsTitle.
  ///
  /// In en, this message translates to:
  /// **'Cars & Power Units over time'**
  String get aboutCarsTitle;

  /// No description provided for @aboutCarsBody.
  ///
  /// In en, this message translates to:
  /// **'• Chassis: Carbon-fibre monocoque, open-wheel & open-cockpit (with Halo since 2018).\n• Engines:\n – 1950s–60s: Various NA engines (focus on reliability).\n – 1977–1988: Turbocharged 1.5 L era.\n – 1989–2005: NA 3.5 L → 3.0 L V10 engines.\n – 2006–2013: 2.4 L V8 era.\n – 2014–present: 1.6 L V6 turbo-hybrid with ERS.\n• 2022 rules revived ground effect for better racing.'**
  String get aboutCarsBody;

  /// No description provided for @aboutSafetyTitle.
  ///
  /// In en, this message translates to:
  /// **'Safety milestones'**
  String get aboutSafetyTitle;

  /// No description provided for @aboutSafetyBody.
  ///
  /// In en, this message translates to:
  /// **'• Tracks: Run-off areas, barriers, medical cars.\n• Driver gear: Fireproof suits, HANS device, Halo cockpit protection.\n• Cars: Stronger survival cell, wheel tethers.\n• Procedures: Safety Car, Virtual Safety Car, crash investigations improve each year.'**
  String get aboutSafetyBody;

  /// No description provided for @aboutTeamsTitle.
  ///
  /// In en, this message translates to:
  /// **'Iconic teams'**
  String get aboutTeamsTitle;

  /// No description provided for @aboutTeamsBody.
  ///
  /// In en, this message translates to:
  /// **'• Ferrari – Oldest team; most Constructors\' titles.\n• McLaren – Multiple titles across eras; innovation leaders.\n• Williams – Privateer success story (80s-90s dominance).\n• Mercedes – Hybrid era giant (2014-2020 run).\n• Red Bull – Aero excellence & championship streaks 2010s → 2020s.'**
  String get aboutTeamsBody;

  /// No description provided for @aboutDriversTitle.
  ///
  /// In en, this message translates to:
  /// **'Legendary drivers (sample)'**
  String get aboutDriversTitle;

  /// No description provided for @aboutDriversBody.
  ///
  /// In en, this message translates to:
  /// **'• Juan Manuel Fangio – 5 titles in the 1950s.\n• Jim Clark – 60s icon of smooth speed.\n• Niki Lauda – Courageous comeback & safety advocate.\n• Alain Prost – \"The Professor\" of racecraft.\n• Ayrton Senna – Qualifying master; fierce rivalries.\n• Michael Schumacher – 7 titles; work ethic & dominance.\n• Lewis Hamilton – 7 titles; record wins & longevity.\n• Sebastian Vettel – 4 titles with Red Bull.\n• Fernando Alonso – Versatile and tactically brilliant.\n• Max Verstappen – Modern dominant force with Red Bull.'**
  String get aboutDriversBody;

  /// No description provided for @aboutRecordsTitle.
  ///
  /// In en, this message translates to:
  /// **'Records snapshot'**
  String get aboutRecordsTitle;

  /// No description provided for @aboutRecordsBody.
  ///
  /// In en, this message translates to:
  /// **'• Most Drivers\' titles: Michael Schumacher & Lewis Hamilton (7 each).\n• Most Grand Prix wins: Lewis Hamilton.\n• Most Constructors\' titles: Ferrari.\n• Youngest World Champion: Sebastian Vettel (23 yrs 134 days, 2010).'**
  String get aboutRecordsBody;

  /// No description provided for @aboutCircuitsTitle.
  ///
  /// In en, this message translates to:
  /// **'Circuits to know'**
  String get aboutCircuitsTitle;

  /// No description provided for @aboutCircuitsBody.
  ///
  /// In en, this message translates to:
  /// **'• Monaco – Narrow street circuit; ultimate precision test.\n• Monza – \"Temple of Speed\" in Italy.\n• Silverstone – Birthplace of the championship.\n• Spa-Francorchamps – Fast & flowing; weather drama.\n• Suzuka – Figure-eight technical classic (Japan).\n• Interlagos – Brazil; unpredictable & strategic.\n• Austin / Las Vegas – Modern US additions with showbiz flair.'**
  String get aboutCircuitsBody;

  /// No description provided for @aboutGlossaryTitle.
  ///
  /// In en, this message translates to:
  /// **'Quick glossary'**
  String get aboutGlossaryTitle;

  /// No description provided for @aboutGlossaryBody.
  ///
  /// In en, this message translates to:
  /// **'• Downforce – Vertical load from aero giving grip at speed.\n• Dirty air – Turbulence reducing downforce for car behind.\n• DRS – Movable rear wing zone for overtaking.\n• Undercut / Overcut – Pit timing strategies to gain track position.\n• Understeer / Oversteer – Front slides vs rear steps out.\n• Parc fermé – Restricted setup after qualifying.\n• Marbles – Rubber debris off racing line → low grip.'**
  String get aboutGlossaryBody;

  /// No description provided for @signInWelcomeBack.
  ///
  /// In en, this message translates to:
  /// **'Welcome Back'**
  String get signInWelcomeBack;

  /// No description provided for @signInGetStarted.
  ///
  /// In en, this message translates to:
  /// **'Let\'s Get Started'**
  String get signInGetStarted;

  /// No description provided for @signInEmail.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get signInEmail;

  /// No description provided for @signInPassword.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get signInPassword;

  /// No description provided for @signInButton.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get signInButton;

  /// No description provided for @signInNoAccount.
  ///
  /// In en, this message translates to:
  /// **'You Don\'t Have an Account?'**
  String get signInNoAccount;

  /// No description provided for @signInSignUp.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signInSignUp;

  /// No description provided for @signInEmptyEmail.
  ///
  /// In en, this message translates to:
  /// **'Please enter your email'**
  String get signInEmptyEmail;

  /// No description provided for @signInEmptyPassword.
  ///
  /// In en, this message translates to:
  /// **'Please enter your password'**
  String get signInEmptyPassword;

  /// No description provided for @signInInvalidPassword.
  ///
  /// In en, this message translates to:
  /// **'Password must have upper, lower, number, and special character'**
  String get signInInvalidPassword;

  /// No description provided for @signUpWelcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome To Formula 1'**
  String get signUpWelcome;

  /// No description provided for @signUpUsername.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get signUpUsername;

  /// No description provided for @signUpEmail.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get signUpEmail;

  /// No description provided for @signUpPassword.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get signUpPassword;

  /// No description provided for @signUpConfirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get signUpConfirmPassword;

  /// No description provided for @signUpButton.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signUpButton;

  /// No description provided for @signUpHasAccount.
  ///
  /// In en, this message translates to:
  /// **'Already Have an Account?'**
  String get signUpHasAccount;

  /// No description provided for @signUpSignIn.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get signUpSignIn;

  /// No description provided for @signUpEmptyUsername.
  ///
  /// In en, this message translates to:
  /// **'Please enter your username'**
  String get signUpEmptyUsername;

  /// No description provided for @signUpEmptyEmail.
  ///
  /// In en, this message translates to:
  /// **'Please enter your email'**
  String get signUpEmptyEmail;

  /// No description provided for @signUpInvalidEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email address'**
  String get signUpInvalidEmail;

  /// No description provided for @signUpEmptyPassword.
  ///
  /// In en, this message translates to:
  /// **'Please enter your password'**
  String get signUpEmptyPassword;

  /// No description provided for @signUpInvalidPassword.
  ///
  /// In en, this message translates to:
  /// **'Password must have upper, lower, number, and special character'**
  String get signUpInvalidPassword;

  /// No description provided for @signUpEmptyConfirm.
  ///
  /// In en, this message translates to:
  /// **'Please enter your password'**
  String get signUpEmptyConfirm;

  /// No description provided for @signUpPasswordMismatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords doesn\'t match'**
  String get signUpPasswordMismatch;

  /// No description provided for @navHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navHome;

  /// No description provided for @navTeams.
  ///
  /// In en, this message translates to:
  /// **'Teams'**
  String get navTeams;

  /// No description provided for @navLeaderboard.
  ///
  /// In en, this message translates to:
  /// **'Leaderboard'**
  String get navLeaderboard;

  /// No description provided for @navFantasy.
  ///
  /// In en, this message translates to:
  /// **'Fantasy'**
  String get navFantasy;

  /// No description provided for @navSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get navSettings;

  /// No description provided for @homeHello.
  ///
  /// In en, this message translates to:
  /// **'Hello'**
  String get homeHello;

  /// No description provided for @homeGuest.
  ///
  /// In en, this message translates to:
  /// **'Guest'**
  String get homeGuest;

  /// No description provided for @homeLatestRace.
  ///
  /// In en, this message translates to:
  /// **'Latest Race Result'**
  String get homeLatestRace;

  /// No description provided for @homeUpcomingRace.
  ///
  /// In en, this message translates to:
  /// **'Upcoming Race'**
  String get homeUpcomingRace;

  /// No description provided for @homeLatestNews.
  ///
  /// In en, this message translates to:
  /// **'Latest F1 News'**
  String get homeLatestNews;

  /// No description provided for @homeSeeMore.
  ///
  /// In en, this message translates to:
  /// **'See More'**
  String get homeSeeMore;

  /// No description provided for @homeNoLatestRace.
  ///
  /// In en, this message translates to:
  /// **'No latest race data available right now.'**
  String get homeNoLatestRace;

  /// No description provided for @homeSeasonEnded.
  ///
  /// In en, this message translates to:
  /// **'The F1 season for this year has concluded. See you next year!'**
  String get homeSeasonEnded;

  /// No description provided for @fantasyPickYourTeam.
  ///
  /// In en, this message translates to:
  /// **'Pick Your Team'**
  String get fantasyPickYourTeam;

  /// No description provided for @fantasyClearTeam.
  ///
  /// In en, this message translates to:
  /// **'Clear team'**
  String get fantasyClearTeam;

  /// No description provided for @fantasyMyTeam.
  ///
  /// In en, this message translates to:
  /// **'My Team'**
  String get fantasyMyTeam;

  /// No description provided for @fantasySaveTeam.
  ///
  /// In en, this message translates to:
  /// **'Save team'**
  String get fantasySaveTeam;

  /// No description provided for @fantasyTeamSaved.
  ///
  /// In en, this message translates to:
  /// **'Team saved'**
  String get fantasyTeamSaved;

  /// No description provided for @fantasyTeamSavedSnackbar.
  ///
  /// In en, this message translates to:
  /// **'✅ Team saved!'**
  String get fantasyTeamSavedSnackbar;

  /// No description provided for @myTeamTitle.
  ///
  /// In en, this message translates to:
  /// **'My Fantasy Team'**
  String get myTeamTitle;

  /// No description provided for @myTeamEmpty.
  ///
  /// In en, this message translates to:
  /// **'No drivers selected yet'**
  String get myTeamEmpty;

  /// No description provided for @myTeamGoPickTeam.
  ///
  /// In en, this message translates to:
  /// **'Go pick your team →'**
  String get myTeamGoPickTeam;

  /// No description provided for @myTeamDrivers.
  ///
  /// In en, this message translates to:
  /// **'Drivers'**
  String get myTeamDrivers;

  /// No description provided for @myTeamTotalCost.
  ///
  /// In en, this message translates to:
  /// **'Total Cost'**
  String get myTeamTotalCost;

  /// No description provided for @myTeamRemaining.
  ///
  /// In en, this message translates to:
  /// **'Remaining'**
  String get myTeamRemaining;

  /// No description provided for @myTeamSavedStatus.
  ///
  /// In en, this message translates to:
  /// **'Team locked in for this race weekend'**
  String get myTeamSavedStatus;

  /// No description provided for @myTeamUnsavedStatus.
  ///
  /// In en, this message translates to:
  /// **'Team not saved yet — go back and save!'**
  String get myTeamUnsavedStatus;

  /// No description provided for @teamsTitle.
  ///
  /// In en, this message translates to:
  /// **'Teams'**
  String get teamsTitle;

  /// No description provided for @teamsCantLoad.
  ///
  /// In en, this message translates to:
  /// **'Can\'t Load Teams'**
  String get teamsCantLoad;

  /// No description provided for @teamsRefresh.
  ///
  /// In en, this message translates to:
  /// **'Refresh'**
  String get teamsRefresh;

  /// No description provided for @teamDetailsTitle.
  ///
  /// In en, this message translates to:
  /// **'Team Details'**
  String get teamDetailsTitle;

  /// No description provided for @teamDetailsDrivers.
  ///
  /// In en, this message translates to:
  /// **'Drivers'**
  String get teamDetailsDrivers;

  /// No description provided for @teamDetailsSeeMore.
  ///
  /// In en, this message translates to:
  /// **'See more'**
  String get teamDetailsSeeMore;

  /// No description provided for @teamDetailsFailedDrivers.
  ///
  /// In en, this message translates to:
  /// **'Failed to load drivers...'**
  String get teamDetailsFailedDrivers;

  /// No description provided for @teamDetailsNoDrivers.
  ///
  /// In en, this message translates to:
  /// **'No drivers available'**
  String get teamDetailsNoDrivers;

  /// No description provided for @leaderboardTitle.
  ///
  /// In en, this message translates to:
  /// **'Leaderboard'**
  String get leaderboardTitle;

  /// No description provided for @leaderboardEmpty.
  ///
  /// In en, this message translates to:
  /// **'No driver standings available yet.'**
  String get leaderboardEmpty;

  /// No description provided for @leaderboardEmptySubtitle.
  ///
  /// In en, this message translates to:
  /// **'This usually happens before the first race of the season.'**
  String get leaderboardEmptySubtitle;

  /// No description provided for @leaderboardCantLoad.
  ///
  /// In en, this message translates to:
  /// **'Can\'t Load Leaderboard'**
  String get leaderboardCantLoad;

  /// No description provided for @leaderboardRefresh.
  ///
  /// In en, this message translates to:
  /// **'Refresh'**
  String get leaderboardRefresh;

  /// No description provided for @favoritesYourTeams.
  ///
  /// In en, this message translates to:
  /// **'Your Favorite Teams'**
  String get favoritesYourTeams;

  /// No description provided for @favoritesEmpty.
  ///
  /// In en, this message translates to:
  /// **'Nothing Added To Favorites'**
  String get favoritesEmpty;

  /// No description provided for @profileNoName.
  ///
  /// In en, this message translates to:
  /// **'No Name'**
  String get profileNoName;

  /// No description provided for @profileNoBio.
  ///
  /// In en, this message translates to:
  /// **'No Bio'**
  String get profileNoBio;

  /// No description provided for @profileEdit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get profileEdit;

  /// No description provided for @profileEditTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit profile'**
  String get profileEditTitle;

  /// No description provided for @profileEditName.
  ///
  /// In en, this message translates to:
  /// **'Edit Name'**
  String get profileEditName;

  /// No description provided for @profileEditBio.
  ///
  /// In en, this message translates to:
  /// **'Edit Bio'**
  String get profileEditBio;

  /// No description provided for @profileCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get profileCancel;

  /// No description provided for @profileSave.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get profileSave;

  /// No description provided for @profileFavoriteTeams.
  ///
  /// In en, this message translates to:
  /// **'Favorite Teams'**
  String get profileFavoriteTeams;

  /// No description provided for @profileFavoritesEmpty.
  ///
  /// In en, this message translates to:
  /// **'Nothing Added To Favorites'**
  String get profileFavoritesEmpty;

  /// No description provided for @profileFailedLoad.
  ///
  /// In en, this message translates to:
  /// **'Failed to load profile data'**
  String get profileFailedLoad;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @settingsNotifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get settingsNotifications;

  /// No description provided for @settingsNotificationSettings.
  ///
  /// In en, this message translates to:
  /// **'Notification Settings'**
  String get settingsNotificationSettings;

  /// No description provided for @settingsPrivacy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Settings'**
  String get settingsPrivacy;

  /// No description provided for @settingsPrivacyLabel.
  ///
  /// In en, this message translates to:
  /// **'Privacy'**
  String get settingsPrivacyLabel;

  /// No description provided for @settingsLanguage.
  ///
  /// In en, this message translates to:
  /// **'Change of Language'**
  String get settingsLanguage;

  /// No description provided for @settingsLanguageLabel.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get settingsLanguageLabel;

  /// No description provided for @settingsFavorites.
  ///
  /// In en, this message translates to:
  /// **'Favorite Teams'**
  String get settingsFavorites;

  /// No description provided for @settingsFavoritesLabel.
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get settingsFavoritesLabel;

  /// No description provided for @settingsFeedback.
  ///
  /// In en, this message translates to:
  /// **'Send Us Feedback'**
  String get settingsFeedback;

  /// No description provided for @settingsFeedbackLabel.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get settingsFeedbackLabel;

  /// No description provided for @settingsDeleteAccount.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get settingsDeleteAccount;

  /// No description provided for @settingsDeleteLabel.
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get settingsDeleteLabel;

  /// No description provided for @settingsSignOut.
  ///
  /// In en, this message translates to:
  /// **'Sign Out'**
  String get settingsSignOut;

  /// No description provided for @settingsCantLoadProfile.
  ///
  /// In en, this message translates to:
  /// **'Can\'t Load Profile'**
  String get settingsCantLoadProfile;

  /// No description provided for @settingsRefresh.
  ///
  /// In en, this message translates to:
  /// **'Refresh'**
  String get settingsRefresh;

  /// No description provided for @settingsDeleteConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Confirm Account Deletion'**
  String get settingsDeleteConfirmTitle;

  /// No description provided for @settingsDeleteConfirmBody.
  ///
  /// In en, this message translates to:
  /// **'Please enter your password to confirm deletion.'**
  String get settingsDeleteConfirmBody;

  /// No description provided for @settingsDeletePasswordHint.
  ///
  /// In en, this message translates to:
  /// **'Enter Your Password'**
  String get settingsDeletePasswordHint;

  /// No description provided for @settingsDeleteCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get settingsDeleteCancel;

  /// No description provided for @settingsDeleteButton.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get settingsDeleteButton;

  /// No description provided for @settingsDeleteEmptyPassword.
  ///
  /// In en, this message translates to:
  /// **'Please enter your password'**
  String get settingsDeleteEmptyPassword;

  /// No description provided for @raceResultsTitle.
  ///
  /// In en, this message translates to:
  /// **'RACE RESULTS'**
  String get raceResultsTitle;

  /// No description provided for @raceDate.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get raceDate;

  /// No description provided for @raceSeason.
  ///
  /// In en, this message translates to:
  /// **'Season'**
  String get raceSeason;

  /// No description provided for @raceRoundLabel.
  ///
  /// In en, this message translates to:
  /// **'Round'**
  String get raceRoundLabel;

  /// No description provided for @upcomingRaceBadge.
  ///
  /// In en, this message translates to:
  /// **'UPCOMING RACE'**
  String get upcomingRaceBadge;

  /// No description provided for @upcomingRaceDate.
  ///
  /// In en, this message translates to:
  /// **'RACE DATE'**
  String get upcomingRaceDate;

  /// No description provided for @upcomingCircuit.
  ///
  /// In en, this message translates to:
  /// **'CIRCUIT'**
  String get upcomingCircuit;

  /// No description provided for @upcomingWeekendSchedule.
  ///
  /// In en, this message translates to:
  /// **'WEEKEND SCHEDULE'**
  String get upcomingWeekendSchedule;

  /// No description provided for @upcomingRaceDay.
  ///
  /// In en, this message translates to:
  /// **'RACE DAY'**
  String get upcomingRaceDay;

  /// No description provided for @upcomingPractice1.
  ///
  /// In en, this message translates to:
  /// **'Practice 1'**
  String get upcomingPractice1;

  /// No description provided for @upcomingPractice2.
  ///
  /// In en, this message translates to:
  /// **'Practice 2'**
  String get upcomingPractice2;

  /// No description provided for @upcomingSprintQualifying.
  ///
  /// In en, this message translates to:
  /// **'Sprint Qualifying'**
  String get upcomingSprintQualifying;

  /// No description provided for @upcomingSprintRace.
  ///
  /// In en, this message translates to:
  /// **'Sprint Race'**
  String get upcomingSprintRace;

  /// No description provided for @upcomingQualifying.
  ///
  /// In en, this message translates to:
  /// **'Qualifying'**
  String get upcomingQualifying;

  /// No description provided for @upcomingDone.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get upcomingDone;

  /// No description provided for @upcomingToday.
  ///
  /// In en, this message translates to:
  /// **'Today!'**
  String get upcomingToday;

  /// No description provided for @upcomingTomorrow.
  ///
  /// In en, this message translates to:
  /// **'Tomorrow'**
  String get upcomingTomorrow;

  /// No description provided for @newsLatestNews.
  ///
  /// In en, this message translates to:
  /// **'Latest News'**
  String get newsLatestNews;

  /// No description provided for @commonAboutF1.
  ///
  /// In en, this message translates to:
  /// **'About F1'**
  String get commonAboutF1;

  /// No description provided for @commonSignOut.
  ///
  /// In en, this message translates to:
  /// **'Sign Out'**
  String get commonSignOut;

  /// No description provided for @commonRefresh.
  ///
  /// In en, this message translates to:
  /// **'Refresh'**
  String get commonRefresh;

  /// No description provided for @homeWinner.
  ///
  /// In en, this message translates to:
  /// **'Winner'**
  String get homeWinner;

  /// No description provided for @points.
  ///
  /// In en, this message translates to:
  /// **'Points'**
  String get points;

  /// No description provided for @driverDob.
  ///
  /// In en, this message translates to:
  /// **'Date Of Birth'**
  String get driverDob;

  /// No description provided for @driverPermanentNumber.
  ///
  /// In en, this message translates to:
  /// **'Permanent Number'**
  String get driverPermanentNumber;

  /// No description provided for @driverNationality.
  ///
  /// In en, this message translates to:
  /// **'Nationality'**
  String get driverNationality;

  /// No description provided for @driverCode.
  ///
  /// In en, this message translates to:
  /// **'Code'**
  String get driverCode;

  /// No description provided for @driverPoints.
  ///
  /// In en, this message translates to:
  /// **'Points'**
  String get driverPoints;

  /// No description provided for @driverWcs.
  ///
  /// In en, this message translates to:
  /// **'WCS'**
  String get driverWcs;

  /// No description provided for @pts.
  ///
  /// In en, this message translates to:
  /// **'PTS'**
  String get pts;

  /// No description provided for @wins.
  ///
  /// In en, this message translates to:
  /// **'Wins'**
  String get wins;

  /// No description provided for @fantasyBudgetLeft.
  ///
  /// In en, this message translates to:
  /// **'Budget Left'**
  String get fantasyBudgetLeft;

  /// No description provided for @fantasySpent.
  ///
  /// In en, this message translates to:
  /// **'Spent'**
  String get fantasySpent;

  /// No description provided for @settingsSectionPreferences.
  ///
  /// In en, this message translates to:
  /// **'PREFERENCES'**
  String get settingsSectionPreferences;

  /// No description provided for @settingsSectionAccount.
  ///
  /// In en, this message translates to:
  /// **'ACCOUNT'**
  String get settingsSectionAccount;

  /// No description provided for @settingsSectionDangerZone.
  ///
  /// In en, this message translates to:
  /// **'DANGER ZONE'**
  String get settingsSectionDangerZone;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
