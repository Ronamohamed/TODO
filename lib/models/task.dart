class Task {
  static const String collectionName = 'tasks_collection';

  String? id;
  String? title;
  String? desc;
  DateTime? date;
  bool? isDone;

  Task(
      {this.id = "",
      required this.title,
      this.desc,
      required this.date,
      this.isDone = false});

  /// From Firestore
  Task.fromJson(Map<String, dynamic> json)
      : this(
            id: json['id'] as String?,
            title: json['title'] as String?,
            desc: json['desc'] as String?,
            date: DateTime.fromMillisecondsSinceEpoch(json['date']),
            isDone: json['isDone'] as bool?);

  /// To Firestore
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'desc': desc,
      'date': date?.millisecondsSinceEpoch,
      'isDone': isDone
    };
  }
}
