import 'package:flutter/material.dart';

// Race names
const Map<String, String> raceNamesAr = {
  'Bahrain Grand Prix':          'جائزة البحرين الكبرى',
  'Japanese Grand Prix':         'جائزة اليابان الكبرى',
  'Australian Grand Prix':       'جائزة أستراليا الكبرى',
  'Chinese Grand Prix':          'جائزة الصين الكبرى',
  'Miami Grand Prix':            'جائزة ميامي الكبرى',
  'Emilia Romagna Grand Prix':   'جائزة إيميليا رومانيا الكبرى',
  'Monaco Grand Prix':           'جائزة موناكو الكبرى',
  'Canadian Grand Prix':         'جائزة كندا الكبرى',
  'Spanish Grand Prix':          'جائزة إسبانيا الكبرى',
  'Austrian Grand Prix':         'جائزة النمسا الكبرى',
  'British Grand Prix':          'جائزة بريطانيا الكبرى',
  'Hungarian Grand Prix':        'جائزة المجر الكبرى',
  'Belgian Grand Prix':          'جائزة بلجيكا الكبرى',
  'Dutch Grand Prix':            'جائزة هولندا الكبرى',
  'Italian Grand Prix':          'جائزة إيطاليا الكبرى',
  'Azerbaijan Grand Prix':       'جائزة أذربيجان الكبرى',
  'Singapore Grand Prix':        'جائزة سنغافورة الكبرى',
  'United States Grand Prix':    'جائزة الولايات المتحدة الكبرى',
  'Mexico City Grand Prix':      'جائزة مكسيكو سيتي الكبرى',
  'São Paulo Grand Prix':        'جائزة ساو باولو الكبرى',
  'Las Vegas Grand Prix':        'جائزة لاس فيغاس الكبرى',
  'Qatar Grand Prix':            'جائزة قطر الكبرى',
  'Abu Dhabi Grand Prix':        'جائزة أبوظبي الكبرى',
};

// Locations / countries
const Map<String, String> locationsAr = {
  // cities (locality field from API)
  'Shanghai':     'شنغهاي',
  'Suzuka':       'سوزوكا',
  'Melbourne':    'ملبورن',
  'Sakhir':       'السخير',
  'Miami':        'ميامي',
  'Imola':        'إيمولا',
  'Monte-Carlo':  'مونت كارلو',
  'Montreal':     'مونتريال',
  'Barcelona':    'برشلونة',
  'Spielberg':    'شبيلبرغ',
  'Silverstone':  'سيلفرستون',
  'Budapest':     'بودابست',
  'Francorchamps':'فرانكورشامب',
  'Zandvoort':    'زاندفورت',
  'Monza':        'مونزا',
  'Baku':         'باكو',
  'Singapore':    'سنغافورة',
  'Austin':       'أوستن',
  'Mexico City':  'مكسيكو سيتي',
  'São Paulo':    'ساو باولو',
  'Las Vegas':    'لاس فيغاس',
  'Lusail':       'لوسيل',
  'Abu Dhabi':    'أبوظبي',

  // countries (country field from API)
  'China':          'الصين',
  'Japan':          'اليابان',
  'Australia':      'أستراليا',
  'Bahrain':        'البحرين',
  'United States':  'الولايات المتحدة',
  'Italy':          'إيطاليا',
  'Monaco':         'موناكو',
  'Canada':         'كندا',
  'Spain':          'إسبانيا',
  'Austria':        'النمسا',
  'United Kingdom': 'المملكة المتحدة',
  'Hungary':        'المجر',
  'Belgium':        'بلجيكا',
  'Netherlands':    'هولندا',
  'Azerbaijan':     'أذربيجان',
  'Mexico':         'المكسيك',
  'Brazil':         'البرازيل',
  'Qatar':          'قطر',
  'UAE':            'الإمارات',
};

