class TeamsModel {
  final int id; // new numeric ID (for API use)
  final String constructorId;
  final String teamName;
  final String nationality;
  final String logo;
  final String url;
  final String carImage;
  final int? points;

  TeamsModel({
    this.points,
    required this.id,
    required this.constructorId,
    required this.teamName,
    required this.nationality,
    required this.logo,
    required this.url,
    required this.carImage,


  });

  factory TeamsModel.fromJson(Map<String, dynamic> json ,{int? index}) {
    final name = json['name'] ?? '';

    const logos = {
      'Mercedes': 'assets/images/Mercedes.svg',
      'Red Bull': 'assets/images/redbull.png',
      'Ferrari': 'assets/images/ferrari.svg',
      'McLaren': 'assets/images/mclaren.svg',
      'Aston Martin': 'assets/images/Aston_Martin.png',
      'Alpine F1 Team': 'assets/images/alpine.png',
      'Williams': 'assets/images/williams.svg',
      'Haas F1 Team': 'assets/images/haas.svg',
      'RB F1 Team': 'assets/images/RB.svg',
      'Sauber': 'assets/images/Kick Sauber.png',
    };

    const cars = {
      'Mercedes': 'assets/images/cars/mercedes.jpg',
      'Red Bull': 'assets/images/cars/redbull.jpg',
      'Ferrari': 'assets/images/cars/ferrari.jpg',
      'McLaren': 'assets/images/cars/mclaren.jpg',
      'Aston Martin': 'assets/images/cars/aston_martin.jpg',
      'Alpine F1 Team': 'assets/images/cars/alpine.jpg',
      'Williams': 'assets/images/cars/williams.jpg',
      'Haas F1 Team': 'assets/images/cars/haas.jpg',
      'RB F1 Team': 'assets/images/cars/racing_bulls.jpg',
      'Sauber': 'assets/images/cars/kick_sauber.jpg',
    };
    // season points for team
    const points = {
      'McLaren': 756,
      'Mercedes': 431,
      'Red Bull': 391,
      'Ferrari': 378,
      'Williams': 121,
      'RB F1 Team': 90,
      'Haas F1 Team': 73,
      'Aston Martin': 72,
      'Sauber': 68,
      'Alpine F1 Team': 22,
    };


    return TeamsModel(
      carImage: cars[name] ?? 'assets/images/cars/ferrari.jpg' ,
      id: index ?? json['id'] ?? 0,
      url: json["url"],
      constructorId: json["constructorId"],
      teamName: name,
      nationality: json['nationality'] ?? '',
      logo: logos[name] ?? 'assets/images/F1_logo.svg', // fallback if missing
      points: points[name],
    );
  }
}
//takes a map and returns TeamModel


//So you can use the constructorId from your TeamsModel to call the API when the TeamDetails page opens.