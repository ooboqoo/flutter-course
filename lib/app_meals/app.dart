import 'package:flutter/material.dart';
import 'categories_page/CategoriesPage.dart';
import 'meals_page/MealsPage.dart';

class MealsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Delicious Meals',
      theme: ThemeData(
        primaryColor: Colors.pink,
        accentColor: Colors.amber,
      ),
      home: CategoriesPage(),
      routes: {
        MealsPage.routeName: (ctx) => MealsPage(),
      },
      onGenerateRoute: (settings) {
        print(settings);
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            appBar: AppBar(title: Text('Page Not Found!')),
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
      },
    );
  }
}
