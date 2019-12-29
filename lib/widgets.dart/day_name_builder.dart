import 'package:flutter/material.dart';

class DayNameBuilder extends StatelessWidget {
   Widget _daysNameCreate({String name}) {
    return Expanded(
      child: Center(child: Text(name,style: TextStyle(color: name=='SUN'?Colors.red:Colors.white),),),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        _daysNameCreate(name: 'SUN'),
        _daysNameCreate(name: 'MON'),
        _daysNameCreate(name: 'TUE'),
        _daysNameCreate(name: 'WED'),
        _daysNameCreate(name: 'THU'),
        _daysNameCreate(name: 'FRI'),
        _daysNameCreate(name: 'SAT'),
      ],
    );
  }
}