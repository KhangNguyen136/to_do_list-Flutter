import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:todo_list/source/model/item/item.dart';

class ItemHandler {
  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'item.db'),
      onCreate: (database, version) async {
        await database.execute(
          "CREATE TABLE if not exists itemTable(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT NOT NULL,description text,date INTEGER NOT NULL, done integer NOT NULL)",
        );
      },
      version: 1,
    );
  }

  Future<int> insertItem(Item item) async {
    int result = 0;
    final Database db = await initializeDB();

    result = await db.insert('itemTable', item.toMap());

    return result;
  }

  Future<List<Item>> retrieveItems(String type, String searchKey) async {
    final Database db = await initializeDB();
    final List<Map<String, Object?>> queryResult = await db.query('itemTable');
    var list = queryResult.map((e) => Item.fromMap(e)).toList();
    List<Item> result = [];
    switch (type) {
      case 'Today':
        for (var id = 0; id < list.length; id++) {
          Item item = list[id];
          DateTime date = DateTime.fromMillisecondsSinceEpoch(item.date);
          if (isToday(date) && checkSearchKey(searchKey, item)) {
            insertIntoArray(result, item);
          }
        }
        return result;
      case 'Upcoming':
        for (var id = 0; id < list.length; id++) {
          DateTime date = DateTime.fromMillisecondsSinceEpoch(list[id].date);
          if (isUpcoming(date) && checkSearchKey(searchKey, list[id])) {
            insertIntoArray(result, list[id]);
          }
        }
        return result;
      default:
        for (var id = 0; id < list.length; id++) {
          if (checkSearchKey(searchKey, list[id])) {
            insertIntoArray(result, list[id]);
          }
        }
        return result;
    }
  }

  Future<void> deleteItem(int id) async {
    final db = await initializeDB();
    await db.delete(
      'itemTable',
      where: "id = ?",
      whereArgs: [id],
    );
  }

  Future<void> updateItem(Item item) async {
    // Get a reference to the database.
    final db = await initializeDB();
    // Update the given Dog.
    await db.update(
      'itemTable',
      item.toMap(),
      // Ensure that the Dog has a matching id.
      where: 'id = ?',
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [item.id],
    ).whenComplete(() => {print('updated')});
  }
}

void insertIntoArray(List<Item> arr, Item item) {
  if (arr.isEmpty) {
    arr.add(item);
    return;
  }
  for (var id = 0; id < arr.length; id++) {
    if (arr[id].date > item.date) {
      arr.insert(id, item);
      return;
    }
  }
  arr.add(item);
}

bool checkSearchKey(String searchKey, Item item) {
  if (searchKey == '' || searchKey.isEmpty) return true;
  String key = searchKey.toLowerCase();
  return item.title.toLowerCase().contains(key) ||
      item.description.toLowerCase().contains(key);
}

bool isToday(DateTime date) {
  DateTime today = DateTime.now();
  return date.day == today.day &&
      date.month == today.month &&
      date.year == today.year;
}

bool isUpcoming(DateTime date) {
  DateTime today = DateTime.now();
  if (date.year > today.year) {
    return true;
  } else if (date.year < today.year) {
    return false;
  } else {
    if (date.month > today.month) {
      return true;
    } else if (date.month < today.month) {
      return false;
    } else {
      if (date.day > today.day) {
        return true;
      } else {
        return false;
      }
    }
  }
}
