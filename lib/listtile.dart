// import 'package:covid19app/scrollevent.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'graphvis.dart';
// import 'package:flag/flag.dart';

// class ListTiile extends StatelessWidget {
//   const ListTiile({
//     Key key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     bool isscrolling = Provider.of<Scrollevent>(context).getscrooling;
//     // bool isEnabled = Provider.of<Scrollevent>(context).getdirection;
//     return Padding(
//       padding: const EdgeInsets.fromLTRB(0, 20, 10, 20),
//       child: TweenAnimationBuilder(
//         duration: const Duration(milliseconds: 500),
//         tween:
//             Tween(begin: isscrolling ? 0.0 : 0.1, end: isscrolling ? 0.1 : 0.0),
//         builder: (BuildContext context, dynamic value, Widget child) {
//           return Transform(
//             alignment: Alignment.center,
//             transform: Matrix4.identity()
//               ..setEntry(3, 2, 0.01)
//               ..rotateY(value),
//             child: Container(
//               height: 300,
//               width: 200,
//               decoration: BoxDecoration(color: Colors.amber),
//               child: Transform(
//                 alignment: Alignment.center,
//                 transform: Matrix4.identity()
//                   ..setEntry(3, 2, 0.01)
//                   ..rotateY(-value),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: <Widget>[
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: <Widget>[
//                         Flag('AD', height: 50, width: 50),
//                         Text('Name')
//                       ],
//                     ),
//                     AnimatedContainer(
//                       curve: !isEnabled ? Curves.easeIn : Curves.easeOut,
//                       duration: Duration(milliseconds: 300),
//                       height: isEnabled ? 180 : 0,
//                       width: 150,
//                       child: GraphVisual(),
//                     ),
//                   ],
//                 ),
//                 // child: Flag('AD', height: 30, width: null),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
