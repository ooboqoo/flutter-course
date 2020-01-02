import 'package:flutter/material.dart';

import 'app_counter/app.dart';
import 'app_quiz/app.dart';
import 'app_meals/app.dart';
import 'app-shop/app.dart';

var appList = {
  'Counter App': '/counter-app',
  'Quiz App': '/quiz-app',
  'Meals App ( navigation )': '/meals-app',
  'Shop App ( provider )': '/shop-app',
};

var appRoutes = {
  '/counter-app': (context) => CounterApp(),
  '/quiz-app': (context) => QuizApp(),
  '/meals-app': (context) => MealsApp(),
  '/shop-app': (context) => ShopApp(),
};

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  void selectApp(routeName, context) {
    Navigator.of(context).pushNamed(routeName);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Learn Flutter',
      home: Scaffold(
        appBar: AppBar(title: Text('Select an App')),
        body: ListView(
          children: appList.entries
              .map((app) => AppItem(app.key, app.value, selectApp))
              .toList(),
        ),
      ),
      routes: appRoutes,
      debugShowCheckedModeBanner: false,
    );
  }
}

class AppItem extends StatelessWidget {
  final String text;
  final String routeName;
  final Function onSelect;

  AppItem(this.text, this.routeName, this.onSelect);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      child: RaisedButton(
        color: Colors.blue,
        textColor: Colors.white,
        child: Text(text),
        onPressed: () => onSelect(routeName, context),
      ),
    );
  }
}
