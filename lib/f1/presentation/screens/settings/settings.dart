import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formula1_fantasy/f1/cubit/auth_cubit.dart';
import 'package:formula1_fantasy/f1/cubit/profile_cubit.dart';
import 'package:formula1_fantasy/f1/cubit/profile_states.dart';
import 'package:formula1_fantasy/f1/presentation/widgets/Custom_text_field.dart';
import 'package:formula1_fantasy/routes/routes.dart';
import 'package:formula1_fantasy/main.dart';
import '../../../../l10n/app_localizations.dart';
import '../../widgets/language_option.dart';
import '../../widgets/section_settings_label.dart';
import '../../widgets/settings_group.dart';
import '../../widgets/settings_tile.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  static const _darkBg = Color(0xFF0F0F10);
  static const _cardBg = Color(0xFF18191A);
  static const _f1Red = Color(0xFFE10600);
  static const _redDark = Color(0xFF3A0000);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: _darkBg,
      body: RefreshIndicator(
        color: _f1Red,
        backgroundColor: _cardBg,
        onRefresh: () {
          context.read<ProfileCubit>().fetchUserData();
          return Future.delayed(const Duration(seconds: 1));
        },
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 150,
              pinned: true,
              automaticallyImplyLeading: false,
              backgroundColor: _darkBg,
              elevation: 0,
              title: Text(
                l10n.settingsTitle,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'TitilliumWeb',
                ),
              ),
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [_redDark, _darkBg],
                        ),
                      ),
                    ),

                    Positioned(
                      right: -20,
                      top: 0,
                      bottom: 0,
                      child: Transform.rotate(
                        angle: 0.15,
                        child: Container(
                          width: 3,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                _f1Red.withOpacity(0.4),
                                Colors.transparent,
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 20,
                      top: 0,
                      bottom: 0,
                      child: Transform.rotate(
                        angle: 0.15,
                        child: Container(
                          width: 1,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                _f1Red.withOpacity(0.15),
                                Colors.transparent,
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 20,
                      left: 20,
                      right: 20,
                      child: BlocBuilder<ProfileCubit, ProfileStates>(
                        builder: (context, state) {
                          if (state is ProfileSuccessState) {
                            return Row(
                              children: [
                                Stack(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(2),
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: _f1Red,
                                      ),
                                      child: CircleAvatar(
                                        radius: 28,
                                        backgroundImage:
                                            state.profileModel.photoUrl!.isEmpty
                                            ? const AssetImage(
                                                'assets/person.jpeg',
                                              )
                                            : NetworkImage(
                                                    state
                                                        .profileModel
                                                        .photoUrl!,
                                                  )
                                                  as ImageProvider,
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 2,
                                      right: 2,
                                      child: Container(
                                        width: 10,
                                        height: 10,
                                        decoration: BoxDecoration(
                                          color: const Color(0xFF229971),
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: _darkBg,
                                            width: 2,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 14),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${state.profileModel.name}',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'TitilliumWeb',
                                        ),
                                      ),
                                      Text(
                                        '${state.profileModel.email}',
                                        style: const TextStyle(
                                          color: Colors.white60,
                                          fontSize: 12,
                                          fontFamily: 'TitilliumWeb',
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () => Navigator.pushNamed(
                                    context,
                                    Routes.profile,
                                  ),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 6,
                                    ),
                                    decoration: BoxDecoration(
                                      color: _f1Red.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                        color: _f1Red.withOpacity(0.4),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          Icons.edit,
                                          color: _f1Red,
                                          size: 13,
                                        ),
                                        SizedBox(width: 5),
                                        Text(
                                          l10n.profileEdit,
                                          style: TextStyle(
                                            color: _f1Red,
                                            fontSize: 12,
                                            fontFamily: 'TitilliumWeb',
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }
                          if (state is ProfileLoadingState) {
                            return const Center(
                              child: CircularProgressIndicator(color: _f1Red),
                            );
                          }
                          return const SizedBox.shrink();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),

                  // Preferences group
                  SettingsSectionLabel(l10n.settingsSectionPreferences),
                  SettingsGroup(
                    children: [
                      SettingsTile(
                        icon: Icons.notifications_outlined,
                        iconColor: const Color(0xFF4FC3F7),
                        title: l10n.settingsNotificationSettings,
                        onTap: () =>
                            Navigator.pushNamed(context, Routes.notifications),
                      ),
                      SettingsTile(
                        icon: Icons.language_outlined,
                        iconColor: const Color(0xFF81C784),
                        title: l10n.settingsLanguageLabel,
                        onTap: () => _showLanguagePicker(context),
                        trailing: _langBadge(context),
                      ),
                      SettingsTile(
                        icon: Icons.lock_outline,
                        iconColor: const Color(0xFFFFB74D),
                        title: l10n.settingsPrivacyLabel,
                        onTap: () {},
                      ),
                    ],
                  ),

                  // Account group
                  SettingsSectionLabel(l10n.settingsSectionAccount),

                  SettingsGroup(
                    children: [
                      SettingsTile(
                        icon: Icons.favorite_outline,
                        iconColor: _f1Red,
                        title: l10n.settingsFavoritesLabel,
                        onTap: () => Navigator.pushNamed(context, Routes.favs),
                      ),
                      SettingsTile(
                        icon: Icons.chat_bubble_outline,
                        iconColor: const Color(0xFFCE93D8),
                        title: l10n.settingsFeedbackLabel,
                        onTap: () {},
                      ),
                    ],
                  ),

                  // Danger zone group
                  SettingsSectionLabel(l10n.settingsSectionDangerZone),
                  SettingsGroup(
                    children: [
                      SettingsTile(
                        icon: Icons.delete_outline,
                        iconColor: _f1Red,
                        title: l10n.settingsDeleteLabel,
                        titleColor: _f1Red,
                        onTap: () => promptForPasswordAndDelete(context),
                        showArrow: false,
                        trailing: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: _f1Red.withOpacity(0.12),
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(color: _f1Red.withOpacity(0.3)),
                          ),
                          child: const Text(
                            '!',
                            style: TextStyle(
                              color: _f1Red,
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 28),

                  // Sign out
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                          side: BorderSide(color: _f1Red.withOpacity(0.6)),
                        ),
                      ),
                      onPressed: () {
                        context.read<AuthCubit>().signOut();
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          Routes.signIn,
                          (r) => false,
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.logout, color: _f1Red, size: 18),
                          const SizedBox(width: 10),
                          Text(
                            l10n.settingsSignOut,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: _f1Red,
                              fontFamily: 'TitilliumWeb',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Current language badge shown on the language tile
  Widget _langBadge(BuildContext context) {
    final isAr = Localizations.localeOf(context).languageCode == 'ar';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.07),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        isAr ? 'AR' : 'EN',
        style: const TextStyle(
          color: Colors.white60,
          fontSize: 11,
          fontFamily: 'TitilliumWeb',
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // Language picker bottom sheet
  void _showLanguagePicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: _cardBg,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) {
        final isAr = Localizations.localeOf(context).languageCode == 'ar';
        return Padding(
          padding: const EdgeInsets.fromLTRB(24, 12, 24, 36),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Language / اللغة',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: 'TitilliumWeb',
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              // Using the LanguageOption class instead of a helper method
              LanguageOption(
                flag: '🇬🇧',
                label: 'English',
                sublabel: 'English',
                selected: !isAr,
                onTap: () {
                  appStateKey.currentState?.setLocale(const Locale('en'));
                  Navigator.pop(context);
                },
              ),
              const SizedBox(height: 10),
              LanguageOption(
                flag: '🇸🇦',
                label: 'العربية',
                sublabel: 'Arabic',
                selected: isAr,
                onTap: () {
                  appStateKey.currentState?.setLocale(const Locale('ar'));
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // Delete account dialog
  Future<void> promptForPasswordAndDelete(BuildContext context) async {
    final l10n = AppLocalizations.of(context)!;
    final passwordController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    bool isPasswordVisible = false;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          backgroundColor: _darkBg,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Row(
            children: [
              const Icon(Icons.warning_amber_rounded, color: _f1Red, size: 20),
              const SizedBox(width: 8),
              Text(
                l10n.settingsDeleteConfirmTitle,
                style: const TextStyle(
                  color: Colors.white,
                  fontFamily: 'TitilliumWeb',
                  fontSize: 16,
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                l10n.settingsDeleteConfirmBody,
                style: const TextStyle(
                  color: Colors.white70,
                  fontFamily: 'TitilliumWeb',
                ),
              ),
              const SizedBox(height: 14),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    CustomTextField(
                      preIcon: const Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: Icon(
                          isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () => setState(
                          () => isPasswordVisible = !isPasswordVisible,
                        ),
                      ),
                      controller: passwordController,
                      isPassword: !isPasswordVisible,
                      hint: l10n.settingsDeletePasswordHint,
                      validator: (v) => (v == null || v.isEmpty)
                          ? l10n.settingsDeleteEmptyPassword
                          : null,
                    ),
                    const SizedBox(height: 14),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text(
                            l10n.settingsDeleteCancel,
                            style: const TextStyle(color: Colors.white54),
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _f1Red,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              final err = await context
                                  .read<AuthCubit>()
                                  .deleteAccount(passwordController.text);
                              if (err != null) {
                                ScaffoldMessenger.of(
                                  context,
                                ).showSnackBar(SnackBar(content: Text(err)));
                              } else {
                                Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  Routes.signIn,
                                  (r) => false,
                                );
                              }
                            }
                          },
                          child: Text(
                            l10n.settingsDeleteButton,
                            style: const TextStyle(
                              color: Colors.white,
                              fontFamily: 'TitilliumWeb',
                            ),
                          ),
                        ),
                      ],
                    ),
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
