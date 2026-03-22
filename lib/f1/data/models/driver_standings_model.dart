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
  final String image; // network URL
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

    // Network image URLs — same source as FantasyDriverData
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

    return DriverStandingModel(
      url: driver['url'],
      permanentNumber: driver['code'],
      nationality: driver['nationality'],
      dateOfBirth: driver['dateOfBirth'],
      position: int.tryParse(json['position'] as String? ?? '0') ?? 0,
      points: int.parse(json['points'] as String),
      wins: int.parse(json['wins'] as String),
      driverId: driver['driverId'] as String,
      code: code,
      givenName: driver['givenName'] as String,
      familyName: driver['familyName'] as String,
      fullName: fullName,
      constructorName: constructorName,
      // Falls back to a placeholder if the code isn't in the map
      image: images[code] ?? 'https://media.formula1.com/d_driver_fallback_image.png/content/dam/fom-website/drivers/S/silhouette.png',
    );
  }
}