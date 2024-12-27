part of 'reminder_bloc.dart';

@immutable
sealed class ReminderEvent {}

final class LoadReminders extends ReminderEvent {}

final class LoadRemindersByDate extends ReminderEvent {
  final String? date;

  LoadRemindersByDate({this.date});
}

final class AddReminder extends ReminderEvent {
  final String? title;
  final String? date;
  final String? time;
  final int priority;

  AddReminder({this.title, this.date, this.time, this.priority = 2});
}

final class DeleteReminder extends ReminderEvent {
  final int? id;
  final String? date;

  DeleteReminder({this.id, this.date});
}
