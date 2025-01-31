class Project {
  final String id;
  final String name;
  final String categoryId;
  final List<String> technologies;
  final List<String> devLinks;
  final String status;

  Project({
    required this.id,
    required this.name,
    required this.categoryId,
    required this.technologies,
    required this.devLinks,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    final map = {
      'id': id,
      'name': name,
      'categoryId': categoryId,
      'technologies': technologies,
      'devLinks': devLinks,
      'status': status,
    };
    print('Project.toMap: $map'); // Vérification
    return map;
  }

  factory Project.fromMap(Map<String, dynamic> map) {
    print('Project.fromMap: $map'); // Vérification
    return Project(
      id: map['id'],
      name: map['name'],
      categoryId: map['categoryId'],
      technologies: List<String>.from(map['technologies']),
      devLinks: List<String>.from(map['devLinks']),
      status: map['status'],
    );
  }
}
