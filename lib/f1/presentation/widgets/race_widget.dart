import 'package:flutter/material.dart';

import '../../../l10n/app_localizations.dart';

class RaceCardWidget extends StatelessWidget {
  const RaceCardWidget({
    super.key,
    required this.title,
    required this.color,
    required this.subtitle,
    required this.result,
    this.onTap,
    this.fp1Date,
    this.fp2Date,
    this.qualiDate,
    this.sprintQualiDate,
    this.sprintDate,
  });

  final String title;
  final Color color;
  final String subtitle;
  final String result;
  final VoidCallback? onTap;
  final String? fp1Date;
  final String? fp2Date;
  final String? qualiDate;
  final String? sprintQualiDate;
  final String? sprintDate;

  bool get _isLatest => result != 'Upcoming';

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF18191A),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: _isLatest
                ? const Color(0xFFE10600).withOpacity(0.4)
                : Colors.white.withOpacity(0.08),
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: _isLatest
                    ? const Color(0xFFE10600).withOpacity(0.12)
                    : Colors.white.withOpacity(0.04),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 3,
                    height: 20,
                    decoration: BoxDecoration(
                      color: _isLatest
                          ? const Color(0xFFE10600)
                          : Colors.white38,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontFamily: 'TitilliumWeb',
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  if (onTap != null)
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 13,
                      color: _isLatest
                          ? const Color(0xFFE10600)
                          : Colors.white24,
                    ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        size: 13,
                        color: _isLatest
                            ? const Color(0xFFE10600)
                            : Colors.white38,
                      ),
                      const SizedBox(width: 5),
                      Expanded(
                        child: Text(
                          subtitle,
                          style: const TextStyle(
                            fontFamily: 'TitilliumWeb',
                            color: Colors.white54,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (_isLatest) ...[
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF0F0F10),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.amber.withOpacity(0.25),
                        ),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.emoji_events,
                            color: Colors.amber,
                            size: 16,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              result,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'TitilliumWeb',
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                  if (!_isLatest) ...[
                    const SizedBox(height: 14),
                    const Divider(color: Colors.white12, height: 1),
                    const SizedBox(height: 10),
                    _sessionRow(
                      context,
                      l10n.upcomingPractice1,
                      fp1Date,
                      Icons.timer_outlined,
                      Colors.white54,
                    ),
                    _sessionRow(
                      context,
                      l10n.upcomingPractice2,
                      fp2Date,
                      Icons.timer_outlined,
                      Colors.white54,
                    ),
                    _sessionRow(
                      context,
                      l10n.upcomingSprintQualifying,
                      sprintQualiDate,
                      Icons.bolt,
                      const Color(0xFFFF8000),
                    ),
                    _sessionRow(
                      context,
                      l10n.upcomingSprintRace,
                      sprintDate,
                      Icons.bolt,
                      const Color(0xFFFF8000),
                    ),
                    _sessionRow(
                      context,
                      l10n.upcomingQualifying,
                      qualiDate,
                      Icons.speed,
                      Colors.amber,
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sessionRow(
    BuildContext context,
    String label,
    String? date,
    IconData icon,
    Color accentColor,
  ) {
    if (date == null) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(icon, color: accentColor, size: 14),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(
              fontFamily: 'TitilliumWeb',
              color: Colors.white60,
              fontSize: 13,
            ),
          ),
          const Spacer(),
          Text(
            _formatDate(context, date),
            style: const TextStyle(
              fontFamily: 'TitilliumWeb',
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(BuildContext context, String date) {
    try {
      final d = DateTime.parse(date);
      final locale = Localizations.localeOf(context).languageCode;

      if (locale == 'ar') {
        const monthsAr = [
          'يناير',
          'فبراير',
          'مارس',
          'أبريل',
          'مايو',
          'يونيو',
          'يوليو',
          'أغسطس',
          'سبتمبر',
          'أكتوبر',
          'نوفمبر',
          'ديسمبر',
        ];
        const daysAr = [
          'الإثنين',
          'الثلاثاء',
          'الأربعاء',
          'الخميس',
          'الجمعة',
          'السبت',
          'الأحد',
        ];
        return '${daysAr[d.weekday - 1]}، ${d.day} ${monthsAr[d.month - 1]}';
      }

      const months = [
        'Jan',
        'Feb',
        'Mar',
        'Apr',
        'May',
        'Jun',
        'Jul',
        'Aug',
        'Sep',
        'Oct',
        'Nov',
        'Dec',
      ];
      const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
      return '${days[d.weekday - 1]}, ${d.day} ${months[d.month - 1]}';
    } catch (_) {
      return date;
    }
  }
}
