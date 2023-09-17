class Task {
  int id = 0;
  final String name;
  final String description;
  final String status;

  Task({
    required this.id,
    required this.name,
    required this.description,
    required this.status,
  });

  Task.noId({
    required this.name,
    required this.description,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "description": description,
      "status": status,
    };
  }

  Map<String, dynamic> toMapWithId() {
    return {
      "id": id,
      "name": name,
      "description": description,
      "status": status,
    };
  }
}
