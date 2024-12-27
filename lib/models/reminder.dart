class Reminder {
  int? id;
  String? title;
  String? date;
  String? time;
  int priority;

  Reminder({this.id, this.title, this.date, this.time, this.priority = 2});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (id != null) data['id'] = id;
    data['title'] = title;
    data['date'] = date;
    data['time'] = time;
    data['priority'] = priority;
    return data;
  }

  factory Reminder.fromJson(Map<String, dynamic> json) {
    return Reminder(
      id: json['id'],
      title: json['title'],
      date: json['date'],
      time: json['time'],
      priority: json['priority'],
    );
  }
}
