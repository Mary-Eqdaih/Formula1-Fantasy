class NotesModel {
  NotesModel({
    required this.title,
    required this.content,
    required this.date,
    required this.userId,
    this.id = 0,
  });

  final String title;
  final String content;
  final String date;
  final String userId;
  final int id;

  NotesModel.fromJson(Map<String, dynamic> json)
      : title = json["title"],
        date = json["date"],
        content = json["content"],
        userId = json["userId"] ?? "",
        id = json["id"];

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "content": content,
      "date": date,
      "userId": userId,
    };
  }
}
