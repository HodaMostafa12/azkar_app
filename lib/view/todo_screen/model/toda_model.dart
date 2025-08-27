class TodoModel{
  final String id;
  final String title;
  final bool isComplated;
  final DateTime taskDate;
  final DateTime? createdAt;
  
  TodoModel({
    required this.id,
    required this.isComplated,
    required this.title,
    required this.taskDate,
    required this.createdAt,
  });

  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
      id: json['id'],
      title: json['title'],
      isComplated: json['is_completed'],
      taskDate: DateTime.parse(json['task_date']),
      createdAt:  json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
    );
  }
}