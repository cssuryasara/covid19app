// import 'package:covid_19/pages/search.dart';
import 'package:covid19app/widgets/search.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../widgets/countrydetail.dart';

class CountryPage extends StatefulWidget {
  @override
  _CountryPageState createState() => _CountryPageState();
}

class _CountryPageState extends State<CountryPage> {
  List countryData;
  fetchCountryData() async {
    http.Response response =
        await http.get('https://disease.sh/v2/countries?sort=cases');
    setState(() {
      countryData = json.decode(response.body);
    });
  }

  @override
  void initState() {
    fetchCountryData();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(context: context, delegate: Search(countryData));
              })
        ],
        title: Text(
          'Countrywise Statistics',
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
      body: countryData == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: countryData == null ? 0 : countryData.length,
              itemBuilder: (context, index) {
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ExpansionTile(
                      // backgroundColor: Colors.amber,
                      title: Padding(
                        padding: const EdgeInsets.all(8.0),
                        //7.deaths
                        child: Text(countryData[index]['country'],
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      leading: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.network(
                            countryData[index]['countryInfo']['flag'],
                            height: 50,
                            width: 60),
                      ),
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      'CONFIRMED :' +
                                          countryData[index]['cases']
                                              .toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red),
                                    ),
                                    Text(
                                      'ACTIVE :' +
                                          countryData[index]['active']
                                              .toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blue),
                                    ),
                                    Text(
                                      'RECOVERED :' +
                                          countryData[index]['recovered']
                                              .toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.green),
                                    ),
                                    Text(
                                      'DEATHS :' +
                                          countryData[index]['deaths']
                                              .toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey[400]),
                                    ),
                                  ],
                                ),
                              ),
                              FlatButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (c) => Ppppp(
                                          country: countryData[index]
                                              ['countryInfo']['iso2'],
                                          d: countryData[index]['deaths'],
                                          r: countryData[index]['recovered'],
                                          c: countryData[index]['cases'],
                                          a: countryData[index]['active'],
                                          td: countryData[index]['todayDeaths'],
                                          tr: countryData[index]['todayRecovered'],
                                          tc: countryData[index]['todayCases'],
                                          countryname:countryData[index]['country'],
                                        ),
                                      ),
                                    );
                                  },
                                  child: Row(
                                    children: [
                                      Text(
                                        'ViewMore ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Icon(Icons.launch)
                                    ],
                                  ))
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
/*
Card(
                  child: Container(
                    height: 130,
                    decoration:
                        BoxDecoration(color: Colors.blueGrey[800], boxShadow: [
                      BoxShadow(
                        color: Colors.blueGrey[900],
                        blurRadius: 10,
                        offset: Offset(0, 10),
                      )
                    ]),
                    child: Row(children: <Widget>[
                      Container(
                          margin: EdgeInsets.all(20),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  countryData[index]['country'],
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                Image.network(
                                    countryData[index]['countryInfo']['flag'],
                                    height: 50,
                                    width: 60)
                              ])),
                      Expanded(
                          child: Container(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                'CONFIRMED :' +
                                    countryData[index]['cases'].toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red),
                              ),
                              Text(
                                'ACTIVE :' +
                                    countryData[index]['active'].toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue),
                              ),
                              Text(
                                'RECOVERED :' +
                                    countryData[index]['recovered'].toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green),
                              ),
                              Text(
                                'DEATHS :' +
                                    countryData[index]['deaths'].toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[400]),
                              ),
                            ]),
                      )),
                    ]),
                  ),
                )*/
