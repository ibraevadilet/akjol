// import 'package:flutter/material.dart';

// class Button extends StatelessWidget {
//   VoidCallback onTap;
//   Button({Key? key, required this.onTap}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 16),
//       width: double.maxFinite,
//       decoration:
//           BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(16))),
//       child: AnimatedContainer(
//         margin: EdgeInsets.only(
//           bottom: MediaQuery.of(context).viewInsets.bottom,
//         ),
//         height: 60,
//         width: isKeyboar ? 60 : 400,
//         duration: Duration(milliseconds: 800),
//         child: ElevatedButton(
//           style: ElevatedButton.styleFrom(
//               primary: Colors.blue,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(
//                   isKeyboar ? 190 : 30,
//                 ),
//               )),
//           onPressed: onTap,
//           child: isKeyboar
//               ? Container(
//                   child: Icon(
//                     Icons.arrow_forward,
//                   ),
//                 )
//               : Container(
//                   child: Text(
//                     "Войти",
//                     style: TextStyle(fontSize: 18),
//                   ),
//                 ),
//         ),
//       ),
//     );
//   }
// }
