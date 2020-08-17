import 'package:flutter/material.dart';

import 'countrydetail.dart';

class Search extends SearchDelegate {
  final List countryList;

  Search(this.countryList);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = '';
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.arrow_back_ios),
        onPressed: () {
          Navigator.pop(context);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? countryList
        : countryList
            .where((element) =>
                element['country'].toString().toLowerCase().startsWith(query))
            .toList();

    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) {
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ExpansionTile(
              // backgroundColor: Colors.amber,
              title: Padding(
                padding: const EdgeInsets.all(8.0),
                //7.deaths
                child: Text(suggestionList[index]['country'],
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.network(
                    suggestionList[index]['countryInfo']['flag'],
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
                                  suggestionList[index]['cases'].toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red),
                            ),
                            Text(
                              'ACTIVE :' +
                                  suggestionList[index]['active'].toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue),
                            ),
                            Text(
                              'RECOVERED :' +
                                  suggestionList[index]['recovered'].toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green),
                            ),
                            Text(
                              'DEATHS :' +
                                  suggestionList[index]['deaths'].toString(),
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
                                country: suggestionList[index]['countryInfo']
                                    ['iso2'],
                                d: suggestionList[index]['deaths'],
                                r: suggestionList[index]['recovered'],
                                c: suggestionList[index]['cases'],
                                a: suggestionList[index]['active'],
                                td: suggestionList[index]['todayDeaths'],
                                tr: suggestionList[index]['todayRecovered'],
                                tc: suggestionList[index]['todayCases'],
                                countryname: suggestionList[index]['country'],
                              ),
                            ),
                          );
                        },
                        child: Row(
                          children: [
                            Text(
                              'ViewMore ',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Icon(Icons.launch)
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
