import 'package:flutter/material.dart';
import '../dummy_data.dart';
import 'MealItem.dart';

class MealsPage extends StatelessWidget {
  static const routeName = '/meals';

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    final String categoryId = routeArgs['id'];
    final String categoryTitle = routeArgs['title'];
    final meals = DUMMY_MEALS
        .where((meal) => meal.categories.contains(categoryId))
        .toList();
    return Scaffold(
      appBar: AppBar(title: Text(categoryTitle)),
      body: ListView.builder(
        itemBuilder: (context, index) => MealItem(
          id: meals[index].id,
          title: meals[index].title,
          imageUrl: meals[index].imageUrl,
          duration: meals[index].duration,
          affordability: meals[index].affordability,
          complexity: meals[index].complexity,
        ),
        itemCount: meals.length,
      ),
    );
  }
}
