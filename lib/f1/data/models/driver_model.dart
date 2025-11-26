class DriverModel {
  final String driverId;
  final String name;
  final String givenName;
  final String familyName;
  final String nationality;
  final String dateOfBirth;
  final String? permanentNumber;
  final String code;
  final String? url;
  final String image;
  final String team;
  final int? raceWins;
  final int points;

  DriverModel({
    required this.driverId,
    required this.name,
    required this.givenName,
    required this.familyName,
    required this.nationality,
    required this.dateOfBirth,
    this.permanentNumber,
    required this.code,
    this.url,
    required this.image,
    required this.team,
    this.raceWins,
    required this.points,
  });

  // Factory method to create a DriverModel from JSON data
  factory DriverModel.fromJson(Map<String, dynamic> json) {
    final code = json['code'] ?? '';
    final fullName = "${json['givenName'] ?? ''} ${json['familyName'] ?? ''}"
        .trim();

    // Static data for team, WCS, and points bcoz api doesnt provide this data
    const teamData = {
      'VER': 'Red Bull Racing',
      'HAM': 'Ferrari',
      'NOR': 'McLaren',
      'LEC': 'Ferrari',
      'SAI': 'Williams',
      'RUS': 'Mercedes',
      'ALO': 'Williams',
      'STR': 'Aston Martin',
      'GAS': 'Alpine',
      'OCO': 'Haas F1 Team',
      'ALB': 'Williams',
      'HUL': 'Saubar',
      'PIA': 'McLaren',
      'TSU': 'Red Bull Racing',
      'COL': 'Alpine',
      'BEA': 'Haas F1 Team',
      'ANT': 'Mercedes',
      'LAW': 'RB F1 Team',
      'HAD': 'RB F1 Team',
      'BOR': 'Saubar',
      'DOO': 'Alpine',
    };
    final WCS = {
      'VER': 4,
      'HAM': 7,
      'NOR': 0,
      'LEC': 0,
      'SAI': 0,
      'RUS': 0,
      'ALO': 2,
      'STR': 0,
      'GAS': 0,
      'OCO': 0,
      'ALB': 0,
      'HUL': 0,
      'PIA': 0,
      'TSU': 0,
      'COL': 0,
      'BEA': 0,
      'ANT': 0,
      'LAW': 0,
      'HAD': 0,
      'BOR': 0,
      'DOO': 0,
    };

    // season poitns for driver
    const points = {
      'NOR': 390,
      'PIA': 366,
      'VER': 366,
      'RUS': 294,
      'LEC': 226,
      'HAM': 152,
      'ANT': 137,
      'ALB': 73,
      'HAD': 51,
      'HUL': 49,
      'SAI': 48,
      'BEA': 41,
      'ALO': 40,
      'LAW': 36,
      'OCO': 32,
      'STR': 32,
      'TSU': 28,
      'GAS': 22,
      'BOR': 19,
      'COL': 0,
      'DOO': 0,
    };

    // Static Image Mapping (kept as-is from your initial code)
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

    return DriverModel(
      image:
          images[code] ??
          'assets/images/drivers/default.webp', // Use static images
      driverId: json["driverId"] ?? '',
      name: fullName,
      givenName: json["givenName"] ?? '',
      familyName: json["familyName"] ?? '',
      nationality: json["nationality"] ?? '',
      dateOfBirth: json["dateOfBirth"] ?? '',
      permanentNumber: json["permanentNumber"],
      code: code,
      url: json["url"],
      team: teamData[code] ?? 'Unknown Team', // Use static data for team
      raceWins: WCS[code], // Use static data for race wins
      points: points[code] ?? 0, // Use static data for points
    );
  }
}
