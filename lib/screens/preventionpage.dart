import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/gestures.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'symptomsdata.dart';
import '../data/preventiondata.dart';

class PreventionPage extends StatefulWidget {
  @override
  _PreventionPageState createState() => _PreventionPageState();
}

class _PreventionPageState extends State<PreventionPage> {
  final PageController ctrl = PageController(viewportFraction: 0.8);
  int currentPage = 0;
  bool isSelected;

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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(50.0),
          child: Image.asset('assets/download.gif'),
        ),
        Text(
          'Stay Home. Save Lives'.toUpperCase(),
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
        ),
        SizedBox(
          height: 15,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            RichText(
              text: TextSpan(
                children: <TextSpan>[
                  TextSpan(
                      text: '1 . ',
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.red,
                          fontWeight: FontWeight.w500)),
                  TextSpan(
                      text: 'STAY ',
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.w800)),
                  TextSpan(
                      text: 'home',
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.w400)),
                ],
              ),
            ),
            RichText(
              text: TextSpan(
                children: <TextSpan>[
                  TextSpan(
                      text: '2 . ',
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.red,
                          fontWeight: FontWeight.w500)),
                  TextSpan(
                      text: 'KEEP ',
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.w800)),
                  TextSpan(
                      text: 'a safe distance',
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.w400)),
                ],
              ),
            ),
            RichText(
              text: TextSpan(
                children: <TextSpan>[
                  TextSpan(
                      text: '3 . ',
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.red,
                          fontWeight: FontWeight.w500)),
                  TextSpan(
                      text: 'WASH ',
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.w800)),
                  TextSpan(
                      text: 'hands often',
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.w400)),
                ],
              ),
            ),
            RichText(
              text: TextSpan(
                children: <TextSpan>[
                  TextSpan(
                      text: '4 . ',
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.red,
                          fontWeight: FontWeight.w500)),
                  TextSpan(
                      text: 'COVER ',
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.w800)),
                  TextSpan(
                      text: 'your cough',
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.w400)),
                ],
              ),
            ),
            RichText(
              text: TextSpan(
                children: <TextSpan>[
                  TextSpan(
                      text: '5 . ',
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.red,
                          fontWeight: FontWeight.w500)),
                  TextSpan(
                      text: 'SICK? ',
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.w800)),
                  TextSpan(
                      text: 'Call the helpline',
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.w400)),
                ],
              ),
            )
          ],
        ),
        SizedBox(
          height: 15,
        ),
        Text(
          'Avoiding unneeded visits to medical facilities allows healthcare systems to operate more effectively, therefore protecting you and others.',
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(
          height: 15,
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
                'PREVENTION',
                style: GoogleFonts.getFont('Montserrat',
                    fontSize: 20, color: Colors.black, letterSpacing: -1),
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

  buildContainer(Prevention a, bool active) {
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
                child: Image.asset("${a.image}",height: 200,),
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
