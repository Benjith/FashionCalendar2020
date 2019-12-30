import 'package:calendar2020/services.dart';
import 'package:flutter/material.dart';

class AddNote extends StatelessWidget {
  AddNote(this._date);
  final DateTime _date;
  TextEditingController _title = TextEditingController();
  TextEditingController _content = TextEditingController();
  void _save(context) async {
    if(_title.text.isNotEmpty){
    await Services().addNote(_title.text,_content.text,_date);
    Navigator.pop(context);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Note'),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          TextField(
            controller: _title,
            decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 10),
                labelText: 'Title'),
          ),
          Flexible(
            child: TextField(
              controller: _content,
              keyboardType: TextInputType.multiline,
              minLines: 5,
              maxLines: null,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  labelText: 'Content'),
            ),
          ),
          FlatButton(
            onPressed:()=> _save(context),
            child: Text("Save"),
          )
        ],
      ),
    );
  }
}
