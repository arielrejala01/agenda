import 'package:agenda/reminder/bloc/reminder_bloc.dart';
import 'package:agenda/reminder/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Reminders extends StatefulWidget {
  const Reminders({super.key});

  @override
  State<Reminders> createState() => _RemindersState();
}

class _RemindersState extends State<Reminders> {
  @override
  void initState() {
    BlocProvider.of<ReminderBloc>(context).add(LoadReminders());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
                              showDeleteDialog(
                                  context, state.reminders?[index].id);
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
                  },
                );
              }
              return Container();
            },
          ),
        )
      ],
    );
  }
}