// Circuit names
const Map<String, String> circuitsAr = {
  'Bahrain International Circuit':        'حلبة البحرين الدولية',
  'Suzuka Circuit':                       'حلبة سوزوكا',
  'Albert Park Grand Prix Circuit':       'حلبة ألبرت بارك',
  'Shanghai International Circuit':       'حلبة شنغهاي الدولية',
  'Miami International Autodrome':        'أوتودروم ميامي الدولي',
  'Circuit de Monaco':                    'حلبة موناكو',
  'Circuit Gilles Villeneuve':            'حلبة جيل فيلنوف',
  'Circuit de Barcelona-Catalunya':       'حلبة برشلونة-كتالونيا',
  'Red Bull Ring':                        'حلبة ريد بول',
  'Silverstone Circuit':                  'حلبة سيلفرستون',
  'Hungaroring':                          'هنغاروينغ',
  'Circuit de Spa-Francorchamps':         'حلبة سبا-فرانكورشامب',
  'Circuit Zandvoort':                    'حلبة زاندفورت',
  'Autodromo Nazionale di Monza':         'أوتودروم مونزا الوطني',
  'Baku City Circuit':                    'حلبة مدينة باكو',
  'Marina Bay Street Circuit':            'حلبة مارينا باي',
  'Circuit of the Americas':              'حلبة الأمريكتين',
  'Autodromo Hermanos Rodriguez':         'أوتودروم إيرمانوس رودريغيز',
  'Autodromo Jose Carlos Pace':           'أوتودروم خوسيه كارلوس باسي',
  'Las Vegas Strip Circuit':              'حلبة لاس فيغاس',
  'Lusail International Circuit':         'حلبة لوسيل الدولية',
  'Yas Marina Circuit':                   'حلبة ياس مارينا',
  'Imola Circuit':                        'حلبة إيمولا',
};

//  Team names
const Map<String, String> teamsAr = {
  'Red Bull Racing':    'ريد بول ريسينغ',
  'Red Bull':    'ريد بول',
  'Ferrari':            'فيراري',
  'McLaren':            'ماكلارين',
  'Mercedes':           'مرسيدس',
  'Aston Martin':       'أستون مارتن',
  'Alpine F1 Team':     'ألباين',
  'Williams':           'ويليامز',
  'Haas F1 Team':       'هاس',
  'RB F1 Team':         'ريسينغ بولز',
  'Sauber':             'ساوبر',
  'Cadillac F1 Team':   'كاديلاك',
  'Audi':               'أودي',
};
const Map<String, String> nationalitiesAr = {
  'British':      'بريطانية',
  'German':       'ألمانية',
  'Italian':      'إيطالية',
  'French':       'فرنسية',
  'Austrian':     'نمساوية',
  'American':     'أمريكية',
  'Swiss':        'سويسرية',
  'Japanese':     'يابانية',
  'Malaysian':    'ماليزية',
  'Canadian':     'كندية',
  'Dutch':        'هولندية',
  'Spanish':      'إسبانية',
};
const Map<String, String> driversAr = {
  // Full names exactly as the API returns them
  'Max Verstappen':        'ماكس فيرستابن',
  'Lando Norris':          'لاندو نوريس',
  'Charles Leclerc':       'شارل لوكلير',
  'Lewis Hamilton':        'لويس هاميلتون',
  'George Russell':        'جورج راسل',
  'Oscar Piastri':         'أوسكار بياستري',
  'Carlos Sainz':          'كارلوس سينز',
  'Fernando Alonso':       'فيرناندو ألونسو',
  'Lance Stroll':          'لانس سترول',
  'Pierre Gasly':          'بيير غاسلي',
  'Esteban Ocon':          'إستيبان أوكون',
  'Alexander Albon':       'ألكسندر ألبون',
  'Nico Hulkenberg':       'نيكو هولكنبرغ',
  'Yuki Tsunoda':          'يوكي تسونودا',
  'Liam Lawson':           'ليام لوسون',
  'Isack Hadjar':          'إيزاك هادجار',
  'Oliver Bearman':        'أوليفر بيرمان',
  'Gabriel Bortoleto':     'غابرييل بورتوليتو',
  'Jack Doohan':           'جاك دوهان',
  'Andrea Kimi Antonelli': 'أندريا كيمي أنتونيلي',
  'Franco Colapinto':      'فرانكو كولابينتو',
};

String translateDriver(BuildContext context, String name) {
  if (!_isAr(context)) return name;
  return driversAr[name] ?? name;
}

String translateNationality(BuildContext context, String nationality) {
  if (!_isAr(context)) return nationality;
  return nationalitiesAr[nationality] ?? nationality;
}




bool _isAr(BuildContext context) =>
    Localizations.localeOf(context).languageCode == 'ar';

String translateRaceName(BuildContext context, String name) {
  if (!_isAr(context)) return name;
  return raceNamesAr[name] ?? name;
}

String translateLocation(BuildContext context, String location) {
  if (!_isAr(context)) return location;
  return locationsAr[location] ?? location;
}

String translateCircuit(BuildContext context, String circuit) {
  if (!_isAr(context)) return circuit;
  return circuitsAr[circuit] ?? circuit;
}

String translateTeam(BuildContext context, String team) {
  if (!_isAr(context)) return team;
  return teamsAr[team] ?? team;
}