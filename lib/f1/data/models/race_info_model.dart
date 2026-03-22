class RaceInfoModel {
  final String title;
  final String circuit;
  final String date;
  final String locality;
  final String country;
  final String? winner;
  final String? team;
  final String? fp1Date;
  final String? fp2Date;
  final String? qualiDate;
  final String? sprintQualiDate;
  final String? sprintDate;

  RaceInfoModel({
    required this.title,
    required this.circuit,
    required this.date,
    required this.locality,
    required this.country,
    this.winner,
    this.team,
    this.fp1Date,
    this.fp2Date,
    this.qualiDate,
    this.sprintQualiDate,
    this.sprintDate,
  });
}
