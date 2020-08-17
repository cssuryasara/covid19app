// import 'package:covid19app/provider/scrolleventProvider.dart';
import 'package:covid19app/widgets/columncard.dart';
import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
import '../data/preventiondata.dart';

class HpPrevention extends StatefulWidget {
  HpPrevention({Key key}) : super(key: key);

  @override
  _HpPreventionState createState() => _HpPreventionState();
}

class _HpPreventionState extends State<HpPrevention> {
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        // var scrolllistener = Provider.of<Scrollevent>(context);
        // bool isscrolling = Provider.of<Scrollevent>(context).getscrooling;
        return SizedBox(
          height: 325,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: BouncingScrollPhysics(),
              itemCount: 5,
              itemBuilder: (BuildContext context, int index) {
                // selected = index == select;
                return Padding(
                  padding: const EdgeInsets.fromLTRB(0, 14, 10, 20),
                  child: Container(
                    height: 300,
                    width: 200,
                    decoration: BoxDecoration(
                       gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: <Color>[
                  Color(0xffff0084),
                  Color(0xffAA076B),
                ]),
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(child: buildColumn(firstData[index])),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
