import 'package:flutter/material.dart';
class Something extends StatelessWidget {
  const Something({
    Key key,
    @required this.countryData,
    @required this.selected,
    @required this.index,
  }) : super(key: key);

  final List countryData;
  final bool selected;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Row(
          mainAxisAlignment:
              MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Image.network(
                countryData[index]['countryInfo']
                    ['flag'],
                height: 50,
                width: 60),
            Text(
              countryData[index]['country'],
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.black,)
            ),
          ],
        ),
        AnimatedContainer(
          curve: Curves.easeIn,
          duration: Duration(milliseconds: 300),
          height: selected ? 180 : 0,
          width: 150,
          child: Expanded(
            child: Container(
              child: Column(
                mainAxisAlignment:
                    MainAxisAlignment.center,
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
                        countryData[index]
                                ['recovered']
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
          ),
        ),
      ],
    );
  }
}