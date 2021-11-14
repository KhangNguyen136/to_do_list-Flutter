import 'package:flutter/material.dart';
import 'package:todo_list/source/model/db_handle.dart';
import 'package:todo_list/source/model/item.dart';
import 'package:todo_list/source/widget/screen/add_item_screen.dart';

class ToDoItem extends StatelessWidget {
  ToDoItem({Key? key, required this.item}) : super(key: key);
  final Item? item;
  // final reload;
  late DatabaseHandler handler = DatabaseHandler();
  @override
  Widget build(BuildContext context) {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(item!.date);

    edit() {
      Navigator.pushNamed(context, '/addItem',
          arguments: ScreenArg(true, item));
    }

    delete() {
      handler
          .deleteItem(item!.id)
          .whenComplete(() => _showMyDialog1('Deleted', item!.title, context));
    }

    done() {
      item!.done = (item!.done - 1).abs();
      handler.updateItem(item!);
    }

    // TODO: implement build
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          child: Icon(
                            Icons.bookmark,
                            size: 18,
                          ),
                          margin: EdgeInsets.fromLTRB(0, 5, 10, 5),
                        ),
                        Text(
                          item!.title,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        )
                      ],
                      crossAxisAlignment: CrossAxisAlignment.center,
                    ),
                    Row(
                      children: [
                        Container(
                          child: const Icon(
                            Icons.subject,
                            size: 16,
                          ),
                          margin: const EdgeInsets.fromLTRB(0, 0, 10, 5),
                        ),
                        Text(
                          "Description: " + item!.description,
                          style: TextStyle(
                            fontSize: 14,
                          ),
                          maxLines: 10,
                          softWrap: false,
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          child: const Icon(
                            Icons.calendar_today,
                            size: 16,
                          ),
                          margin: const EdgeInsets.fromLTRB(0, 0, 10, 5),
                        ),
                        Text(
                          date.toLocal().toString().substring(0, 10),
                          style: TextStyle(fontSize: 14),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          child: const Icon(
                            Icons.timer,
                            size: 16,
                          ),
                          margin: const EdgeInsets.fromLTRB(0, 0, 10, 5),
                        ),
                        Text(
                          date.toString().substring(11, 16),
                          style: TextStyle(fontSize: 14),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: edit,
              ),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  _showMyDialog(
                      "Delete item",
                      "Data can't be recovery. Do you want to continue?",
                      context,
                      delete);
                },
              ),
              Checkbox(
                value: item!.done == 1,
                onChanged: (bool? value) {
                  String tempTitle = value! ? 'Done action' : 'Undone action';
                  String tempDescript = value
                      ? 'Have you done this action?'
                      : "You have't done this action?";

                  _showMyDialog(tempTitle, tempDescript, context, done);
                },
              ),
            ],
          ),
          Divider(
            thickness: 1,
          )
        ],
      ),
      margin: EdgeInsets.fromLTRB(20, 0, 10, 0),
    );
  }
}

Future<void> _showMyDialog(title, descript, context, ok) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: true, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(descript),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text(
              'No',
              style: TextStyle(color: Colors.redAccent),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text(
              'Yes',
              style: TextStyle(color: Colors.blueAccent),
            ),
            onPressed: () {
              ok();
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

Future<void> _showMyDialog1(title, descript, context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: true, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(descript),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
