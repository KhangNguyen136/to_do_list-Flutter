// import 'package:flutter/material.dart';
// import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
// import 'package:todo_list/source/model/db_handle.dart';
// import 'package:todo_list/source/model/item.dart';

// class EditItemScreen extends StatefulWidget {
//   const EditItemScreen({Key? key}) : super(key: key);

//   @override
//   State<StatefulWidget> createState() {
//     // TODO: implement createState
//     return EditItemScreenState();
//   }
// }

// class EditItemScreenState extends State<EditItemScreen> {
//   final titleController = TextEditingController();
//   bool warning = false;
//   final descriptController = TextEditingController();
//   DateTime date = new DateTime.now();
//   late DatabaseHandler handler;

//   @override
//   void initState() {
//     super.initState();
//     handler = DatabaseHandler();
//     handler.initializeDB();
//   }

//   @override
//   void dispose() {
//     titleController.dispose();
//     descriptController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final arg = ModalRoute.of(context)!.settings.arguments as Item;
//     @override
//     void initState() {
//       super.initState();
//     }

//     add() {
//       var title = titleController.text;
//       if (title.isEmpty) {
//         setState(() {
//           warning = true;
//         });
//         return;
//       }
//       var descript = descriptController.text;
//       Item item = Item(0, title, descript, date.millisecondsSinceEpoch, 1);
//       handler
//           .insertItem(item)
//           .whenComplete(() => {
//                 print('Insert successfully.'),
//                 setState(() {
//                   titleController.text = '';
//                   descriptController.text = '';
//                   date = DateTime.now();
//                 })
//               })
//           .catchError((error) => {print(error.toString())});
//     }

//     pickDate() {
//       DatePicker.showDateTimePicker(context, showTitleActions: true,
//           onChanged: (newDate) {
//         setState(() {
//           date = newDate;
//         });
//       });
//     }

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Edit record'),
//       ),
//       body: Center(
//           child: Container(
//         child: Column(
//           children: [
//             Text(
//               'Title: ',
//               style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
//             ),
//             TextField(
//               controller: titleController,
//               decoration: InputDecoration(
//                 // border: OutlineInputBorder(),
//                 hintText: 'Enter title',
//               ),
//               onChanged: (text) {
//                 if (text.isEmpty) {
//                   setState(() {
//                     warning = true;
//                   });
//                 } else {
//                   setState(() {
//                     warning = false;
//                   });
//                 }
//               },
//             ),
//             Visibility(
//               child: Container(
//                 child: const Text("Title can't be empty",
//                     style: TextStyle(color: Colors.orange)),
//                 margin: const EdgeInsets.only(top: 5),
//               ),
//               visible: warning,
//             ),
//             Container(
//               child: Text(
//                 'Descript: ',
//                 style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
//                 textAlign: TextAlign.left,
//               ),
//               margin: EdgeInsets.only(top: 10),
//             ),
//             TextField(
//               controller: descriptController,
//               decoration: InputDecoration(
//                 // border: OutlineInputBorder(),
//                 hintText: 'Enter description',
//               ),
//             ),
//             Container(
//               child: Row(
//                 children: [
//                   Text(
//                     'Date and time: ',
//                     style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
//                     textAlign: TextAlign.left,
//                   ),
//                   TextButton(
//                     onPressed: pickDate,
//                     child: Text(date.toString().substring(0, 16)),
//                     // paintBorder
//                   ),
//                 ],
//               ),
//               margin: EdgeInsets.only(top: 10),
//               alignment: Alignment.topLeft,
//             ),
//             Divider(
//               thickness: 2,
//             ),
//             Row(
//               children: [
//                 FloatingActionButton(onPressed: add, child: Text('Save')),
//               ],
//               mainAxisAlignment: MainAxisAlignment.center,
//             ),
//           ],
//           crossAxisAlignment: CrossAxisAlignment.start,
//         ),
//         padding: EdgeInsets.all(15),
//       )),
//     );
//   }
// }
