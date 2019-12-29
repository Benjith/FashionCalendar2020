import 'package:calender2020/appdata.dart';
import 'package:flutter/material.dart';

class DayBuilder extends StatelessWidget {
  DayBuilder({this.date, this.isActive, this.isHoliday});
  final DateTime today = DateTime.now();
  final DateTime date;
  final bool isActive;
  final bool isHoliday;

  TextStyle _dayStyle() => TextStyle(
      fontSize: 32,
      fontWeight:
          AppData.noteDates.contains(date) ? FontWeight.bold : FontWeight.w200,
      color: (today.year == date.year && today.month == date.month)
          ? Colors.white
          : Colors.white30);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      // height: 20,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: (today.year == date.year &&
                  today.month == date.month &&
                  today.day == date.day)
              ? Colors.blue
              : Colors.transparent),
      child: Center(
        child: Text(
          date.day.toString(),
          style: _dayStyle(),
        ),
      ),
    );
  }
}
