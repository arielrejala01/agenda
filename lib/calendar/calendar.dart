import 'package:agenda/reminder/bloc/reminder_bloc.dart';
import 'package:agenda/reminder/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatefulWidget {
  const Calendar({super.key});

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TableCalendar(
          locale: 'es_ES',
          firstDay: DateTime.utc(2010, 10, 16),
          lastDay: DateTime.utc(2030, 3, 14),
          headerStyle: const HeaderStyle(
            formatButtonDecoration: BoxDecoration(
              border: Border.fromBorderSide(BorderSide(
                color: Color.fromRGBO(76, 89, 153, 1),
              )),
              borderRadius: BorderRadius.all(Radius.circular(12.0)),
            ),
            formatButtonTextStyle: TextStyle(color: Colors.black, fontSize: 14),
            leftChevronIcon: Icon(
              FontAwesomeIcons.chevronLeft,
              color: Color.fromRGBO(76, 89, 153, 1),
              size: 20,
            ),
            rightChevronIcon: Icon(
              FontAwesomeIcons.chevronRight,
              color: Color.fromRGBO(76, 89, 153, 1),
              size: 20,
            ),
          ),
          calendarFormat: _calendarFormat,
          availableCalendarFormats: const {
            CalendarFormat.week: 'Semana',
            CalendarFormat.twoWeeks: '2 semanas',
            CalendarFormat.month: 'Mes'
          },
          onFormatChanged: (format) {
            if (_calendarFormat != format) {
              setState(() {
                _calendarFormat = format;
              });
            }
          },
          focusedDay: _focusedDay,
          selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
          onDaySelected: _onDaySelected,
          calendarStyle: const CalendarStyle(
            selectedDecoration: BoxDecoration(
              color: Color.fromRGBO(76, 89, 153, 1),
              shape: BoxShape.circle,
            ),
          ),
        ),
        const Divider(
          color: Color.fromRGBO(76, 89, 153, 0.5),
          thickness: 0.25,
        ),
        Expanded(
          child: BlocBuilder<ReminderBloc, ReminderState>(
            builder: (context, state) {
              if (state is ReminderLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is ReminderLoaded) {
                return ListView.separated(
                  separatorBuilder: (context, index) {
                    return const Divider(
                      height: 0,
                      color: Color.fromRGBO(76, 89, 153, 0.5),
                      thickness: 0.25,
                    );
                  },
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: state.reminders?.length ?? 0,
                  itemBuilder: (context, index) {
                    if (state.reminders?[index].date ==
                        DateFormat('dd-MM-yyyy')
                            .format(_selectedDay ?? DateTime.now())) {
                      return Container(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(16),
                              margin: const EdgeInsets.only(right: 8),
                              decoration: BoxDecoration(
                                  color: colorPriority(
                                      state.reminders?[index].priority),
                                  shape: BoxShape.circle),
                              child: const Icon(
                                FontAwesomeIcons.pencil,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    state.reminders?[index].title ?? '',
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Text(
                                      '${formatDateString(state.reminders?[index].date ?? '')} | ${state.reminders?[index].time}')
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                showDeleteDialog(context, 1,
                                    selectedDay: _selectedDay);
                              },
                              child: Container(
                                margin: const EdgeInsets.only(left: 4),
                                width: 30,
                                height: 30,
                                child: const Icon(
                                  FontAwesomeIcons.xmark,
                                  size: 20,
                                  color: Colors.grey,
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    } else {
                      return Container();
                    }
                  },
                );
              }
              return Container();
            },
          ),
        ),
      ],
    );
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    BlocProvider.of<ReminderBloc>(context).add(LoadRemindersByDate(
        date: DateFormat('dd-MM-yyyy').format(selectedDay)));
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
      });
    }
  }
}
