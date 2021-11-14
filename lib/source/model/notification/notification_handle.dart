import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:todo_list/source/model/notification/notification.dart';

class NotificationHandle {
  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'notification.db'),
      onCreate: (database, version) async {
        await database.execute(
          "CREATE TABLE if not exists notificationTable(id INTEGER PRIMARY KEY AUTOINCREMENT, title text NOT NULL, descript text,date INTEGER NOT NULL, viewed integer NOT NULL)",
        );
      },
      version: 1,
    );
  }

  Future<int> insertNotification(MyNotification item) async {
    int result = 0;
    final Database db = await initializeDB();

    result = await db.insert('notificationTable', item.toMap());

    return result;
  }

  Future<List<MyNotification>> retrieveNotifications(String searchKey) async {
    final Database db = await initializeDB();
    // await insertNotification(MyNotification(
    //     0, 'alo', 'descipt', DateTime.now().millisecondsSinceEpoch, 1));

    final List<Map<String, Object?>> queryResult =
        await db.query('notificationTable');
    var list = queryResult.map((e) => MyNotification.fromMap(e)).toList();
    List<MyNotification> result = [];

    for (var id = 0; id < list.length; id++) {
      if (checkSearchKey(searchKey, list[id])) result.add(list[id]);
    }
    return result;
  }

  Future<void> deleteItem(int id) async {
    final db = await initializeDB();
    await db.delete(
      'notificationTable',
      where: "id = ?",
      whereArgs: [id],
    );
  }
}

bool checkSearchKey(String searchKey, MyNotification item) {
  if (searchKey == '' || searchKey.isEmpty) return true;
  String key = searchKey.toLowerCase();
  return item.title.toLowerCase().contains(key) ||
      item.descript.toLowerCase().contains(key);
}
