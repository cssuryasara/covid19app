import 'package:covid19app/provider/scrolleventProvider.dart';
import 'package:covid19app/widgets/columncard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/symptomdata.dart';

class Hpsymptom extends StatefulWidget {
  Hpsymptom({Key key}) : super(key: key);

  @override
  _HpsymptomState createState() => _HpsymptomState();
}

class _HpsymptomState extends State<Hpsymptom> {
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        var scrolllistener = Provider.of<Scrollevent>(context);
        bool isscrolling = Provider.of<Scrollevent>(context).getscrooling;
        return NotificationListener<ScrollNotification>(
          onNotification: (n) {
            // print(n);

            if (n is ScrollStartNotification) {
              scrolllistener.setscrolling = true;
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
                  // selected = index == select;
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(0, 14, 10, 20),
                    child: TweenAnimationBuilder(
                      duration: const Duration(milliseconds: 300),
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
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: <Color>[
                                    Color(0xffFFC837),
                                    Color(0xffED8F03),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(10)),
                            child: Transform(
                                alignment: Alignment.center,
                                transform: Matrix4.identity()
                                  ..setEntry(3, 2, 0.01)
                                  ..rotateY(-value),
                                child:
                                    Center(child: buildColumn(firstData[index]))
                                // child: Flag('AD', height: 30, width: null),
                                ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
