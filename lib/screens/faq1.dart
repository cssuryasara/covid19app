import 'package:covid19app/data/faq.dart';
import 'package:flutter/material.dart';

class FAQ extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: Faq.questionAnswers.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.all(3),
              child: Card(
                child: ExpansionTile(
                  title: Text(
                    Faq.questionAnswers[index]['question'],
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(Faq.questionAnswers[index]['answer']),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}