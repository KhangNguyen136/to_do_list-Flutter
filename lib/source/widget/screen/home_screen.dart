import 'package:flutter/material.dart';
import 'package:todo_list/source/widget/component/touchableOpacity.dart';
import 'package:todo_list/source/widget/screen/add_item_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  toList(context) {
    Navigator.pushNamed(context, '/listItem');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                // ignore: avoid_print
                Navigator.pushNamed(context, '/setting');
              },
            ),
            const Expanded(
                child: Text(
              'Home',
              textAlign: TextAlign.center,
            )),
            IconButton(
              icon: Icon(Icons.notifications),
              onPressed: () {
                // ignore: avoid_print
                Navigator.pushNamed(context, '/notifications');
              },
            ),
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        ),
      ),
      backgroundColor: Colors.grey.shade300,
      body: Center(
          child: Card(
        child: Column(children: [
          Expanded(
              child: Column(
            children: [
              MenuButton(title: 'All'),
              Divider(
                thickness: 1,
                endIndent: 1,
              ),
              MenuButton(title: 'Today'),
              Divider(thickness: 1),
              MenuButton(title: 'Upcoming'),
            ],
          )),
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
        ]),
      )),
    );
  }
}

class MenuButton extends StatelessWidget {
  const MenuButton({Key? key, this.title = ''}) : super(key: key);
  final String title;
  // final routeName;
  @override
  Widget build(BuildContext context) {
    MyIcon() {
      switch (title) {
        case 'Today':
          return const Icon(
            Icons.today,
            color: Color(0xFF6ab04c),
          );
        case 'All':
          return const Icon(
            Icons.all_inbox,
            color: Color(0xFF686de0),
          );

        default:
          return const Icon(
            Icons.calendar_today,
            color: Color(0xFFff7979),
          );
      }
    }

    return TouchableOpacity(
        child: Container(
          child: Row(
            children: [
              Container(
                child: MyIcon(),
                margin: EdgeInsets.only(right: 10),
              ),
              Expanded(
                child: Text(title),
                // margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                // color: Colors.red,
              ),
              const Icon(
                Icons.chevron_right,
                size: 24,
              )
            ],
            crossAxisAlignment: CrossAxisAlignment.center,
          ),
          padding: const EdgeInsets.all(10),
        ),
        onTap: () {
          Navigator.pushNamed(context, '/listItem', arguments: title);
        });
  }
}
