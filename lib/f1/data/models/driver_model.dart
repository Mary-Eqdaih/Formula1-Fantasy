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
      'HUL': 'Audi',
      'PIA': 'McLaren',
      'TSU': 'Red Bull Racing',
      'COL': 'Alpine',
      'BEA': 'Haas F1 Team',
      'ANT': 'Mercedes',
      'LAW': 'RB F1 Team',
      'HAD': 'RB F1 Team',
      'BOR': 'Audi',
      'DOO': 'Alpine',
      'PER': 'Cadilac F1 Team',
      'BOT': 'Cadilac F1 Team',
    };

    final WCS = {
      'VER': 4,
      'HAM': 7,
      'NOR': 1,
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
      'PER': 0,
      'BOT': 0,
    };

    // season points for driver
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
      'PER': 0,
      'BOT': 0,
    };

    // Using d_driver_fallback_image.png URL format — same as FantasyDriverData
    // This format works without headers unlike the image/upload/f_auto format
    const images = {
      'VER': 'https://media.formula1.com/d_driver_fallback_image.png/content/dam/fom-website/drivers/M/MAXVER01_Max_Verstappen/maxver01.png',
      'HAM': 'https://media.formula1.com/d_driver_fallback_image.png/content/dam/fom-website/drivers/L/LEWHAM01_Lewis_Hamilton/lewham01.png',
      'NOR': 'https://media.formula1.com/d_driver_fallback_image.png/content/dam/fom-website/drivers/L/LANNOR01_Lando_Norris/lannor01.png',
      'LEC': 'https://media.formula1.com/d_driver_fallback_image.png/content/dam/fom-website/drivers/C/CHALEC01_Charles_Leclerc/chalec01.png',
      'SAI': 'https://media.formula1.com/d_driver_fallback_image.png/content/dam/fom-website/drivers/C/CARSAI01_Carlos_Sainz/carsai01.png',
      'RUS': 'https://media.formula1.com/d_driver_fallback_image.png/content/dam/fom-website/drivers/G/GEORUS01_George_Russell/georus01.png',
      'ALO': 'https://media.formula1.com/d_driver_fallback_image.png/content/dam/fom-website/drivers/F/FERALO01_Fernando_Alonso/feralo01.png',
      'STR': 'https://media.formula1.com/d_driver_fallback_image.png/content/dam/fom-website/drivers/L/LANSTR01_Lance_Stroll/lanstr01.png',
      'GAS': 'https://media.formula1.com/d_driver_fallback_image.png/content/dam/fom-website/drivers/P/PIEGAS01_Pierre_Gasly/piegas01.png',
      'OCO': 'https://media.formula1.com/d_driver_fallback_image.png/content/dam/fom-website/drivers/E/ESTOCO01_Esteban_Ocon/estoco01.png',
      'ALB': 'https://media.formula1.com/d_driver_fallback_image.png/content/dam/fom-website/drivers/A/ALEALB01_Alexander_Albon/alealb01.png',
      'HUL': 'https://media.formula1.com/d_driver_fallback_image.png/content/dam/fom-website/drivers/N/NICHUL01_Nico_Hulkenberg/nichul01.png',
      'PIA': 'https://media.formula1.com/d_driver_fallback_image.png/content/dam/fom-website/drivers/O/OSCPIA01_Oscar_Piastri/oscpia01.png',
      'TSU': 'https://media.formula1.com/d_driver_fallback_image.png/content/dam/fom-website/drivers/Y/YUKTSU01_Yuki_Tsunoda/yuktsu01.png',
      'BEA': 'https://media.formula1.com/d_driver_fallback_image.png/content/dam/fom-website/drivers/O/OLIBEA01_Oliver_Bearman/olibea01.png',
      'ANT': 'https://media.formula1.com/d_driver_fallback_image.png/content/dam/fom-website/drivers/K/KIMANT01_Kimi_Antonelli/kimant01.png',
      'LAW': 'https://media.formula1.com/d_driver_fallback_image.png/content/dam/fom-website/drivers/L/LIALAW01_Liam_Lawson/lialaw01.png',
      'HAD': 'https://media.formula1.com/d_driver_fallback_image.png/content/dam/fom-website/drivers/I/ISAHAD01_Isack_Hadjar/isahad01.png',
      'BOR': 'https://media.formula1.com/d_driver_fallback_image.png/content/dam/fom-website/drivers/G/GABBOR01_Gabriel_Bortoleto/gabbor01.png',
      'DOO': 'https://media.formula1.com/d_driver_fallback_image.png/content/dam/fom-website/drivers/J/JACDOO01_Jack_Doohan/jacdoo01.png',
      'COL': 'https://media.formula1.com/d_driver_fallback_image.png/content/dam/fom-website/drivers/F/FRACOL01_Franco_Colapinto/fracol01.png',
    };

    return DriverModel(
      image: images[code] ?? 'https://media.formula1.com/d_driver_fallback_image.png/content/dam/fom-website/drivers/S/silhouette.png',
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