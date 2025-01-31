class Task {
  final String id;
  final String name;
  final String projectId;
  bool completed;
  final int estimatedTime; // Temps estimé en secondes
  int elapsedTime; // Temps écoulé en secondes
  final String priority; // Haute, Moyenne, Faible
  DateTime? completedDate; // Date d'achèvement (nullable)

  Task({
    required this.id,
    required this.name,
    required this.projectId,
    required this.completed,
    required this.estimatedTime,
    required this.elapsedTime,
    required this.priority,
    this.completedDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'projectId': projectId,
      'completed': completed,
      'estimatedTime': estimatedTime,
      'elapsedTime': elapsedTime,
      'priority': priority,
      'completedDate': completedDate?.toIso8601String(),
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      name: map['name'],
      projectId: map['projectId'],
      completed: map['completed'],
      estimatedTime: map['estimatedTime'],
      elapsedTime: map['elapsedTime'],
      priority: map['priority'],
      completedDate: map['completedDate'] != null
          ? DateTime.parse(map['completedDate'])
          : null,
    );
  }
}