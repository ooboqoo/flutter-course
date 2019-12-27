import 'package:flutter/material.dart';
import '../dummy_data.dart';

class MealDetailPage extends StatelessWidget {
  final String id;
  MealDetailPage(this.id);

  Widget buildSectionTitle(BuildContext context, String text) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15),
      child: Text(text, style: Theme.of(context).textTheme.title),
    );
  }

  Widget buildContainer({Widget child, double height = 200}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.symmetric(horizontal: 10),
      padding: EdgeInsets.all(10),
      constraints: BoxConstraints(maxHeight: height),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final meal = DUMMY_MEALS.firstWhere((meal) => meal.id == id);
    return Scaffold(
      appBar: AppBar(title: Text('${meal.title}')),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Image.network(meal.imageUrl,
                width: double.infinity, height: 250, fit: BoxFit.cover),
            buildSectionTitle(context, 'Ingredients'),
            buildContainer(
              child: ListView.builder(
                itemBuilder: (ctx, index) => Container(
                  decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.black12)),
                  ),
                  padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
                  child: Text(meal.ingredients[index]),
                ),
                itemCount: meal.ingredients.length,
                shrinkWrap: true,
              ),
            ),
            buildSectionTitle(context, 'Steps'),
            buildContainer(
              height: 300,
              child: ListView.builder(
                itemBuilder: (ctx, index) => Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(child: Text('${(index + 1)}')),
                      title: Text(meal.steps[index]),
                    ),
                    Divider()
                  ],
                ),
                itemCount: meal.steps.length,
                shrinkWrap: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
