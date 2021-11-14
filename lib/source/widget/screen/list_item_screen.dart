import 'package:flutter/material.dart';
import 'package:todo_list/source/model/item/item_handle.dart';
import 'package:todo_list/source/model/item/item.dart';
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
  late ItemHandler dbHandler;
  final searchController = TextEditingController();
  String searchKey = '';
  bool searching = false;
  // List<Item> listItem = [];
  bool change = false;
  @override
  void initState() {
    super.initState();
    dbHandler = ItemHandler();
  }

  @override
  dispose() {
    super.dispose();
    searchController.dispose();
  }

  rebuild() {
    // initState();
    setState(() {
      change = !change;
    });
    print('Reload');
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
        appBar: AppBar(
            title: Row(
          children: [
            Expanded(
                child: Text(
              args,
              textAlign: TextAlign.center,
            )),
            IconButton(
              onPressed: () {
                setState(() {
                  searching = !searching;
                });
              },
              icon: Icon(searching ? Icons.search_off : Icons.search),
            )
          ],
        )),
        body: FutureBuilder(
          future: dbHandler.retrieveItems(args, searching ? searchKey : ''),
          builder: (BuildContext context, AsyncSnapshot<List<Item>> snapshot) {
            if (snapshot.hasData) {
              var data = snapshot.data;
              return Center(
                  child: Column(
                children: [
                  Visibility(
                    child: Container(
                      child: TextField(
                        controller: searchController,
                        onChanged: (text) {
                          setState(() {
                            searchKey = text;
                          });
                        },
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Search by title or description',
                            contentPadding: EdgeInsets.fromLTRB(12, 5, 12, 5)),
                      ),
                      margin: EdgeInsets.fromLTRB(10, 5, 10, 10),
                    ),
                    visible: searching,
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: data?.length,
                        itemBuilder: (context, int index) {
                          return ToDoItem(
                            item: data?[index],
                            reload: rebuild,
                          );
                        }),
                  ),
                  Container(
                    alignment: Alignment.bottomRight,
                    child: FloatingActionButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/addItem',
                              arguments: ScreenArg(false, null, rebuild));
                        },
                        child: Icon(Icons.add)),
                    margin: EdgeInsets.fromLTRB(0, 0, 15, 15),
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
