class DriverStandingModel {
  final int position; // 1, 2, 3, ...
  final int points; // total season points
  final int wins; // number of wins this season
  final String driverId;
  final String code;
  final String givenName;
  final String familyName;
  final String fullName;
  final String constructorName;
  final String image;
  final String dateOfBirth;
  final String permanentNumber;
  final String nationality;
  final String url;

  DriverStandingModel({
    required this.position,
    required this.points,
    required this.wins,
    required this.driverId,
    required this.code,
    required this.givenName,
    required this.familyName,
    required this.fullName,
    required this.constructorName,
    required this.image,
    required this.dateOfBirth,
    required this.permanentNumber,
    required this.nationality,
    required this.url,
  });

  // these are real data except for image coz api doesn't provide them
  factory DriverStandingModel.fromJson(Map<String, dynamic> json) {
    final driver = json['Driver'];
    final constructors = (json['Constructors'] as List?) ?? [];
    final constructorName = constructors.isNotEmpty
        ? constructors[0]['name'] as String
        : 'Unknown';

    final code = (driver['code'] ?? '') as String;
    final fullName =
        "${driver['givenName'] ?? ''} ${driver['familyName'] ?? ''}".trim();

    const images = {
      'VER': 'assets/images/drivers/max_verstappen.webp',
      'HAM': 'assets/images/drivers/lewis_hamilton.webp',
      'NOR': 'assets/images/drivers/lando_norris.jpeg',
      'LEC': 'assets/images/drivers/charles_leclerc.jpeg',
      'SAI': 'assets/images/drivers/carlos_sainz.jpeg',
      'RUS': 'assets/images/drivers/george_russell.jpeg',
      'ALO': 'assets/images/drivers/fernando_alonso.webp',
      'STR': 'assets/images/drivers/lance_stroll.jpeg',
      'GAS': 'assets/images/drivers/pierre_gasly.jpeg',
      'OCO': 'assets/images/drivers/esteban_ocon.webp',
      'ALB': 'assets/images/drivers/alex_albon.png',
      'HUL': 'assets/images/drivers/nico_hulkenberg.jpeg',
      'PIA': 'assets/images/drivers/oscar_piastri.jpeg',
      'TSU': 'assets/images/drivers/yuki_tsunoda.webp',
      'COL': 'assets/images/drivers/franco_colapinto.jpeg',
      'BEA': 'assets/images/drivers/oliver_bearman.jpeg',
      'ANT': 'assets/images/drivers/kimi_antonelli.webp',
      'LAW': 'assets/images/drivers/liam_lawson.webp',
      'HAD': 'assets/images/drivers/isack_hadjar.webp',
      'BOR': 'assets/images/drivers/gabriel_bortoleto.jpeg',
      'DOO': 'assets/images/drivers/jack_doohan.jpeg',
    };

    return DriverStandingModel(
      url: driver['url'],
      permanentNumber: driver['code'],
      nationality: driver['nationality'],
      dateOfBirth: driver['dateOfBirth'],
      position: int.parse(json['position'] as String),
      points: int.parse(json['points'] as String),
      wins: int.parse(json['wins'] as String),
      driverId: driver['driverId'] as String,
      code: code,
      givenName: driver['givenName'] as String,
      familyName: driver['familyName'] as String,
      fullName: fullName,
      constructorName: constructorName,
      image: images[code] ?? 'assets/images/drivers/default.webp',
    );
  }
}
