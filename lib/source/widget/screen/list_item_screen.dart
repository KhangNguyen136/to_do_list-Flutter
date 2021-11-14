import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:todo_list/source/model/db_handle.dart';
import 'package:todo_list/source/model/item.dart';
import 'package:todo_list/source/widget/component/to_do_item.dart';
import 'package:todo_list/source/widget/screen/add_item_screen.dart';

class ListItemScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ListItemState();
  }
}

class ListItemState extends State<ListItemScreen> {
  late DatabaseHandler dbHandler;
  // List<Item> listItem = [];
  @override
  void initState() {
    super.initState();
    dbHandler = DatabaseHandler();
  }

  @override
  dispose() {
    super.dispose();
  }

  rebuild() {
    // setState(() {});
    print('Reload');
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
        appBar: AppBar(
          title: Text(args.toString()),
        ),
        body: FutureBuilder(
          future: dbHandler.retrieveItems(args),
          builder: (BuildContext context, AsyncSnapshot<List<Item>> snapshot) {
            if (snapshot.hasData) {
              var data = snapshot.data;
              return Center(
                  child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                        itemCount: data?.length,
                        itemBuilder: (context, int index) {
                          return ToDoItem(
                            item: data?[index],
                          );
                        }),
                  ),
                  Container(
                    alignment: Alignment.bottomRight,
                    child: FloatingActionButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/addItem',
                              arguments: ScreenArg(false, null));
                        },
                        child: Icon(Icons.add)),
                    margin: EdgeInsets.all(15),
                  ),
                ],
              ));
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ));
  }
}
