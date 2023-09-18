import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class MyCalendar extends StatefulWidget {
  const MyCalendar({
    super.key,
  });

  @override
  State<MyCalendar> createState() => _MyCalendarState();
}

class _MyCalendarState extends State<MyCalendar> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      calendarFormat: _calendarFormat,
      focusedDay: _focusedDay,
      firstDay: DateTime.utc(2023, 01, 01),
      lastDay: DateTime.utc(2024, 12, 31),
      onDaySelected: (day, calendarFormat) {
        setState(() {
          _focusedDay = day;
          // _calendarFormat = CalendarFormat.fromDateTime(day);
        });
      },
    );
  }
}
