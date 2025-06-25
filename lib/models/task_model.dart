class Task {
  final int id;
  final String title;
  final String date;
  final String time;
  final String status;

  Task({
    required this.id,
    required this.title,
    required this.date,
    required this.time,
    required this.status,
  });

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'] as int,
      title: map['title'] as String,
      date: map['date'] as String,
      time: map['time'] as String,
      status: map['status'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'date': date,
      'time': time,
      'status': status,
    };
  }
}