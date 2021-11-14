import 'package:flutter/material.dart';
import 'package:todo_list/source/model/notification/notification.dart';
import 'package:todo_list/source/model/notification/notification_handle.dart';

class NotificationWidget extends StatelessWidget {
  NotificationWidget({Key? key, required this.item, required this.reload})
      : super(key: key);
  final MyNotification? item;
  Function reload;
  // final reload;
  late NotificationHandle handler = NotificationHandle();
  @override
  Widget build(BuildContext context) {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(item!.date);

    delete() {
      handler.deleteItem(item!.id).whenComplete(
          () => {_showMyDialog1('Deleted', item!.title, context), reload()});
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
                    Container(
                      child: Text(
                        item!.title,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                      margin: EdgeInsets.fromLTRB(0, 5, 10, 5),
                    ),
                    Container(
                      child: Text(
                        item!.descript,
                        style: TextStyle(
                          fontSize: 15,
                        ),
                        maxLines: 10,
                        softWrap: false,
                      ),
                      margin: const EdgeInsets.fromLTRB(0, 0, 10, 5),
                    ),
                    Container(
                      child: Text(
                        date.toLocal().toString().substring(0, 10) +
                            "     " +
                            date.toLocal().toString().substring(11, 16),
                        style: TextStyle(fontSize: 12),
                      ),
                      margin: const EdgeInsets.fromLTRB(0, 0, 10, 5),
                    ),
                  ],
                  crossAxisAlignment: CrossAxisAlignment.start,
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.delete,
                  color: Color(0xFFeb4d4b),
                ),
                onPressed: () {
                  _showMyDialog(
                      "Delete item",
                      "Data can't be recovery. Do you want to continue?",
                      context,
                      delete);
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
