class RaceDetails {
  final String season;
  final String round;
  final String raceName;
  final DateTime dateTime;
  final Circuit circuit;
  final List<RaceResult> results;

  RaceDetails({
    required this.season,
    required this.round,
    required this.raceName,
    required this.dateTime,
    required this.circuit,
    required this.results,
  });

  factory RaceDetails.fromJson(Map<String, dynamic> json) {
    final date = json['date'] as String;
    final time = (json['time'] as String?) ?? '00:00:00Z';

    return RaceDetails(
      season: json['season'],
      round: json['round'],
      raceName: json['raceName'],
      dateTime: DateTime.parse('${date}T$time'),
      circuit: Circuit.fromJson(json['Circuit']),
      results: (json['Results'] as List)
          .map((e) => RaceResult.fromJson(e))
          .toList(),
    );
  }
}

class Circuit {
  final String circuitId;
  final String circuitName;
  final String locality;
  final String country;

  Circuit({
    required this.circuitId,
    required this.circuitName,
    required this.locality,
    required this.country,
  });

  factory Circuit.fromJson(Map<String, dynamic> json) {
    final loc = json['Location'] as Map<String, dynamic>;
    return Circuit(
      circuitId: json['circuitId'],
      circuitName: json['circuitName'],
      locality: loc['locality'],
      country: loc['country'],
    );
  }
}

class RaceResult {
  final int position;
  final String positionText;
  final int points;
  final int grid;
  final int laps;
  final String status;
  final RaceDriver driver;
  final RaceConstructor constructor;
  final String? finishTime;      // e.g. "1:21:08.429" أو "+23.546"
  final String? fastestLapTime;  // e.g. "1:33.365"
  final int? fastestLapRank;     // e.g. 1

  RaceResult({
    required this.position,
    required this.positionText,
    required this.points,
    required this.grid,
    required this.laps,
    required this.status,
    required this.driver,
    required this.constructor,
    this.finishTime,
    this.fastestLapTime,
    this.fastestLapRank,
  });

  factory RaceResult.fromJson(Map<String, dynamic> json) {
    final time = json['Time'] as Map<String, dynamic>?;
    final fastest = json['FastestLap'] as Map<String, dynamic>?;

    return RaceResult(
      position: int.parse(json['position']),
      positionText: json['positionText'],
      points: int.parse(json['points']),
      grid: int.parse(json['grid']),
      laps: int.parse(json['laps']),
      status: json['status'],
      driver: RaceDriver.fromJson(json['Driver']),
      constructor: RaceConstructor.fromJson(json['Constructor']),
      finishTime: time != null ? time['time'] as String : null,
      fastestLapTime: fastest != null
          ? (fastest['Time'] as Map<String, dynamic>)['time'] as String
          : null,
      fastestLapRank:
      fastest != null ? int.parse(fastest['rank'] as String) : null,
    );
  }
}

class RaceDriver {
  final String driverId;
  final String code;
  final String givenName;
  final String familyName;
  final String nationality;
  final String? permanentNumber;
  final String url;

  String get fullName => '$givenName $familyName';

  RaceDriver({
    required this.driverId,
    required this.code,
    required this.givenName,
    required this.familyName,
    required this.nationality,
    required this.url,
    this.permanentNumber,
  });

  factory RaceDriver.fromJson(Map<String, dynamic> json) {
    return RaceDriver(
      driverId: json['driverId'],
      code: json['code'] ?? '',
      givenName: json['givenName'],
      familyName: json['familyName'],
      nationality: json['nationality'],
      url: json['url'],
      permanentNumber: json['permanentNumber'],
    );
  }
}

class RaceConstructor {
  final String constructorId;
  final String name;
  final String nationality;
  final String url;

  RaceConstructor({
    required this.constructorId,
    required this.name,
    required this.nationality,
    required this.url,
  });

  factory RaceConstructor.fromJson(Map<String, dynamic> json) {
    return RaceConstructor(
      constructorId: json['constructorId'],
      name: json['name'],
      nationality: json['nationality'],
      url: json['url'],
    );
  }
}
