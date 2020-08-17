import 'package:covid19app/provider/newsdata.dart';
import 'package:covid19app/screens/webviewpage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:cached_network_image/cached_network_image.dart';



class NewsPage extends StatefulWidget {
  @override
  _NewsPageState createState() => new _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  // var index = 0;
  List<News> _list = new List<News>();
  Future<List<News>> fetchNews() async {
    final response = await http.get(
        'https://newsapi.org/v2/everything?q=covid19&apiKey=b93117d774cd4157b600e09e71e53e17');
    Map map = json.decode(response.body);
    // final responseJson = json.decode(response.body);
    for (int i = 0; i < map['articles'].length; i++) {
      if (map['articles'][i]['author'] != null) {
        _list.add(new News.fromJson(map['articles'][i]));
      }
    }
    return _list;
  }

  PageController _controller = PageController(
    initialPage: 0,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: fetchNews(),
        builder: (BuildContext context, AsyncSnapshot<List<News>> snapshot) {
          if (snapshot.hasData) {
            return PageView.builder(
                controller: _controller,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) => GestureDetector(
                      onHorizontalDragEnd: (details) {
                        if (details.primaryVelocity > 0) {
                          print('right');
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (ctxt) => WebviewPage(
                                url: snapshot.data[index].url,
                              ),
                            ),
                          );
                        }
                      },
                      child: Column(
                        children: <Widget>[
                          Container(
                            height: 300,
                            child: CachedNetworkImage(
                              imageUrl: snapshot.data[index].urlToImage,
                              placeholder: (context, url) =>
                                  JumpingDotsProgressIndicator(
                                fontSize: 200.0,
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Text(
                              '${snapshot.data[index].title}',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20.0),
                            ),
                          ),
                          Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Text(
                                '${snapshot.data[index].description}',
                                style: TextStyle(fontSize: 18.0),
                              ))
                        ],
                      ),
                    ));
          } else {
            return JumpingDotsProgressIndicator(
              fontSize: 20.0,
            );
          }
        },
      ),
    );
  }
}
