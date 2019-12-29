import 'package:calender2020/widgets.dart/AddNote.dart';
import 'package:calender2020/widgets.dart/day_builder.dart';
import 'package:calender2020/widgets.dart/day_name_builder.dart';
import 'package:calender2020/widgets.dart/list_all_notes.dart';

import 'package:flutter/material.dart';

import '../appdata.dart';

class Jan extends StatefulWidget {
  Jan({Key key}) : super(key: key);

  @override
  _JanState createState() => _JanState();
}

class _JanState extends State<Jan> {
  ViewState _viewMode = ViewState.blank;
  DateTime selectedDate;

  List<DateTime> _days = [
    DateTime(2019, 12, 30),
    DateTime(2019, 12, 31),
    DateTime(2020, 01, 1),
    DateTime(2020, 01, 2),
    DateTime(2020, 01, 3),
    DateTime(2020, 01, 4),
    DateTime(2020, 01, 5),
    DateTime(2020, 01, 6),
    DateTime(2020, 01, 7),
    DateTime(2020, 01, 8),
    DateTime(2020, 01, 9),
    DateTime(2020, 01, 10),
    DateTime(2020, 01, 11),
    DateTime(2020, 01, 12),
    DateTime(2020, 01, 13),
    DateTime(2020, 01, 14),
    DateTime(2020, 01, 15),
    DateTime(2020, 01, 16),
    DateTime(2020, 01, 17),
    DateTime(2020, 01, 18),
    DateTime(2020, 01, 19),
    DateTime(2020, 01, 20),
    DateTime(2020, 01, 21),
    DateTime(2020, 01, 22),
    DateTime(2020, 01, 23),
    DateTime(2020, 01, 24),
    DateTime(2020, 01, 25),
    DateTime(2020, 01, 26),
    DateTime(2020, 01, 27),
    DateTime(2020, 01, 28),
    DateTime(2020, 01, 29),
    DateTime(2020, 01, 30),
    DateTime(2020, 01, 31),
    DateTime(2020, 02, 1),
    DateTime(2020, 02, 2),
    DateTime(2020, 02, 3),
    DateTime(2020, 02, 4),
    DateTime(2020, 02, 5),
    DateTime(2020, 02, 6),
    DateTime(2020, 02, 7),
    DateTime(2020, 02, 8),
    DateTime(2020, 02, 9),
  ];
  Widget buildRows({int start, int end}) {
    return Row(
      children: <Widget>[
        for (DateTime day in _days.sublist(start, end))
          Expanded(
            child: InkWell(
              onTap: () {
                if (day.isAfter(DateTime.now())) {
                  print('day is okay');
                  selectedDate = day;
                  setState(() {
                    _viewMode = _viewMode == ViewState.showList
                        ? ViewState.blank
                        : ViewState.showList;
                  });
                }
              },
              child: DayBuilder(
                date: day,
                isActive: day.day > DateTime.now().day ? true : false,
                isHoliday: day.weekday == DateTime.sunday ? true : false,
              ),
            ),
          )
      ],
    );
  }

  Widget _getViewState() {
    switch (_viewMode) {
      case ViewState.blank:
         Container();
        break;
      case ViewState.addEntry:
         AddNote(selectedDate);
        break;
      case ViewState.showList:
         ListAllNotes(selectedDate);
        break;
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.red,
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        children: <Widget>[
          DayNameBuilder(),
          //week one
          buildRows(end: 7, start: 0),
          //week two
          buildRows(start: 7, end: 14),
          //week three
          buildRows(start: 14, end: 21),
          //week four
          buildRows(start: 21, end: 28),
          //week five
          buildRows(end: 35, start: 28),
          //week six
          buildRows(start: 35, end: 42),
          if(_viewMode != ViewState.blank)
          Expanded(
            child: Container(
              // height: double.infinity,
              // width: double.infinity,
              decoration: BoxDecoration(
                  color: _viewMode == ViewState.blank
                      ? Colors.transparent
                      : Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  )),
              child: ListAllNotes(selectedDate),
            ),
          )
        ],
      ),
    );
  }
}
