import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:carousel_slider/carousel_slider.dart';

typedef void Func();
List<DataPoint> args;
var jsonResponse;

class Ppppp extends StatefulWidget {
  @override
  _PppppState createState() => _PppppState();
  final String country, countryname;
  final int d, r, c, a, td, tr, tc;

  Ppppp({
    @required this.country,
    @required this.d,
    @required this.r,
    @required this.c,
    @required this.a,
    @required this.td,
    @required this.tr,
    @required this.tc,
    @required this.countryname,
  });
}

class DataPoint {
  String date;
  int num;
  DataPoint(this.date, this.num);
}

class _PppppState extends State<Ppppp> {
  int ind = 0;
  static void getData(Func f, cty) async {
    String url =
        "https://api.thevirustracker.com/free-api?countryTimeline=$cty";
    var response = await http.get(url);
    jsonResponse = convert.jsonDecode(response.body);
    f();
  }

  List<DataPoint> timeline1 = List<DataPoint>();
  List<DataPoint> timeline2 = List<DataPoint>();
  List<DataPoint> timeline3 = List<DataPoint>();
  void loadData() {
    setState(() {
      jsonResponse = jsonResponse['timelineitems'][0];
      jsonResponse.forEach((key, val) {
        ind = jsonResponse.length;
        if (key != 'stat') {
          timeline1.add(DataPoint(key, val['new_daily_cases']));

          timeline2.add(DataPoint(key, val['new_daily_deaths']));
        }
      });
    });
  }

  List<WorldData> worlddata = [];
  int index1 = 0;
  @override
  void initState() {
    super.initState();
    getData(loadData, widget.country);
    setState(() {
      worlddata.add(WorldData('Cases', widget.c.toDouble(),
          widget.tc.toDouble(), Colors.orange, Icons.add));

      worlddata.add(WorldData('Recovered', widget.r.toDouble(),
          widget.tr.toDouble(), Colors.green, Icons.favorite));
      worlddata.add(WorldData('Deaths', widget.d.toDouble(),
          widget.td.toDouble(), Colors.red, Icons.close));
      worlddata.add(WorldData(
          'Active', widget.a.toDouble(), 0.0, Colors.pink, Icons.healing));
    });
  }

  @override
  Widget build(BuildContext context) {
    if (jsonResponse == null) {
      return Scaffold(
        body: Center(
          child: Text('Loading Data...'),
        ),
      );
    } else {
      List<LineSeries<DataPoint, double>> charts = [
        LineSeries<DataPoint, double>(
          width: 3,
          color: Colors.red,
          xAxisName: 'deaths',
          yAxisName: 'days',
          dataSource: timeline2,
          xValueMapper: (DataPoint sales, _) =>
              timeline2.indexOf(sales).toDouble(),
          yValueMapper: (DataPoint sales, _) => sales.num,
        ),
        LineSeries<DataPoint, double>(
          xAxisName: 'cases',
          yAxisName: 'days',
          color: Colors.black,
          width: 2,
          dataSource: timeline1,
          xValueMapper: (DataPoint sales, _) =>
              timeline1.indexOf(sales).toDouble(),
          yValueMapper: (DataPoint sales, _) => sales.num,
        ),
      ];
      List<String> chartName = ['deaths per day', 'Cases per day'];
      return Scaffold(
        appBar: AppBar(
          title: Text(widget.countryname),
          centerTitle: true,
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
        body: Column(
          children: [
            Container(
              height: 200,
              child: CarouselSlider(
                options: CarouselOptions(
                    autoPlayAnimationDuration: Duration(milliseconds: 100),
                    height: 200.0,
                    autoPlay: true,
                    initialPage: 1,
                    viewportFraction: 1),
                items: charts.map((index) {
                  return Builder(
                    builder: (BuildContext context) {
                      return SfCartesianChart(
                        series: <ChartSeries>[charts[charts.indexOf(index)]],
                      );
                    },
                  );
                }).toList(),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Container(
                      height: 10,
                      width: 15,
                      color: Colors.black,
                    ),
                    Text(chartName[1]),
                  ],
                ), Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      height: 10,
                      width: 15,
                      color: Colors.red,
                    ),
                    Text(chartName[0]),
                  ],
                ),
              ],
            ),
            Container(
              height: 400,
              child: GridView.count(
                crossAxisCount: 2,
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
              ),
            )
          ],
        ),
      );
    }
  }

  Column buildColumn(int index, WorldData d) {
    Color color = d.color;
    String name = d.name;
    String num = (d.inte - d.tinte).round().toString();
    String tnum = d.tinte.round().toString();
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
        Column(
          children: [
            Text(
              num,
              style: TextStyle(
                  color: color,
                  fontSize: 20,
                  letterSpacing: 1,
                  fontWeight: FontWeight.bold),
            ),
            if (!(d.name == 'Active')) ...[
              Text(
                '+$tnum',
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 20,
                    letterSpacing: 1,
                    fontWeight: FontWeight.bold),
              ),
            ]
          ],
        ),
        Text(name)
      ],
    );
  }
}

class WorldData {
  WorldData(this.name, this.inte, this.tinte, this.color, this.iconname);
  final String name;
  final double inte;
  final double tinte;
  final Color color;
  final IconData iconname;
}
