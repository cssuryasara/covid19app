import 'package:flag/flag.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:random_color/random_color.dart';

import 'graphvis.dart';
import 'scrollevent.dart';

// class CountryTile extends StatefulWidget {
//   @override
//   _CountryTileState createState() => _CountryTileState();
// }

// class _CountryTileState extends State<CountryTile> {
//   @override
//   Widget build(BuildContext context) {
//     int _value1;
//     List<bool> array = [];
//     falseArray1(int len, int val) {
//       for (int i = 0; i < len; i++) {
//         if (val != i) {
//           setState(() {
//             array[i] = false;
//           });
//         } else {
//           setState(() {
//             array[val] = true;
//           });
//         }
//       }
//     }

//     int count = 1;
//     falseArray(int len) {
//       if (count == 1) {
//         for (int i = 0; i < len; i++) {
//           array.add(false);
//         }
//         count++;
//       }
//     }

//     return Builder(builder: (context) {
//       var scrolllistener = Provider.of<Scrollevent>(context);
//       bool isscrolling = Provider.of<Scrollevent>(context).getscrooling;
//       return NotificationListener<ScrollNotification>(
//         onNotification: (n) {
//           // print(n);

//           if (n is ScrollStartNotification) {
//             scrolllistener.setscrolling = true;
//             // } else if (n is UserScrollNotification) {
//             //   if (n.direction == ScrollDirection.forward) {
//             //     scrolllistener.setdirection = true;
//             //   } else if (n.direction == ScrollDirection.reverse) {
//             //     scrolllistener.setdirection = false;
//             //   }
//           } else if (n is ScrollEndNotification) {
//             scrolllistener.setscrolling = false;
//           }
//           return true;
//         },
//         child: SizedBox(
//           height: 325,
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: ListView.builder(
//               scrollDirection: Axis.horizontal,
//               itemCount: 3,
//               itemBuilder: (BuildContext context, int index) {
//                 falseArray(3);
// Color _color = RandomColor().randomColor(
//     colorHue: ColorHue.pink,
//     colorBrightness: ColorBrightness.veryLight,
//     colorSaturation: ColorSaturation.mediumSaturation);

//                 return InkWell(
//                   onTap: () {
//                     setState(
//                       () {
//                         // isenabled = !isenabled;
//                         _value1 = _value1 != index ? index : null;
//                         print(_value1);
//                         falseArray1(3, _value1);
//                       },
//                     );
//                   },
//                   child: Padding(
//                     padding: const EdgeInsets.fromLTRB(0, 14, 10, 20),
//                     child: TweenAnimationBuilder(
//                       duration: const Duration(milliseconds: 500),
//                       tween: Tween(
//                           begin: isscrolling ? 0.0 : 0.1,
//                           end: isscrolling ? 0.1 : 0.0),
//                       builder:
//                           (BuildContext context, dynamic value, Widget child) {
//                         return Transform(
//                           alignment: Alignment.center,
//                           transform: Matrix4.identity()
//                             ..setEntry(3, 2, 0.01)
//                             ..rotateY(value),
//                           child: Container(
//                             height: 300,
//                             width: 200,
//                             decoration: BoxDecoration(
//                                 color: _color,
//                                 borderRadius: BorderRadius.circular(10)),
//                             child: Transform(
//                               alignment: Alignment.center,
//                               transform: Matrix4.identity()
//                                 ..setEntry(3, 2, 0.01)
//                                 ..rotateY(-value),
//                               child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: <Widget>[
//                                   Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceEvenly,
//                                     children: <Widget>[
//                                       Flag('AD', height: 50, width: 50),
//                                       Text(
//                                         'Name',
//                                         style: TextStyle(
//                                           color: Colors.white,
//                                         ),
//                                       )
//                                     ],
//                                   ),
//                                   AnimatedContainer(
//                                     curve: Curves.easeOut,
//                                     duration: Duration(milliseconds: 300),
//                                     height: array[index] ? 180 : 0,
//                                     width: 150,
//                                     child: GraphVisual(),
//                                   ),
//                                 ],
//                               ),
//                               // child: Flag('AD', height: 30, width: null),
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ),
//       );
//     });
//   }
// }

class CountryTile extends StatefulWidget {
  @override
  _CountryTileState createState() => _CountryTileState();
}

class _CountryTileState extends State<CountryTile> {
  int _value1;
  List<bool> array = [];
  falseArray1(int len, int val) {
    for (int i = 0; i < len; i++) {
      if (val != i) {
        setState(() {
          array[i] = false;
        });
      } else {
        setState(() {
          array[val] = true;
        });
      }
    }
  }

  int count = 1;
  falseArray(int len) {
    if (count == 1) {
      for (int i = 0; i < len; i++) {
        array.add(false);
      }
      count++;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      var scrolllistener = Provider.of<Scrollevent>(context);
      bool isscrolling = Provider.of<Scrollevent>(context).getscrooling;
      return NotificationListener<ScrollNotification>(
        onNotification: (n) {
          // print(n);

          if (n is ScrollStartNotification) {
            scrolllistener.setscrolling = true;
            // } else if (n is UserScrollNotification) {
            //   if (n.direction == ScrollDirection.forward) {
            //     scrolllistener.setdirection = true;
            //   } else if (n.direction == ScrollDirection.reverse) {
            //     scrolllistener.setdirection = false;
            //   }
          } else if (n is ScrollEndNotification) {
            scrolllistener.setscrolling = false;
          }
          return true;
        },
        child: SizedBox(
          height: 325,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: BouncingScrollPhysics(),
              itemCount: 3,
              itemBuilder: (BuildContext context, int index) {
                falseArray(3);
                Color _color = RandomColor().randomColor(
                    colorHue: ColorHue.multiple(colorHues: [ColorHue.green,ColorHue.blue]),
                    colorBrightness: ColorBrightness.veryLight,
                    colorSaturation: ColorSaturation.mediumSaturation);

                return InkWell(
                  onTap: () {
                    setState(
                      () {
                        // isenabled = !isenabled;
                        _value1 = _value1 != index ? index : null;
                        // print(widget._value1);
                        falseArray1(3, _value1);
                      },
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 14, 10, 20),
                    child: TweenAnimationBuilder(
                      duration: const Duration(milliseconds: 500),
                      tween: Tween(
                          begin: isscrolling ? 0.0 : 0.1,
                          end: isscrolling ? 0.1 : 0.0),
                      builder:
                          (BuildContext context, dynamic value, Widget child) {
                        return Transform(
                          alignment: Alignment.center,
                          transform: Matrix4.identity()
                            ..setEntry(3, 2, 0.01)
                            ..rotateY(value),
                          child: Container(
                            height: 300,
                            width: 200,
                            decoration: BoxDecoration(
                                color: _color,
                                borderRadius: BorderRadius.circular(10)),
                            child: Transform(
                              alignment: Alignment.center,
                              transform: Matrix4.identity()
                                ..setEntry(3, 2, 0.01)
                                ..rotateY(-value),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Flag('AD', height: 50, width: 50),
                                      Text('Name')
                                    ],
                                  ),
                                  AnimatedContainer(
                                    curve: Curves.easeOut,
                                    duration: Duration(milliseconds: 300),
                                    height: array[index] ? 180 : 0,
                                    width: 150,
                                    child: GraphVisual(),
                                  ),
                                ],
                              ),
                              // child: Flag('AD', height: 30, width: null),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      );
    });
  }
}
