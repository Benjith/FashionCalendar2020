import 'package:calender2020/appdata.dart';
import 'package:calender2020/db/database_helper.dart';
import 'package:intl/intl.dart';

class Services {
  DatabaseHelper dbHelper = DatabaseHelper();
  Future<void> addNote(String text, String content, DateTime date) async {
    var db = await dbHelper.db;
    var dateFormat = DateFormat('yyyy-MM-dd').format(date);

    return await db.insert('Notes', {
      'Title': '$text',
      'Content': '$content',
      'Date': '${dateFormat.toString()}'
    });
  }

  Future<List> fetchNotesByDate(DateTime date) async {
    var db = await dbHelper.db;
    var dateFormat = DateFormat('yyyy-MM-dd').format(date);

    return await db.rawQuery(
        'SELECT * FROM Notes WHERE Date = "${dateFormat.toString()}"');
  }

  Future<void> deleteByid(int id) async {
    var db = await dbHelper.db;
    return await db.rawQuery('DELETE FROM Notes WHERE Id =$id');
  }

  Future<void> fetchallNotesDate() async {
    print('fetching notes dates');
    var db = await dbHelper.db;
    List result = await db.rawQuery('SELECT * FROM Notes ORDER BY Date ASC');
    if (result.isNotEmpty) {
      for (var i = 0; i < result.length; i++) {
        AppData.noteDates.add(DateTime.parse(result[i]['Date'].toString()));
      }
    }
  }
}
