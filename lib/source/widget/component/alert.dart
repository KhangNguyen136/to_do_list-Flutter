// import 'package:flutter/material.dart';


// Future<void> _showMyDialog(title, descript, context) async {
//   return showDialog<void>(
//     context: context,
//     barrierDismissible: true, // user must tap button!
//     builder: (BuildContext context) {
//       return AlertDialog(
//         title: Text(title),
//         content: SingleChildScrollView(
//           child: ListBody(
//             children: <Widget>[
//               Text(descript),
//             ],
//           ),
//         ),
//         actions: <Widget>[
//           TextButton(
//             child: const Text('OK'),
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//           ),
//         ],
//       );
//     },
//   );
// }