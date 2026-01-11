class RaceInfoModel {
  final String title;
  final String circuit;
  final String date;
  final String location;
  final String? winner;
  final String? team;
  final String? fp1Date;
  final String? fp2Date;
  final String? fp3Date;
  final String? qualiDate;

  RaceInfoModel({
    required this.title,
    required this.circuit,
    required this.date,
    required this.location,
    this.winner,
    this.team,
     this.fp1Date,
     this.fp2Date,
     this.fp3Date,
     this.qualiDate,
  });
}
