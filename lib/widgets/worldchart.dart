import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Worldchart extends StatefulWidget {
  Worldchart({Key key}) : super(key: key);

  @override
  _WorldchartState createState() => _WorldchartState();
}

//https://disease.sh/v3/covid-19/all
class _WorldchartState extends State<Worldchart> {
  Map<String, dynamic> countryData;
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

class ChartData {
  ChartData(this.x, this.y, this.color);
  final String x;
  final double y;
  final Color color;
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
  List<ChartData> chartData = [];
  @override
  void initState() {
    super.initState();
    print(widget.d);
    print(widget.r);
    print(widget.c);
    print(widget.a);
    setState(() {
      chartData.add(ChartData('Deaths', widget.d.toDouble(), Colors.red));
      chartData.add(ChartData('Recovered', widget.r.toDouble(), Colors.green));
      chartData.add(ChartData('Active', widget.a.toDouble(), Colors.pink));
      chartData.add(ChartData('Cases', widget.c.toDouble(), Colors.orange));
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      height: size.height / 3,
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SfCircularChart(
                series: <CircularSeries>[
                  // Renders doughnut chart
                  DoughnutSeries<ChartData, String>(
                      radius: '100',
                      innerRadius: '60%',
                      dataSource: chartData,
                      pointColorMapper: (ChartData data, _) => data.color,
                      xValueMapper: (ChartData data, _) => data.x,
                      yValueMapper: (ChartData data, _) => data.y)
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(
                  chartData.length,
                  (index) => buildRow(chartData[index]),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Row buildRow(ChartData c) {
    return Row(
      // crossAxisAlignment: CrossAxisAlignment.baseline,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          height: 10,
          width: 25,
          color: c.color,
        ),
        SizedBox(width: 20,),
        Column(
crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(c.x),
            Text("${(c.y / widget.p * 100).toStringAsFixed(3)} %")
          ],
        )
      ],
    );
  }
}
