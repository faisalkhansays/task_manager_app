class TaskModel {
  final String id;
  final String title;
  final String description;
  final DateTime date;

  TaskModel({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
  });

  // Convert a TaskModel to a Map (for JSON encoding)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'date': date.toIso8601String(),
    };
  }

  // Convert a Map to a TaskModel (for JSON decoding)
  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      date: DateTime.parse(json['date']),
    );
  }
}
