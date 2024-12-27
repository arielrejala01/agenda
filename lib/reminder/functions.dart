import 'package:agenda/reminder/bloc/reminder_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

String formatDateString(String dateString) {
  DateFormat inputFormat = DateFormat('dd-MM-yyyy');
  DateTime parsedDate = inputFormat.parse(dateString);
  DateFormat outputFormat = DateFormat('d MMM', 'es');
  return outputFormat.format(parsedDate).toLowerCase();
}

Color colorPriority(int? priority) {
  if (priority == 1) {
    return const Color.fromRGBO(240, 128, 128, 1);
  } else if (priority == 2) {
    return const Color.fromRGBO(255, 218, 150, 1);
  } else if (priority == 3) {
    return const Color.fromRGBO(128, 230, 128, 1);
  }
  return const Color.fromRGBO(76, 89, 153, 0.5);
}

void showDeleteDialog(BuildContext context, int? id, {DateTime? selectedDay}) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          elevation: 0,
          actionsPadding: const EdgeInsets.only(right: 8, bottom: 8),
          contentPadding:
              const EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 4),
          content: const Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '¿Desea eliminar este recordatorio?',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
            ],
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'Cancelar',
                  style: TextStyle(color: Color.fromRGBO(76, 89, 153, 1)),
                )),
            TextButton(
                onPressed: () {
                  BlocProvider.of<ReminderBloc>(context).add(DeleteReminder(
                      id: id,
                      date: DateFormat('dd-MM-yyyy')
                          .format(selectedDay ?? DateTime.now())));
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'ACEPTAR',
                  style: TextStyle(color: Color.fromRGBO(76, 89, 153, 1)),
                ))
          ],
        );
      });
}
