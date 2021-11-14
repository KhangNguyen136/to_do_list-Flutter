import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:todo_list/source/model/item/item_handle.dart';
import 'package:todo_list/source/model/item/item.dart';

class AddItemScreen extends StatefulWidget {
  const AddItemScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AddItemScreenState();
  }
}

class ScreenArg {
  bool isEdit;
  Item? item;
  Function reload;
  ScreenArg(this.isEdit, this.item, this.reload);
}

class AddItemScreenState extends State<AddItemScreen> {
  final titleController = TextEditingController();
  bool warning = false;
  final descriptController = TextEditingController();
  DateTime date = new DateTime.now();
  late ItemHandler handler;
  bool isEdit = false;
  Function reload = () {};
  Item item = Item(-1, '', '', 0, 0);

  @override
  void initState() {
    super.initState();
    handler = ItemHandler();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      afterFirstLayout(context);
    });
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // var value = args!.type;
    // afterFirstLayout(context);
    add() {
      var title = titleController.text;
      if (title.isEmpty) {
        setState(() {
          warning = true;
        });
        return;
      }
      var descript = descriptController.text;
      if (!isEdit) {
        item = Item(0, title, descript, date.millisecondsSinceEpoch, 0);
        handler
            .insertItem(item)
            .whenComplete(() => {
                  _showMyDialog('Add item successfully', '', context),
                  setState(() {
                    titleController.text = '';
                    descriptController.text = '';
                    date = DateTime.now();
                  }),
                  reload(),
                })
            .catchError((error) =>
                {_showMyDialog('Action failed', error.toString(), context)});
      } else {
        item.title = title;
        item.description = descript;
        item.date = date.millisecondsSinceEpoch;
        handler
            .updateItem(item)
            .whenComplete(() => {
                  _showMyDialog('Update successfully', '', context),
                  reload(),
                })
            .catchError((error) =>
                _showMyDialog("Action failed", error.toString(), context));
      }
      Navigator.pop(context);
    }

    pickDate() {
      DatePicker.showDateTimePicker(context, showTitleActions: true,
          onChanged: (newDate) {
        setState(() {
          date = newDate;
        });
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? 'Edit record' : 'New record'),
      ),
      body: Center(
          child: Container(
        child: Column(
          children: [
            Text(
              'Title: ',
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
            ),
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                // border: OutlineInputBorder(),
                hintText: 'Enter title',
              ),
              onChanged: (text) {
                if (text.isEmpty) {
                  setState(() {
                    warning = true;
                  });
                } else {
                  setState(() {
                    warning = false;
                  });
                }
              },
            ),
            Visibility(
              child: Container(
                child: const Text("Title can't be empty",
                    style: TextStyle(color: Colors.orange)),
                margin: const EdgeInsets.only(top: 5),
              ),
              visible: warning,
            ),
            Container(
              child: Text(
                'Descript: ',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                textAlign: TextAlign.left,
                maxLines: 10,
              ),
              margin: EdgeInsets.only(top: 10),
            ),
            TextField(
              controller: descriptController,
              decoration: InputDecoration(
                // border: OutlineInputBorder(),
                hintText: 'Enter description',
              ),
            ),
            Container(
              child: Row(
                children: [
                  Text(
                    'Date and time: ',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                    textAlign: TextAlign.left,
                  ),
                  TextButton(
                    onPressed: pickDate,
                    child: Text(date.toString().substring(0, 10) +
                        '     ' +
                        date.toString().substring(11, 16)),
                    // paintBorder
                  ),
                ],
              ),
              margin: EdgeInsets.only(top: 10),
              alignment: Alignment.topLeft,
            ),
            Divider(
              thickness: 2,
            ),
            Row(
              children: [
                FloatingActionButton(
                    onPressed: add, child: Text(isEdit ? 'Save' : 'Add')),
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
          ],
          crossAxisAlignment: CrossAxisAlignment.start,
        ),
        padding: EdgeInsets.all(15),
      )),
    );
  }

  void afterFirstLayout(BuildContext context) {
    // Calling the same function "after layout" to resolve the issue.
    final arg = ModalRoute.of(context)!.settings.arguments as ScreenArg;
    reload = arg.reload;

    if (arg.isEdit) {
      setState(() {
        isEdit = true;
        item = arg.item!;
        titleController.text = arg.item!.title;
        descriptController.text = arg.item!.description;
        date = DateTime.fromMillisecondsSinceEpoch(arg.item!.date);
      });
    }
  }
}

Future<void> _showMyDialog(title, descript, context) async {
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
