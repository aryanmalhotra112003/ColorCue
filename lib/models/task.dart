class Task {
  String name;
  late DateTime id;

  Task({required this.name, DateTime? id}) : id = id ?? DateTime.now();

  // Convert Task to JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'id': id.toIso8601String(), // Convert DateTime to String
    };
  }

  // Convert JSON to Task
  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      name: json['name'],
      id: DateTime.parse(json['id']), // Convert String back to DateTime
    );
  }
}
