part of 'reminder_bloc.dart';

@immutable
sealed class ReminderState {}

final class ReminderInitial extends ReminderState {}

final class ReminderLoaded extends ReminderState {
  final List<Reminder>? reminders;

  ReminderLoaded({this.reminders});
}

final class ReminderLoading extends ReminderState {}

final class ReminderNotLoaded extends ReminderState {
  final String? error;

  ReminderNotLoaded({this.error});
}
