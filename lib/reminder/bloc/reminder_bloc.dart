import 'package:agenda/models/reminder.dart';
import 'package:agenda/services/api_provider.dart';
import 'package:bloc/bloc.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

part 'reminder_event.dart';
part 'reminder_state.dart';

class ReminderBloc extends Bloc<ReminderEvent, ReminderState> {
  ReminderBloc() : super(ReminderInitial()) {
    on<LoadReminders>(_mapLoadRemindersToState);
    on<LoadRemindersByDate>(_mapLoadRemindersByDateToState);
    on<AddReminder>(_mapAddReminderToState);
    on<DeleteReminder>(_mapDeleteReminderToState);
  }

  _mapLoadRemindersToState(LoadReminders event, emit) async {
    emit(ReminderLoading());

    var reminders = await ApiProvider.db.getReminders();

    reminders.sort((a, b) {
      DateTime dateA = DateFormat('dd-MM-yyyy').parse(a.date ?? '01-01-1970');
      DateTime dateB = DateFormat('dd-MM-yyyy').parse(b.date ?? '01-01-1970');

      if (dateA.compareTo(dateB) == 0) {
        DateTime timeA = DateFormat('HH:mm').parse(a.time ?? '00:00');
        DateTime timeB = DateFormat('HH:mm').parse(b.time ?? '00:00');
        return timeA.compareTo(timeB);
      }

      return dateA.compareTo(dateB);
    });

    emit(ReminderLoaded(reminders: reminders));
  }

  _mapLoadRemindersByDateToState(LoadRemindersByDate event, emit) async {
    emit(ReminderLoading());

    var reminders = await ApiProvider.db.getRemindersByDate(event.date ?? '');

    reminders.sort((a, b) => a.priority.compareTo(b.priority));

    emit(ReminderLoaded(reminders: reminders));
  }

  _mapAddReminderToState(AddReminder event, emit) async {
    emit(ReminderLoading());
    try {
      Reminder reminder = Reminder(
          title: event.title,
          date: event.date,
          time: event.time,
          priority: event.priority);

      await ApiProvider.db.newReminder(reminder);

      var reminders = await ApiProvider.db.getReminders();
      emit(ReminderLoaded(reminders: reminders));
    } catch (e) {
      emit(ReminderNotLoaded(error: e.toString()));
    }
  }

  _mapDeleteReminderToState(DeleteReminder event, emit) async {
    emit(ReminderLoading());
    try {
      await ApiProvider.db.deleteReminder(event.id);

      if (event.date != null) {
        var reminders =
            await ApiProvider.db.getRemindersByDate(event.date ?? '');

        reminders.sort((a, b) => a.priority.compareTo(b.priority));

        emit(ReminderLoaded(reminders: reminders));
      } else {
        var reminders = await ApiProvider.db.getReminders();

        emit(ReminderLoaded(reminders: reminders));
      }
    } catch (e) {
      emit(ReminderNotLoaded(error: e.toString()));
    }
  }
}
