import 'package:flutter/material.dart';

import 'app_counter/app.dart';
import 'app_quiz/app.dart';

var appList = ['Counter App', 'Quiz App'];

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool selected = false;

  void selectApp() {
    setState(() {
      selected = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Demo')),
        body: Text(
          'Hello World',
          textDirection: TextDirection.ltr,
          style: TextStyle(
            fontSize: 32,
            color: Colors.black87,
          ),
        ),
      ),
    );
  }

  Widget build2(BuildContext context) {
    return selected
        ? QuizApp()
        : MaterialApp(
            title: 'Learn Flutter',
            home: Scaffold(
              appBar: AppBar(
                title: Text('Select App'),
              ),
              body: ListView(
                children:
                    appList.map((name) => AppItem(name, selectApp)).toList(),
              ),
            ),
            debugShowCheckedModeBanner: false,
          );
  }
}

class AppItem extends StatelessWidget {
  final String text;
  final Function onSelect;

  AppItem(this.text, this.onSelect);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      child: RaisedButton(
        color: Colors.blue,
        textColor: Colors.white,
        child: Text(text),
        onPressed: onSelect,
      ),
    );
  }
}
