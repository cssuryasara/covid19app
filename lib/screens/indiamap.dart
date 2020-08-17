import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class Detaildata {
  Detaildata(
    this.name,
    this.inte,
    this.color,
  );
  final String name;
  int inte;
  final Color color;
}

class D extends StatefulWidget {
  D({Key key}) : super(key: key);

  @override
  _DState createState() => _DState();
}

class _DState extends State<D> {
  Map countryData;
  fetchCountryData() async {
    http.Response response =
        await http.get('https://api.covid19india.org/data.json');
    setState(() {
      countryData = json.decode(response.body);
    });
  }

  Map<String, dynamic> dta;
  fetchCountryDat() async {
    http.Response response =
        await http.get('https://disease.sh/v3/covid-19/countries/IN');
    setState(() {
      dta = json.decode(response.body);
    });
  }

  @override
  void initState() {
    super.initState();
    fetchCountryData();
    fetchCountryDat();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: dta == null
            ? LinearProgressIndicator()
            : Center(
                child: IndiaMap(
                data: countryData,
                d: dta['deaths'].round(),
                r: dta['recovered'].round(),
                c: dta['cases'].round(),
                a: dta['active'].round(),
              )));
  }
}

class IndiaMap extends StatefulWidget {
  @override
  _IndiaMapState createState() => _IndiaMapState();
  final Map<String, dynamic> data;
  final int d, r, c, a;

  IndiaMap({
    @required this.data,
    @required this.d,
    @required this.r,
    @required this.c,
    @required this.a,
  });
}

class _IndiaMapState extends State<IndiaMap> {
  List<Detaildata> worldata = [];

  @override
  void initState() {
    super.initState();
    setState(() {
      worldata.add(Detaildata(
        'Cases',
        widget.c,
        Colors.orange,
      ));
      worldata.add(Detaildata(
        'Recovered',
        widget.r,
        Colors.green,
      ));
      worldata.add(Detaildata(
        'Deaths',
        widget.d,
        Colors.red,
      ));
      worldata.add(Detaildata(
        'Active',
        widget.a,
        Colors.pink,
      ));
    });
  }

  String data = 'india';

  List<Color> colors = [
    Colors.greenAccent,
    Colors.yellow,
    Colors.pinkAccent,
    Colors.amberAccent,
    Colors.lime,
    Colors.green,
    Colors.limeAccent,
    Colors.yellowAccent,
    Colors.blue,
    Colors.amber,
    Colors.lightBlue,
    Colors.lightBlueAccent,
    Colors.blueAccent,
    Colors.teal,
    Colors.orange,
    Colors.orangeAccent
  ];

