import 'package:agenda/calendar/calendar.dart';
import 'package:agenda/profile/profile.dart';
import 'package:agenda/reminder/reminders.dart';
import 'package:flutter/material.dart';

class Pages extends StatefulWidget {
  final int index;
  const Pages({super.key, required this.index});

  @override
  State<Pages> createState() => _PagesState();
}

class _PagesState extends State<Pages> {
  List<Widget> pages = [const Calendar(), const Reminders(), const Profile()];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: pages[widget.index],
    );
  }
}
