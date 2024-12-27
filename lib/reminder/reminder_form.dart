import 'package:agenda/reminder/bloc/reminder_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class ReminderForm extends StatefulWidget {
  const ReminderForm({super.key});

  @override
  State<ReminderForm> createState() => _ReminderFormState();
}

class _ReminderFormState extends State<ReminderForm> {
  final _formKey = GlobalKey<FormState>();
  String? _title;
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  int? _selectedPriority;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromRGBO(76, 89, 153, 1),
      child: SafeArea(
        bottom: false,
        child: Scaffold(
          appBar: AppBar(
              backgroundColor: const Color.fromRGBO(76, 89, 153, 1),
              title: const Text(
                'Agregar un recordatorio',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w700),
              ),
              iconTheme: const IconThemeData(color: Colors.white)),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Título',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingrese un título';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _title = value;
                    },
                  ),
                  const SizedBox(height: 20.0),
                  Container(
                    height: 40,
                    decoration: const BoxDecoration(
                        border: Border(
                            bottom:
                                BorderSide(color: Colors.grey, width: 1.5))),
                    child: Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: _pickDate,
                            child: Text(
                              _selectedDate == null
                                  ? 'Seleccionar Fecha'
                                  : DateFormat('dd-MM-yyyy')
                                      .format(_selectedDate!),
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.normal),
                            ),
                          ),
                        ),
                        const Icon(
                          FontAwesomeIcons.calendar,
                          color: Color.fromRGBO(69, 69, 69, 1),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 24.0),
                  Container(
                    height: 40,
                    decoration: const BoxDecoration(
                        border: Border(
                            bottom:
                                BorderSide(color: Colors.grey, width: 1.5))),
                    child: Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: _pickTime,
                            child: Text(
                              _selectedTime == null
                                  ? 'Seleccionar Hora'
                                  : _selectedTime!.format(context),
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.normal),
                            ),
                          ),
                        ),
                        const Icon(
                          FontAwesomeIcons.clock,
                          color: Color.fromRGBO(69, 69, 69, 1),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  DropdownButtonFormField<int>(
                    decoration: const InputDecoration(
                      labelText: 'Prioridad',
                    ),
                    value: _selectedPriority,
                    dropdownColor: Colors.white,
                    items: const [
                      DropdownMenuItem(
                        value: 1,
                        child: Text('Alta'),
                      ),
                      DropdownMenuItem(value: 2, child: Text('Media')),
                      DropdownMenuItem(value: 3, child: Text('Baja')),
                    ],
                    onChanged: (value) {
                      setState(() {
                        _selectedPriority = value;
                      });
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'Por favor seleccione una prioridad';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                BlocProvider.of<ReminderBloc>(context).add(AddReminder(
                    title: _title,
                    date: DateFormat('dd-MM-yyyy').format(_selectedDate!),
                    time: _selectedTime!.format(context),
                    priority: _selectedPriority ?? 2));
                Navigator.of(context).pop();
              }
            },
            backgroundColor: const Color.fromRGBO(76, 89, 153, 1),
            child: const Icon(
              FontAwesomeIcons.floppyDisk,
              size: 26,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _pickDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      locale: const Locale("es", "ES"),
      builder: (BuildContext context, Widget? widget) => Theme(
        data: ThemeData(
          colorScheme: const ColorScheme.light(
            primary: Color.fromRGBO(76, 89, 153, 1),
          ),
          datePickerTheme: const DatePickerThemeData(
            backgroundColor: Colors.white,
            dividerColor: Color.fromRGBO(76, 89, 153, 1),
            headerBackgroundColor: Color.fromRGBO(76, 89, 153, 1),
            headerForegroundColor: Colors.white,
          ),
        ),
        child: widget!,
      ),
    );
    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  Future<void> _pickTime() async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      cancelText: 'Cancelar',
      confirmText: 'ACEPTAR',
      initialTime: TimeOfDay.now(),
      helpText: 'Selecciona una hora',
      builder: (BuildContext context, Widget? widget) {
        return Localizations.override(
          context: context,
          locale: const Locale('en', 'US'),
          child: Theme(
            data: ThemeData(
              colorScheme: const ColorScheme.light(
                primary: Color.fromRGBO(76, 89, 153, 1),
              ),
              timePickerTheme: const TimePickerThemeData(
                  backgroundColor: Colors.white,
                  dayPeriodColor: Color.fromRGBO(76, 89, 153, 1),
                  helpTextStyle: TextStyle(fontSize: 16)),
            ),
            child: widget!,
          ),
        );
      },
    );

    if (pickedTime != null) {
      setState(() {
        _selectedTime = pickedTime;
      });
    }
  }
}
