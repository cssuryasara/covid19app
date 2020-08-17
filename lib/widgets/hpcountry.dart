// import 'package:covid19app/provider/scrolleventProvider.dart';
import 'package:covid19app/widgets/something.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
// import 'package:provider/provider.dart';

class CountryTile extends StatefulWidget {
  @override
  _CountryTileState createState() => _CountryTileState();
}

class _CountryTileState extends State<CountryTile> {
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

  bool selected;
  var select;
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        var size = MediaQuery.of(context).size;
        // bool isscrolling = Provider.of<Scrollevent>(context).getscrooling;
        return SizedBox(
          height: size.height / 3,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: countryData == null
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: BouncingScrollPhysics(),
                    itemCount: 5,
                    itemBuilder: (BuildContext context, int index) {
                      selected = index == select;
                      return InkWell(
                        onTap: () {
                          setState(
                            () {
                              select = index;
                            },
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 14, 10, 20),
                          child: Container(
                            height: 300,
                            width: 200,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black12,
                                      // offset: Offset.fromDirection(),
                                      blurRadius: 2.0)
                                ],
                                borderRadius: BorderRadius.circular(10)),
                            child: Something(
                                countryData: countryData,
                                selected: selected,
                                index: index),
                          ),
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
