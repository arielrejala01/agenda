import 'package:agenda/reminder/reminder_form.dart';
import 'package:flutter/material.dart';

final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  '/add_reminder': (BuildContext context) => const ReminderForm(),
};
