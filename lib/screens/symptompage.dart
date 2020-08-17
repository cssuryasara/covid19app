
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/gestures.dart';
import 'package:url_launcher/url_launcher.dart';
import '../data/symptomdata.dart';

class SymptomPage extends StatefulWidget {
  @override
  _SymptomPageState createState() => _SymptomPageState();
}

class _SymptomPageState extends State<SymptomPage> {
  final PageController ctrl = PageController(viewportFraction: 0.8);
  int currentPage = 0;
  bool isSelected;

  String activetag = 'a';
  bool isMiddle = true;
  _launchURL() async {
    const url =
        'https://www.who.int/emergencies/diseases/novel-coronavirus-2019/question-and-answers-hub/q-a-detail/q-a-coronaviruses#:~:text=symptoms';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  buildTagPage() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        height: 500,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Filters',
              style: GoogleFonts.getFont('Montserrat',
                  fontSize: 26, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 10,
            ),
            buildButton('Most Common Symptoms', 'a'),
            buildButton('Less common symptoms', 'b'),
            buildButton('Serious symptoms', 'c'),
            SizedBox(
              height: 30,
            ),
            Text(
              'Seek immediate medical attention if you have serious symptoms. Always call before visiting your doctor or health facility.',
              style: TextStyle(fontSize: 15),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'People with mild symptoms who are otherwise healthy should manage their symptoms at home.',
              style: TextStyle(fontSize: 15),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'On average it takes 5–6 days from when someone is infected with the virus for symptoms to show, however it can take up to 14 days.',
              style: TextStyle(fontSize: 15),
            ),
            SizedBox(
              height: 10,
            ),
            RichText(
              text: TextSpan(
                children: <TextSpan>[
                  TextSpan(
                      text: 'Learn More On : ',
                      style: TextStyle(fontSize: 18, color: Colors.black)),
                  TextSpan(
                    text: 'who.init',
                    recognizer: TapGestureRecognizer()..onTap = _launchURL,
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  buildButton(name, tag) {
    Color textColor = tag == activetag ? Colors.white : Colors.black;
    Gradient grdient = tag == activetag
        ? LinearGradient(colors: [
            Color(0xffff0084),
            Color(0xffAA076B),
          ], begin: Alignment.topLeft, end: Alignment.bottomRight)
        : LinearGradient(colors: [Colors.white, Colors.white]);
    FontWeight textWeight =
        tag == activetag ? FontWeight.w700 : FontWeight.normal;
    double size = tag == activetag ? 18.00 : 16.00;
    return GestureDetector(
      onTap: () {
        setState(
          () {
            activetag = tag;
            firstData.clear();
            Iterable<Symtom> d =
                mainData.where((element) => element.tag.contains(tag));
            d.forEach(
              (element) {
                firstData.add(element);
              },
            );
          },
        );
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 100),
        decoration: BoxDecoration(
            gradient: grdient, borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(
            '$name',
            style: TextStyle(
                color: textColor, fontSize: size, fontWeight: textWeight),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: AnimatedAlign(
          alignment: !isMiddle ? Alignment.bottomCenter : Alignment.topLeft,
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
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            PageView.builder(
              physics: ClampingScrollPhysics(),
              itemCount: firstData.length + 1,
              controller: ctrl,
              onPageChanged: (int i) {
                print(ctrl);
                int next = ctrl.page.round();
                if (currentPage != next) {
                  setState(
                    () {
                      currentPage = next;
                    },
                  );
                }
                if (currentPage == 0) {
                  setState(
                    () {
                      isMiddle = true;
                    },
                  );
                } else {
                  setState(
                    () {
                      isMiddle = false;
                    },
                  );
                }
              },
              itemBuilder: (context, int index) {
                if (index == 0) {
                  return buildTagPage();
                } else if (firstData.length >= index) {
                  bool active = index == currentPage;
                  return buildContainer(firstData[index - 1], active);
                }
                return Text('h');
              },
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  firstData.length + 1,
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
                          setState(
                            () {
                              currentPage = index;
                            },
                          );
                        },
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          height: 18,
                          width: 18,
                          decoration: BoxDecoration(
                            // color: isSelected ? Colors.purple : Colors.white,
                            gradient: isSelected
                                ? LinearGradient(
                                    colors: [
                                        Color(0xffff0084),
                                        Color(0xffAA076B),
                                      ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight)
                                : LinearGradient(
                                    colors: [Colors.white, Colors.white],
                                  ),
                            borderRadius: BorderRadius.circular(5000),
                            border: Border.all(color: Colors.purple),
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
      ),
    );
  }

  buildContainer(Symtom a, bool active) {
    final double blur = active ? 30 : 0;
    final double offset = active ? 20 : 0;
    final double top = active ? 75 : 150;
    Gradient grdient = active
        ? LinearGradient(colors: [
            Color(0xffff0084),
            Color(0xffAA076B),
          ], begin: Alignment.topLeft, end: Alignment.bottomRight)
        : LinearGradient(colors: [Colors.white, Colors.white]);
    Color color = active ? Colors.white : Colors.black;
    return AnimatedContainer(
      decoration: BoxDecoration(
        // color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        gradient: grdient,
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
      height: 100,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
        child: Center(
          child: Column(
            children: <Widget>[
              Container(
                child: Image.asset("${a.image}"),
                color: Colors.transparent,
              ),
              SizedBox(
                height: 12,
              ),
              Text(
                "${a.name.toUpperCase()}",
                overflow: TextOverflow.fade,
                style: GoogleFonts.getFont('Montserrat',
                    fontSize: 22, fontWeight: FontWeight.w500, color: color),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 12,
              ),
              Text(
                "${a.desc}",
                textAlign: TextAlign.center,
                overflow: TextOverflow.visible,
                style: TextStyle(
                  fontSize: 16,
                  color: color,
                  wordSpacing: 1,
                ),
              )
            ],
          ),
        ),
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
