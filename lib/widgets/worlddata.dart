import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WorldData {
  WorldData(this.name, this.inte, this.color, this.iconname);
  final String name;
  final double inte;
  final Color color;
  final IconData iconname;
}

class Worlddata extends StatefulWidget {
  Worlddata({Key key}) : super(key: key);

  @override
  _WorlddataState createState() => _WorlddataState();
}

class _WorlddataState extends State<Worlddata> {
  Map<String, dynamic> countryData;
  List<WorldData> worlddata = [];
  fetchCountryData() async {
    http.Response response =
        await http.get('https://disease.sh/v3/covid-19/all');
    setState(() {
      countryData = json.decode(response.body);
    });
  }

  @override
  void initState() {
    super.initState();
    fetchCountryData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: countryData == null
          ? Text('data')
          : Xhart(
              d: countryData['deaths'],
              r: countryData['recovered'],
              c: countryData['cases'],
              a: countryData['active'],
              p: countryData['population']),
    );
  }
}

class Xhart extends StatefulWidget {
  const Xhart(
      {Key key,
      @required this.d,
      @required this.r,
      @required this.c,
      
      @required this.a,
      @required this.p})
      : super(key: key);
  final int d, r, c, a, p;

  @override
  _XhartState createState() => _XhartState();
}

class _XhartState extends State<Xhart> {
  List<WorldData> worlddata = [];
  @override
  void initState() {
    super.initState();
    print(widget.d);
    print(widget.r);
    print(widget.c);
    print(widget.a);
    setState(() {
      worlddata.add(
          WorldData('Cases', widget.c.toDouble(), Colors.orange, Icons.add));

      worlddata.add(WorldData(
          'Recovered', widget.r.toDouble(), Colors.green, Icons.favorite));
      worlddata.add(
          WorldData('Deaths', widget.d.toDouble(), Colors.red, Icons.close));
      worlddata.add(
          WorldData('Active', widget.a.toDouble(), Colors.pink, Icons.healing));
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.horizontal,
      children: List.generate(
        worlddata.length,
        (index) => Padding(
          padding: const EdgeInsets.all(2.0),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                width: 100,
                child: buildColumn(
                  index,
                  worlddata[index],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Column buildColumn(int index, WorldData d) {
    Color color = d.color;
    String name = d.name;
    String num = d.inte.round().toString();
    IconData iconname = d.iconname;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          decoration: BoxDecoration(
              border: Border.all(color: color, width: 1),
              color: color.withOpacity(0.4),
              borderRadius: BorderRadius.circular(50)),
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Icon(
              iconname,
              color: color,
              size: 20,
            ),
          ),
        ),
        Text(
          num,
          style: TextStyle(
              color: color,
              fontSize: 20,
              letterSpacing: 1,
              fontWeight: FontWeight.bold),
        ),
        Text(name)
      ],
    );
  }
}
