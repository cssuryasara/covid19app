import 'package:covid19app/screens/countrypage.dart';
import 'package:covid19app/screens/indiamap.dart';
import 'package:covid19app/screens/newspage.dart';
import 'package:covid19app/screens/preventionpage.dart';
import 'package:covid19app/screens/symptompage.dart';
import 'package:covid19app/widgets/hpcountry.dart';
import 'package:covid19app/widgets/hpprevention.dart';
import 'package:covid19app/widgets/hpsymptom.dart';
import 'package:covid19app/widgets/worldchart.dart';
import 'package:covid19app/widgets/worlddata.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../provider/scrolleventProvider.dart';
import 'faq1.dart';
// import 'countrydetail.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  int _currentIndex = 0;
  final List<Widget> _children = [Sclow(), NewsPage()];
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: Scrollevent(false),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Covid19DASHBOARD',
            style: GoogleFonts.getFont('Montserrat',
                fontSize: 20, color: Colors.white),
          ),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[
                  Color(0xffff0084),
                  Color(0xffAA076B),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: InkWell(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (c) => D(),
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.yellow[500],
                borderRadius: BorderRadius.circular(16)),
            width: 100,
            height: 50,
            child: Center(
              child: FlareActor(
                'assets/map (1).flr',
                animation: 'anim',
              ),
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          onTap: onTabTapped, // new
          currentIndex: _currentIndex,
          items: [
            BottomNavigationBarItem(
              title: Text('Home'),
              icon: Icon(Icons.home),
            ),
            BottomNavigationBarItem(
              title: Text('News'),
              icon: Icon(Icons.new_releases),
            ),
          ],
        ),
        body: _children[_currentIndex],
      ),
    );
  }
}

class Sclow extends StatelessWidget {
  const Sclow({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                'Covid19 Global cases',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              RaisedButton(
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (c) => FAQ()));
                },
                child: Text('Know more about corona'),
              )
            ],
          ),
          SizedBox(
            height: size.height / 3,
            child: Worldchart(),
          ),
          SizedBox(
            height: size.height / 6,
            child: Worlddata(),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Top 5 Countries',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (c) => CountryPage()));
                  },
                  child: Row(
                    children: <Widget>[
                      Text(
                        'MORE ',
                        style: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.bold),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: Colors.blue,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          CountryTile(),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Symptoms',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (ctx) => SymptomPage()));
                  },
                  child: Row(
                    children: <Widget>[
                      Text(
                        'MORE ',
                        style: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.bold),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: Colors.blue,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Hpsymptom(),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Prevention',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (ctx) => PreventionPage()));
                  },
                  child: Row(
                    children: <Widget>[
                      Text(
                        'MORE ',
                        style: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.bold),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: Colors.blue,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          HpPrevention()
        ],
      ),
    );
  }
}
