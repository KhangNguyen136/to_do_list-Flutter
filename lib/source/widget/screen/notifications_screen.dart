import 'package:flutter/material.dart';
import 'package:todo_list/source/model/notification/notification.dart';
import 'package:todo_list/source/model/notification/notification_handle.dart';
import 'package:todo_list/source/widget/component/notification_item.dart';
import 'package:todo_list/source/widget/component/to_do_item.dart';
import 'package:todo_list/source/widget/screen/add_item_screen.dart';

class NotificationsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return NotificationState();
  }
}

class NotificationState extends State<NotificationsScreen> {
  late NotificationHandle dbHandler;
  final searchController = TextEditingController();
  String searchKey = '';
  bool searching = false;
  bool change = false;
  @override
  void initState() {
    super.initState();
    dbHandler = NotificationHandle();
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Row(
          children: [
            Expanded(
                child: Text(
              'Notifications',
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
          future: dbHandler.retrieveNotifications(searching ? searchKey : ''),
          // .whenComplete(() => print('Get notifications successfully'))
          // .catchError((error) => print(error.toString())),
          builder: (BuildContext context,
              AsyncSnapshot<List<MyNotification>> snapshot) {
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
                          return NotificationWidget(
                            item: data?[index],
                            reload: rebuild,
                          );
                        }),
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
