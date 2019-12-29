import 'package:flutter/material.dart';

import '../appdata.dart';
import 'AddNote.dart';
import 'day_builder.dart';
import 'day_name_builder.dart';
import 'list_all_notes.dart';

class CalenderView extends StatefulWidget {
  CalenderView(this.dates);
  final List dates;
  @override
  _CalenderViewState createState() => _CalenderViewState();
}

class _CalenderViewState extends State<CalenderView> {
 ViewState _viewMode = ViewState.blank;

  DateTime selectedDate;

 Widget buildRows({int start, int end}) {
    return Row(
      children: <Widget>[
        for (DateTime day in widget.dates.sublist(start, end))
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