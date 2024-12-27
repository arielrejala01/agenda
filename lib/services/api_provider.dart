import 'package:agenda/models/reminder.dart';
import 'package:agenda/services/db.dart';

class ApiProvider extends DBProvider {
  ApiProvider._();

  static final ApiProvider db = ApiProvider._();

  Future<int> newReminder(Reminder reminder) async {
    final db = (await database)!;
    var res = await db.insert('agenda', reminder.toJson());

    return res;
  }

  Future<List<Reminder>> getReminders() async {
    final db = (await database)!;
    var res = await db.query('agenda');
    List<Reminder> reminders = res.isNotEmpty
        ? res.map((note) => Reminder.fromJson(note)).toList()
        : [];

    return reminders;
  }

  Future<int> deleteReminder(int? id) async {
    final db = (await database)!;

    var res = await db.delete('agenda', where: 'id = ?', whereArgs: [id]);
    return res;
  }

  Future<List<Reminder>> getRemindersByDate(String selectedDate) async {
    final db = (await database)!;

    var res = await db.query(
      'agenda',
      where: 'date = ?',
      whereArgs: [selectedDate],
    );

    List<Reminder> reminders = res.isNotEmpty
        ? res.map((reminder) => Reminder.fromJson(reminder)).toList()
        : [];

    return reminders;
  }
}
