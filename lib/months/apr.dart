import 'package:flutter/material.dart';

class Apr extends StatefulWidget {
  Apr({Key key}) : super(key: key);

  @override
  _AprState createState() => _AprState();
}

class _AprState extends State<Apr> {
  @override
  Widget build(BuildContext context) {
    return Container(
       child: Text(widget.key.toString()),
    );
  }
}