  Random r = Random();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          brightness: Brightness.dark,
          title: Text(
            data,
            style: GoogleFonts.getFont('Montserrat',
                fontSize: 20, color: Colors.white),
          ),
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
        body: Stack(
          overflow: Overflow.visible,
          children: [
            InteractiveViewer(
              boundaryMargin: EdgeInsets.all(100),
              minScale: 1,
              maxScale: 2.6,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    top: 0,
                    left: 60.62432861328125,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          data = widget.data['statewise'][18]['state'];

                          worldata[0].inte = int.parse(
                                  widget.data['statewise'][18]['confirmed']) +
                              int.parse(
                                  widget.data['statewise'][30]['confirmed']);
                          worldata[1].inte = int.parse(
                                  widget.data['statewise'][18]['recovered']) +
                              int.parse(
                                  widget.data['statewise'][30]['recovered']);
                          worldata[2].inte = int.parse(
                                  widget.data['statewise'][18]['deaths']) +
                              int.parse(widget.data['statewise'][30]['deaths']);
                          worldata[3].inte = int.parse(
                                  widget.data['statewise'][18]['active']) +
                              int.parse(widget.data['statewise'][30]['active']);
                        });
                      },
                      child: SvgPicture.asset('assets/images/injk.svg',
                          color: colors[r.nextInt(16)], semanticsLabel: 'injk'),
                    ),
                  ),
                  Positioned(
                    top: 341.0630798339844,
                    left: 328.8288269042969,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          data = widget.data['statewise'][29]['state'];

                          worldata[0].inte = int.parse(
                              widget.data['statewise'][29]['confirmed']);
                          worldata[1].inte = int.parse(
                              widget.data['statewise'][29]['recovered']);
                          worldata[2].inte =
                              int.parse(widget.data['statewise'][29]['deaths']);
                          worldata[3].inte =
                              int.parse(widget.data['statewise'][29]['active']);
                        });
                      },
                      child: SvgPicture.asset(
                        'assets/images/inan.svg',
                        color: colors[r.nextInt(16)],
                        semanticsLabel: 'inan',
                      ),
                    ),
                  ),
                  Positioned(
                    top: 280.0771789550781,
                    left: 117.33141326904297,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          data = widget.data['statewise'][3]['state'];

                          worldata[0].inte = int.parse(
                              widget.data['statewise'][3]['confirmed']);
                          worldata[1].inte = int.parse(
                              widget.data['statewise'][3]['recovered']);
                          worldata[2].inte =
                              int.parse(widget.data['statewise'][3]['deaths']);
                          worldata[3].inte =
                              int.parse(widget.data['statewise'][3]['active']);
                        });
                      },
                      child: SvgPicture.asset('assets/images/inap.svg',
                          color: colors[r.nextInt(16)], semanticsLabel: 'inap'),
                    ),
                  ),
                  Positioned(
                    top: 124.71508026123047,
                    left: 319.65155029296875,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          data = widget.data['statewise'][28]['state'];

                          worldata[0].inte = int.parse(
                              widget.data['statewise'][28]['confirmed']);
                          worldata[1].inte = int.parse(
                              widget.data['statewise'][28]['recovered']);
                          worldata[2].inte =
                              int.parse(widget.data['statewise'][28]['deaths']);
                          worldata[3].inte =
                              int.parse(widget.data['statewise'][28]['active']);
                        });
                      },
                      child: SvgPicture.asset('assets/images/inar.svg',
                          color: colors[r.nextInt(16)], semanticsLabel: 'inar'),
                    ),
                  ),
                  Positioned(
                    top: 147.95806884765625,
                    left: 294.3431701660156,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          data = widget.data['statewise'][11]['state'];

                          worldata[0].inte = int.parse(
                              widget.data['statewise'][11]['confirmed']);
                          worldata[1].inte = int.parse(
                              widget.data['statewise'][11]['recovered']);
                          worldata[2].inte =
                              int.parse(widget.data['statewise'][11]['deaths']);
                          worldata[3].inte =
                              int.parse(widget.data['statewise'][11]['active']);
                        });
                      },
                      child: SvgPicture.asset('assets/images/inas.svg',
                          color: colors[r.nextInt(16)], semanticsLabel: 'inas'),
                    ),
                  ),
                  Positioned(
                    top: 155.0919189453125,
                    left: 207.07679748535156,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          data = widget.data['statewise'][8]['state'];

                          worldata[0].inte = int.parse(
                              widget.data['statewise'][8]['confirmed']);
                          worldata[1].inte = int.parse(
                              widget.data['statewise'][8]['recovered']);
                          worldata[2].inte =
                              int.parse(widget.data['statewise'][8]['deaths']);
                          worldata[3].inte =
                              int.parse(widget.data['statewise'][8]['active']);
                        });
                      },
                      child: SvgPicture.asset('assets/images/inbr.svg',
                          color: colors[r.nextInt(16)], semanticsLabel: 'inbr'),
                    ),
                  ),
                  Positioned(
                    top: 103.52790832519531,
                    left: 116.38282775878906,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          data = widget.data['statewise'][31]['state'];

                          worldata[0].inte = int.parse(
                              widget.data['statewise'][31]['confirmed']);
                          worldata[1].inte = int.parse(
                              widget.data['statewise'][31]['recovered']);
                          worldata[2].inte =
                              int.parse(widget.data['statewise'][31]['deaths']);
                          worldata[3].inte =
                              int.parse(widget.data['statewise'][31]['active']);
                        });
                      },
                      child: SvgPicture.asset('assets/images/inch.svg',
                          color: colors[r.nextInt(16)], semanticsLabel: 'inch'),
                    ),
                  ),
                  Positioned(
                    top: 207.13214111328125,
                    left: 164.98545837402344,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          data = widget.data['statewise'][20]['state'];

                          worldata[0].inte = int.parse(
                              widget.data['statewise'][20]['confirmed']);
                          worldata[1].inte = int.parse(
                              widget.data['statewise'][20]['recovered']);
                          worldata[2].inte =
                              int.parse(widget.data['statewise'][20]['deaths']);
                          worldata[3].inte =
                              int.parse(widget.data['statewise'][20]['active']);
                        });
                      },
                      child: SvgPicture.asset('assets/images/inct.svg',
                          color: colors[r.nextInt(16)], semanticsLabel: 'inct'),
                    ),
                  ),
                  Positioned(
                    top: 253.3209686279297,
                    left: 34.04112243652344,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          data = widget.data['statewise'][32]['state'];

                          worldata[0].inte = int.parse(
                              widget.data['statewise'][32]['confirmed']);
                          worldata[1].inte = int.parse(
                              widget.data['statewise'][32]['recovered']);
                          worldata[2].inte =
                              int.parse(widget.data['statewise'][32]['deaths']);
                          worldata[3].inte =
                              int.parse(widget.data['statewise'][32]['active']);
                        });
                      },
                      child: SvgPicture.asset('assets/images/indd.svg',
                          color: colors[r.nextInt(16)], semanticsLabel: 'indd'),
                    ),
                  ),
                  Positioned(
                    top: 133.80841064453125,
                    left: 118.35844421386719,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          data = widget.data['statewise'][5]['state'];

                          worldata[0].inte = int.parse(
                              widget.data['statewise'][5]['confirmed']);
                          worldata[1].inte = int.parse(
                              widget.data['statewise'][5]['recovered']);
                          worldata[2].inte =
                              int.parse(widget.data['statewise'][5]['deaths']);
                          worldata[3].inte =
                              int.parse(widget.data['statewise'][5]['active']);
                        });
                      },
                      child: SvgPicture.asset('assets/images/indl.svg',
                          color: colors[r.nextInt(16)], semanticsLabel: 'indl'),
                    ),
                  ),
                  Positioned(
                    top: 262.5420227050781,
                    left: 64.84425354003906,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          data = widget.data['statewise'][32]['state'];

                          worldata[0].inte = int.parse(
                              widget.data['statewise'][32]['confirmed']);
                          worldata[1].inte = int.parse(
                              widget.data['statewise'][32]['recovered']);
                          worldata[2].inte =
                              int.parse(widget.data['statewise'][32]['deaths']);
                          worldata[3].inte =
                              int.parse(widget.data['statewise'][32]['active']);
                        });
                      },
                      child: SvgPicture.asset('assets/images/indn.svg',
                          color: colors[r.nextInt(16)], semanticsLabel: 'indn'),
                    ),
                  ),
                  Positioned(
                    top: 328.34661865234375,
                    left: 75.18385314941406,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          data = widget.data['statewise'][22]['state'];

                          worldata[0].inte = int.parse(
                              widget.data['statewise'][22]['confirmed']);
                          worldata[1].inte = int.parse(
                              widget.data['statewise'][22]['recovered']);
                          worldata[2].inte =
                              int.parse(widget.data['statewise'][22]['deaths']);
                          worldata[3].inte =
                              int.parse(widget.data['statewise'][22]['active']);
                        });
                      },
                      child: SvgPicture.asset('assets/images/inga.svg',
                          color: colors[r.nextInt(16)], semanticsLabel: 'inga'),
                    ),
                  ),
                  Positioned(
                    top: 198.03033447265625,
                    left: 0.0,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          data = widget.data['statewise'][10]['state'];

                          worldata[0].inte = int.parse(
                              widget.data['statewise'][10]['confirmed']);
                          worldata[1].inte = int.parse(
                              widget.data['statewise'][10]['recovered']);
                          worldata[2].inte =
                              int.parse(widget.data['statewise'][10]['deaths']);
                          worldata[3].inte =
                              int.parse(widget.data['statewise'][10]['active']);
                        });
                      },
                      child: SvgPicture.asset('assets/images/ingj.svg',
                          color: colors[r.nextInt(16)], semanticsLabel: 'ingj'),
                    ),
                  ),
                  Positioned(
                    top: 63.76215744018555,
                    left: 101.16627502441406,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          data = widget.data['statewise'][26]['state'];

                          worldata[0].inte = int.parse(
                              widget.data['statewise'][26]['confirmed']);
                          worldata[1].inte = int.parse(
                              widget.data['statewise'][26]['recovered']);
                          worldata[2].inte =
                              int.parse(widget.data['statewise'][26]['deaths']);
                          worldata[3].inte =
                              int.parse(widget.data['statewise'][26]['active']);
                        });
                      },
                      child: SvgPicture.asset('assets/images/inhp.svg',
                          color: colors[r.nextInt(16)], semanticsLabel: 'inhp'),
                    ),
                  ),
                  Positioned(
                    top: 101.42874145507812,
                    left: 85.92815399169922,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          data = widget.data['statewise'][14]['state'];

                          worldata[0].inte = int.parse(
                              widget.data['statewise'][14]['confirmed']);
                          worldata[1].inte = int.parse(
                              widget.data['statewise'][14]['recovered']);
                          worldata[2].inte =
                              int.parse(widget.data['statewise'][14]['deaths']);
                          worldata[3].inte =
                              int.parse(widget.data['statewise'][14]['active']);
                        });
                      },
                      child: SvgPicture.asset('assets/images/inhr.svg',
                          color: colors[r.nextInt(16)], semanticsLabel: 'inhr'),
                    ),
                  ),
                  Positioned(
                    top: 188.30743408203125,
                    left: 207.1545867919922,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          data = widget.data['statewise'][19]['state'];

                          worldata[0].inte = int.parse(
                              widget.data['statewise'][19]['confirmed']);
                          worldata[1].inte = int.parse(
                              widget.data['statewise'][19]['recovered']);
                          worldata[2].inte =
                              int.parse(widget.data['statewise'][19]['deaths']);
                          worldata[3].inte =
                              int.parse(widget.data['statewise'][19]['active']);
                        });
                      },
                      child: SvgPicture.asset('assets/images/injh.svg',
                          color: colors[r.nextInt(16)], semanticsLabel: 'INJH'),
                    ),
                  ),
                  Positioned(
                    top: 290.25396728515625,
                    left: 80.86294555664062,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          data = widget.data['statewise'][4]['state'];

                          worldata[0].inte = int.parse(
                              widget.data['statewise'][4]['confirmed']);
                          worldata[1].inte = int.parse(
                              widget.data['statewise'][4]['recovered']);
                          worldata[2].inte =
                              int.parse(widget.data['statewise'][4]['deaths']);
                          worldata[3].inte =
                              int.parse(widget.data['statewise'][4]['active']);
                        });
                      },
                      child: SvgPicture.asset('assets/images/inka.svg',
                          color: colors[r.nextInt(16)], semanticsLabel: 'inka'),
                    ),
                  ),
                  Positioned(
                    top: 370.8674011230469,
                    left: 91.42679595947266,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          data = widget.data['statewise'][16]['state'];

                          worldata[0].inte = int.parse(
                              widget.data['statewise'][16]['confirmed']);
                          worldata[1].inte = int.parse(
                              widget.data['statewise'][16]['recovered']);
                          worldata[2].inte =
                              int.parse(widget.data['statewise'][16]['deaths']);
                          worldata[3].inte =
                              int.parse(widget.data['statewise'][16]['active']);
                        });
                      },
                      child: SvgPicture.asset('assets/images/inkl.svg',
                          color: colors[r.nextInt(16)], semanticsLabel: 'inkl'),
                    ),
                  ),
                  Positioned(
                    top: 386.0933532714844,
                    left: 53.605735778808594,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          data = widget.data['statewise'][37]['state'];

                          worldata[0].inte = int.parse(
                              widget.data['statewise'][37]['confirmed']);
                          worldata[1].inte = int.parse(
                              widget.data['statewise'][37]['recovered']);
                          worldata[2].inte =
                              int.parse(widget.data['statewise'][37]['deaths']);
                          worldata[3].inte =
                              int.parse(widget.data['statewise'][37]['active']);
                        });
                      },
                      child: SvgPicture.asset('assets/images/inld.svg',
                          color: colors[r.nextInt(16)], semanticsLabel: 'inld'),
                    ),
                  ),
                  Positioned(
                    top: 238.049560546875,
                    left: 61.09567642211914,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          data = widget.data['statewise'][1]['state'];

                          worldata[0].inte = int.parse(
                              widget.data['statewise'][1]['confirmed']);
                          worldata[1].inte = int.parse(
                              widget.data['statewise'][1]['recovered']);
                          worldata[2].inte =
                              int.parse(widget.data['statewise'][1]['deaths']);
                          worldata[3].inte =
                              int.parse(widget.data['statewise'][1]['active']);
                        });
                      },
                      child: SvgPicture.asset('assets/images/inmh.svg',
                          color: colors[r.nextInt(16)], semanticsLabel: 'inmh'),
                    ),
                  ),
                  Positioned(
                    top: 176.58006286621094,
                    left: 296.0821533203125,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          data = widget.data['statewise'][33]['state'];

                          worldata[0].inte = int.parse(
                              widget.data['statewise'][33]['confirmed']);
                          worldata[1].inte = int.parse(
                              widget.data['statewise'][33]['recovered']);
                          worldata[2].inte =
                              int.parse(widget.data['statewise'][33]['deaths']);
                          worldata[3].inte =
                              int.parse(widget.data['statewise'][33]['active']);
                        });
                      },
                      child: SvgPicture.asset('assets/images/inml.svg',
                          color: colors[r.nextInt(16)], semanticsLabel: 'inml'),
                    ),
                  ),
                  Positioned(
                    top: 183.00003051757812,
                    left: 339.2547302246094,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          data = widget.data['statewise'][25]['state'];

                          worldata[0].inte = int.parse(
                              widget.data['statewise'][25]['confirmed']);
                          worldata[1].inte = int.parse(
                              widget.data['statewise'][25]['recovered']);
                          worldata[2].inte =
                              int.parse(widget.data['statewise'][25]['deaths']);
                          worldata[3].inte =
                              int.parse(widget.data['statewise'][25]['active']);
                        });
                      },
                      child: SvgPicture.asset('assets/images/inmn.svg',
                          color: colors[r.nextInt(16)], semanticsLabel: 'inmn'),
                    ),
                  ),
                  Positioned(
                    top: 165.00123596191406,
                    left: 80.03530883789062,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          data = widget.data['statewise'][15]['state'];

                          worldata[0].inte = int.parse(
                              widget.data['statewise'][15]['confirmed']);
                          worldata[1].inte = int.parse(
                              widget.data['statewise'][15]['recovered']);
                          worldata[2].inte =
                              int.parse(widget.data['statewise'][15]['deaths']);
                          worldata[3].inte =
                              int.parse(widget.data['statewise'][15]['active']);
                        });
                      },
                      child: SvgPicture.asset('assets/images/inmp.svg',
                          color: colors[r.nextInt(16)], semanticsLabel: 'inmp'),
                    ),
                  ),
                  Positioned(
                    top: 200.82095336914062,
                    left: 329.44268798828125,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          data = widget.data['statewise'][35]['state'];

                          worldata[0].inte = int.parse(
                              widget.data['statewise'][35]['confirmed']);
                          worldata[1].inte = int.parse(
                              widget.data['statewise'][35]['recovered']);
                          worldata[2].inte =
                              int.parse(widget.data['statewise'][35]['deaths']);
                          worldata[3].inte =
                              int.parse(widget.data['statewise'][35]['active']);
                        });
                      },
                      child: SvgPicture.asset('assets/images/inmz.svg',
                          color: colors[r.nextInt(16)], semanticsLabel: 'inmz'),
                    ),
                  ),
                  Positioned(
                    top: 162.40744018554688,
                    left: 344.1179504394531,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          data = widget.data['statewise'][27]['state'];

                          worldata[0].inte = int.parse(
                              widget.data['statewise'][27]['confirmed']);
                          worldata[1].inte = int.parse(
                              widget.data['statewise'][27]['recovered']);
                          worldata[2].inte =
                              int.parse(widget.data['statewise'][27]['deaths']);
                          worldata[3].inte =
                              int.parse(widget.data['statewise'][27]['active']);
                        });
                      },
                      child: SvgPicture.asset('assets/images/innl.svg',
                          color: colors[r.nextInt(16)], semanticsLabel: 'innl'),
                    ),
                  ),
                  Positioned(
                    top: 230.0925750732422,
                    left: 180.62759399414062,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          data = widget.data['statewise'][13]['state'];

                          worldata[0].inte = int.parse(
                              widget.data['statewise'][13]['confirmed']);
                          worldata[1].inte = int.parse(
                              widget.data['statewise'][13]['recovered']);
                          worldata[2].inte =
                              int.parse(widget.data['statewise'][13]['deaths']);
                          worldata[3].inte =
                              int.parse(widget.data['statewise'][13]['active']);
                        });
                      },
                      child: SvgPicture.asset('assets/images/inor.svg',
                          color: colors[r.nextInt(16)], semanticsLabel: 'inor'),
                    ),
                  ),
                  Positioned(
                    top: 74.87013244628906,
                    left: 77.79884338378906,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          data = widget.data['statewise'][17]['state'];

                          worldata[0].inte = int.parse(
                              widget.data['statewise'][17]['confirmed']);
                          worldata[1].inte = int.parse(
                              widget.data['statewise'][17]['recovered']);
                          worldata[2].inte =
                              int.parse(widget.data['statewise'][17]['deaths']);
                          worldata[3].inte =
                              int.parse(widget.data['statewise'][17]['active']);
                        });
                      },
                      child: SvgPicture.asset('assets/images/inpb.svg',
                          color: colors[r.nextInt(16)], semanticsLabel: 'inpb'),
                    ),
                  ),
                  Positioned(
                    top: 314.72515869140625,
                    left: 156.80580139160156,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          data = widget.data['statewise'][24]['state'];

                          worldata[0].inte = int.parse(
                              widget.data['statewise'][24]['confirmed']);
                          worldata[1].inte = int.parse(
                              widget.data['statewise'][24]['recovered']);
                          worldata[2].inte =
                              int.parse(widget.data['statewise'][24]['deaths']);
                          worldata[3].inte =
                              int.parse(widget.data['statewise'][24]['active']);
                        });
                      },
                      child: SvgPicture.asset('assets/images/inpy.svg',
                          color: colors[r.nextInt(16)], semanticsLabel: 'inpy'),
                    ),
                  ),
                  Positioned(
                    top: 113.14471435546875,
                    left: 17.75504493713379,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          data = widget.data['statewise'][12]['state'];

                          worldata[0].inte = int.parse(
                              widget.data['statewise'][12]['confirmed']);
                          worldata[1].inte = int.parse(
                              widget.data['statewise'][12]['recovered']);
                          worldata[2].inte =
                              int.parse(widget.data['statewise'][12]['deaths']);
                          worldata[3].inte =
                              int.parse(widget.data['statewise'][12]['active']);
                        });
                      },
                      child: SvgPicture.asset('assets/images/inrj.svg',
                          color: colors[r.nextInt(16)], semanticsLabel: 'inrj'),
                    ),
                  ),
                  Positioned(
                    top: 145.5922088623047,
                    left: 271.38494873046875,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          data = widget.data['statewise'][34]['state'];

                          worldata[0].inte = int.parse(
                              widget.data['statewise'][34]['confirmed']);
                          worldata[1].inte = int.parse(
                              widget.data['statewise'][34]['recovered']);
                          worldata[2].inte =
                              int.parse(widget.data['statewise'][34]['deaths']);
                          worldata[3].inte =
                              int.parse(widget.data['statewise'][34]['active']);
                        });
                      },
                      child: SvgPicture.asset('assets/images/insk.svg',
                          color: colors[r.nextInt(16)], semanticsLabel: 'insk'),
                    ),
                  ),
                  Positioned(
                    top: 269.0415344238281,
                    left: 123.83421325683594,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          data = widget.data['statewise'][9]['state'];

                          worldata[0].inte = int.parse(
                              widget.data['statewise'][9]['confirmed']);
                          worldata[1].inte = int.parse(
                              widget.data['statewise'][9]['recovered']);
                          worldata[2].inte =
                              int.parse(widget.data['statewise'][9]['deaths']);
                          worldata[3].inte =
                              int.parse(widget.data['statewise'][9]['active']);
                        });
                      },
                      child: SvgPicture.asset('assets/images/intg.svg',
                          color: colors[r.nextInt(16)], semanticsLabel: 'intg'),
                    ),
                  ),
                  Positioned(
                    top: 360.3560485839844,
                    left: 110.02191162109375,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          data = widget.data['statewise'][2]['state'];

                          worldata[0].inte = int.parse(
                              widget.data['statewise'][2]['confirmed']);
                          worldata[1].inte = int.parse(
                              widget.data['statewise'][2]['recovered']);
                          worldata[2].inte =
                              int.parse(widget.data['statewise'][2]['deaths']);
                          worldata[3].inte =
                              int.parse(widget.data['statewise'][2]['active']);
                        });
                      },
                      child: SvgPicture.asset('assets/images/intn.svg',
                          color: colors[r.nextInt(16)], semanticsLabel: 'intn'),
                    ),
                  ),
                  Positioned(
                    top: 200.76966857910156,
                    left: 314.3732604980469,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          data = widget.data['statewise'][23]['state'];

                          worldata[0].inte = int.parse(
                              widget.data['statewise'][23]['confirmed']);
                          worldata[1].inte = int.parse(
                              widget.data['statewise'][23]['recovered']);
                          worldata[2].inte =
                              int.parse(widget.data['statewise'][23]['deaths']);
                          worldata[3].inte =
                              int.parse(widget.data['statewise'][23]['active']);
                        });
                      },
                      child: SvgPicture.asset('assets/images/intr.svg',
                          color: colors[r.nextInt(16)], semanticsLabel: 'intr'),
                    ),
                  ),
                  Positioned(
                    top: 109.71519470214844,
                    left: 121.77819061279297,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          data = widget.data['statewise'][6]['state'];

                          worldata[0].inte = int.parse(
                              widget.data['statewise'][6]['confirmed']);
                          worldata[1].inte = int.parse(
                              widget.data['statewise'][6]['recovered']);
                          worldata[2].inte =
                              int.parse(widget.data['statewise'][6]['deaths']);
                          worldata[3].inte =
                              int.parse(widget.data['statewise'][6]['active']);
                        });
                      },
                      child: SvgPicture.asset('assets/images/inup.svg',
                          color: colors[r.nextInt(16)], semanticsLabel: 'inup'),
                    ),
                  ),
                  Positioned(
                    top: 92.76698303222656,
                    left: 128.32151794433594,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          data = widget.data['statewise'][21]['state'];

                          worldata[0].inte = int.parse(
                              widget.data['statewise'][21]['confirmed']);
                          worldata[1].inte = int.parse(
                              widget.data['statewise'][21]['recovered']);
                          worldata[2].inte =
                              int.parse(widget.data['statewise'][21]['deaths']);
                          worldata[3].inte =
                              int.parse(widget.data['statewise'][21]['active']);
                        });
                      },
                      child: SvgPicture.asset('assets/images/inut.svg',
                          color: colors[r.nextInt(16)], semanticsLabel: 'inut'),
                    ),
                  ),
                  Positioned(
                    top: 159.6969451904297,
                    left: 241.4081573486328,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          data = widget.data['statewise'][7]['state'];

                          worldata[0].inte = int.parse(
                              widget.data['statewise'][7]['confirmed']);
                          worldata[1].inte = int.parse(
                              widget.data['statewise'][7]['recovered']);
                          worldata[2].inte =
                              int.parse(widget.data['statewise'][7]['deaths']);
                          worldata[3].inte =
                              int.parse(widget.data['statewise'][7]['active']);
                        });
                      },
                      child: SvgPicture.asset('assets/images/inwb.svg',
                          color: colors[r.nextInt(16)], semanticsLabel: 'inwb'),
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 150,
                width: size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: List.generate(
                        2,
                        (index) => Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Container(
                                width: 100,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      worldata[index].inte.round().toString(),
                                      style: TextStyle(
                                          color: worldata[index].color,
                                          fontSize: 20,
                                          letterSpacing: 1,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(worldata[index].name)
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Column(
                      children: List.generate(
                        2,
                        (index) => Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Container(
                                width: 100,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      worldata[index + 2]
                                          .inte
                                          .round()
                                          .toString(),
                                      style: TextStyle(
                                          color: worldata[index + 2].color,
                                          fontSize: 20,
                                          letterSpacing: 1,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(worldata[index + 2].name)
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
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
}
