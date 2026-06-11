class Task {
  int? id;
  String title;
  String? description;
  String category;
  String priority;
  String date;
  int status;
  int userId;

  Task({
    this.id,
    required this.title,
    this.description,
    required this.category,
    required this.priority,
    required this.date,
    this.status = 0,
    required this.userId,
  });

  // Objet Dart -> SQLite
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'category': category,
      'priority': priority,
      'date': date,
      'status': status,
      'user_id': userId,
    };
  }

  // SQLite -> Objet Dart
  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      category: map['category'],
      priority: map['priority'],
      date: map['date'],
      status: map['status'],
      userId: map['user_id'],
    );
  }
}
