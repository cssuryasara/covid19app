import 'package:flutter/material.dart';
// import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';

// import 'pagination.dart';

class SymptomPage extends StatefulWidget {
  @override
  _SymptomPageState createState() => _SymptomPageState();
}

class Symtom {
  String tag;
  String image;
  String name;
  Symtom({this.image, this.tag, this.name});
}

class _SymptomPageState extends State<SymptomPage> {
  final PageController ctrl = PageController(viewportFraction: 0.8);
  int currentPage = 0;
  bool isSelected;
  List<Symtom> s = [
    Symtom(tag: 'a', image: 'assets/light_cough.gif', name: 'Fever'),
    Symtom(tag: 'a', image: 'assets/light_fever.gif', name: 'Dry Cough'),
    Symtom(tag: 'a', image: 'assets/light_tiredness.gif', name: 'Tiredness'),
  ];

  List<Symtom> main = [
    Symtom(tag: 'a', image: 'assets/light_cough.gif', name: 'Fever'),
    Symtom(tag: 'a', image: 'assets/light_fever.gif', name: 'Dry Cough'),
    Symtom(tag: 'a', image: 'assets/light_tiredness.gif', name: 'Tiredness'),
    Symtom(tag: 'b', image: 'assets/light_cough.gif', name: 'aches and pains'),
    Symtom(tag: 'b', image: 'assets/light_cough.gif', name: 'sore throat'),
    Symtom(tag: 'b', image: 'assets/light_cough.gif', name: 'diarrhoea'),
    Symtom(tag: 'b', image: 'assets/light_cough.gif', name: 'conjunctivitis'),
    Symtom(tag: 'b', image: 'assets/light_cough.gif', name: 'headache'),
    Symtom(
        tag: 'b',
        image: 'assets/light_cough.gif',
        name: 'loss of taste or smell'),
    Symtom(
        tag: 'b',
        image: 'assets/light_cough.gif',
        name: 'a rash on skin, or discolouration of fingers or toes'),
    Symtom(
        tag: 'c',
        image: 'assets/light_cough.gif',
        name: 'loss of taste or smell'),
  ];
  String activetag = 'a';
  bool isMiddle = true;
  buildTagPage() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      height: 500,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          buildButton('Most Common Symptoms', 'a'),
          buildButton('Less common symptoms:', 'b'),
          buildButton('c', 'c'),
        ],
      ),
    );
  }

  buildButton(name, tag) {
    Color color = tag == activetag ? Colors.purple : Colors.white;
    return FlatButton(
      color: color,
      onPressed: () {
        setState(() {
          activetag = tag;
          s.clear();
          Iterable<Symtom> d =
              main.where((element) => element.tag.contains(tag));
          d.forEach((element) {
            s.add(element);
          });
        });
      },
      child: Text('$name'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   elevation: 0,
      //   backgroundColor: Colors.white,
      //   title: Row(
      //     mainAxisAlignment: MainAxisAlignment.start,
      //     children: <Widget>[
      //       Icon(Icons.view_carousel, color: Colors.black),
      //       SizedBox(
      //         width: 10,
      //       ),
      //       Column(
      //         crossAxisAlignment: CrossAxisAlignment.start,
      //         children: <Widget>[
      //           Text(
      //             'Covid19',
      //             style: GoogleFonts.getFont('Montserrat',
      //                 fontSize: 16, color: Colors.black),
      //           ),
      //           Text(
      //             'SYMPTOMS',
      //             style: GoogleFonts.getFont('Montserrat',
      //                 fontSize: 20, color: Colors.black),
      //           ),
      //         ],
      //       ),
      //     ],
      //   ),
      //   // centerTitle: true,
      // ),
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            PageView.builder(
              physics: ClampingScrollPhysics(),
              itemCount: s.length + 1,
              controller: ctrl,
              onPageChanged: (int i) {
                print(ctrl);
                int next = ctrl.page.round();
                if (currentPage != next) {
                  setState(() {
                    currentPage = next;
                  });
                }
                if (currentPage == 0) {
                  setState(() {
                    isMiddle = true;
                  });
                } else {
                  setState(() {
                    isMiddle = false;
                  });
                }
              },
              itemBuilder: (context, int index) {
                if (index == 0) {
                  return buildTagPage();
                } else if (s.length >= index) {
                  bool active = index == currentPage;
                  return buildContainer(s[index - 1], active);
                }
                return Text('h');
              },
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  s.length + 1,
                  (int index) {
                    isSelected = currentPage == index;
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          ctrl.animateToPage(
                            index,
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeOutQuint,
                          );
                          setState(() {
                            currentPage = index;
                          });
                        },
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                            color: isSelected ? Colors.amber : Colors.green,
                            borderRadius: BorderRadius.circular(5000),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: AnimatedAlign(
                alignment:
                    !isMiddle ? Alignment.bottomCenter : Alignment.topLeft,
                duration: Duration(milliseconds: 300),
                curve: Curves.decelerate,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Covid19',
                      style: GoogleFonts.getFont('Montserrat',
                          fontSize: 16, color: Colors.black),
                    ),
                    Text(
                      'SYMPTOMS',
                      style: GoogleFonts.getFont('Montserrat',
                          fontSize: 20, color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  AnimatedContainer buildContainer(Symtom a, bool active) {
    final double blur = active ? 30 : 0;
    final double offset = active ? 20 : 0;
    final double top = active ? 75 : 150;
    return AnimatedContainer(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black54,
            blurRadius: blur,
            offset: Offset(offset, offset),
          )
        ],
      ),
      duration: Duration(milliseconds: 500),
      curve: Curves.easeOutQuint,
      margin: EdgeInsets.only(top: top, bottom: 50, right: 20),
      height: 500,
      child: Column(
        children: <Widget>[Image.asset("${a.image}"), Text("${a.name}")],
      ),
    );
  }
}

/*
import 'package:flutter/material.dart';
// import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';

// import 'pagination.dart';

class SymptomPage extends StatefulWidget {
  @override
  _SymptomPageState createState() => _SymptomPageState();
}

class _SymptomPageState extends State<SymptomPage> {
  final PageController ctrl = PageController(viewportFraction: 0.8);
  int currentPage = 0;
  bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Icon(Icons.view_carousel, color: Colors.black),
            SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Covid19',
                  style: GoogleFonts.getFont('Montserrat',
                      fontSize: 16, color: Colors.black),
                ),
                Text(
                  'SYMPTOMS',
                  style: GoogleFonts.getFont('Montserrat',
                      fontSize: 20, color: Colors.black),
                ),
              ],
            ),
          ],
        ),
        // centerTitle: true,
      ),
      body: Stack(
        children: <Widget>[
          PageView.builder(
            physics: ClampingScrollPhysics(),
            itemCount: 4,
            controller: ctrl,
            onPageChanged: (int i) {
              print(ctrl);
              int next = ctrl.page.round();
              if (currentPage != next) {
                setState(() {
                  currentPage = next;
                });
              }
            },
            itemBuilder: (context, int index) {
              bool active = index == currentPage;
              return buildContainer(active);
            },
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                4,
                (int index) {
                  isSelected = currentPage == index;
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        ctrl.animateToPage(
                          index,
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeOutQuint,
                        );
                        setState(() {
                          currentPage = index;
                        });
                      },
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                          color: isSelected ? Colors.amber : Colors.green,
                          borderRadius: BorderRadius.circular(5000),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  AnimatedContainer buildContainer(bool active) {
    final double blur = active ? 30 : 0;
    final double offset = active ? 20 : 0;
    final double top = active ? 75 : 150;
    return AnimatedContainer(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black54,
            blurRadius: blur,
            offset: Offset(offset, offset),
          )
        ],
      ),
      duration: Duration(milliseconds: 500),
      curve: Curves.easeOutQuint,
      margin: EdgeInsets.only(top: top, bottom: 50, right: 20),
      height: 500,
      child: Column(
        children: <Widget>[
          Image.asset('assets/light_cough.gif'),
        ],
      ),
    );
  }
}

*/
