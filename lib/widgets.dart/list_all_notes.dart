import 'package:calender2020/services.dart';
import 'package:calender2020/widgets.dart/AddNote.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ListAllNotes extends StatefulWidget {
  ListAllNotes(this._date) {}
  final DateTime _date;
  @override
  _ListAllNotesState createState() => _ListAllNotesState(_date);
}

class _ListAllNotesState extends State<ListAllNotes> {
  _ListAllNotesState(this._date) {
    //fetch all notes
    fetChAllNotes();
  }
  final DateTime _date;
  List result = [];
  bool isLoading = false;
  Future fetChAllNotes() async {
    if (mounted) {
      setState(() {
        isLoading = true;
      });
    }
    result = [];
    List x = await Services().fetchNotesByDate(_date);

    if (x.isNotEmpty) {
      result = x;
    }
    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 10,
        ),
        ListTile(
          title: Text(
            '${_date.day} ${DateFormat("EEEE").format(_date)}',
            style: TextStyle(fontSize: 26, color: Colors.black54),
          ),
          trailing: IconButton(
            tooltip: 'Create new note',
            onPressed: () async {
              await Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddNote(_date)));
              await fetChAllNotes();
            },
            icon: Icon(
              Icons.add,
              color: Colors.black,
            ),
          ),
        ),
        isLoading == true
            ? CircularProgressIndicator()
            : result.isNotEmpty
                ? Expanded(
                    child: ListView.builder(
                      itemCount: result.length,
                      itemBuilder: (BuildContext context, item) {
                        return ListTile(
                          leading: Text((item + 1).toString(),
                              style: TextStyle(color: Colors.black)),
                          isThreeLine: true,
                          subtitle: Text(
                            result[item]['Content'],
                            style: TextStyle(color: Colors.black54),
                          ),
                          title: Text(
                            result[item]['Title'],
                            style: TextStyle(color: Colors.black),
                          ),
                          trailing: IconButton(
                            onPressed: () async {
                              await Services().deleteByid(result[item]['Id']);
                              await fetChAllNotes();
                            },
                            tooltip: 'Delete note',
                            icon: Icon(
                              Icons.delete,
                              color: Colors.red[400],
                            ),
                          ),
                        );
                      },
                    ),
                  )
                : Container()
      ],
    );
  }
}
