//this will show all the meals to a selected category.

import 'package:flutter/material.dart';
import 'package:mealapp/models/meal.dart';
import 'package:mealapp/screen/meals_details.dart';
import 'package:mealapp/widgets/meal_item.dart';

//stateless because we dont want to manage internal data on this screen.
class MealsScreen extends StatelessWidget {
  const MealsScreen({
    super.key,
    this.title,
    required this.meals,
  });

//the title of this screen should be the title of the category that was selected, therefore we need to input the title and list of meals.
//using ? with the string for the title to make it optional and can be null because we are getting title. so for that reason we want to conditionally show the title.
  final String? title;
  final List<Meal> meals;

  void selectMeal(BuildContext context, Meal meal) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (ctx) => MealDetailsScreen(
              meal: meal,
            )));
  }

  @override
  Widget build(BuildContext context) {
    //if the content is not empty this would be rendered.
    Widget content = ListView.builder(
      //to tell flutter how many items i will have
      itemCount: meals.length,

      itemBuilder: (ctx, index) => MealItem(
        meal: meals[index],
        onSelectmeal: (meal) {
          selectMeal(context, meal);
        },
      ),
    );

//if the content is empty this would be rendered.
    if (meals.isEmpty) {
      content = Center(
        //using mainAxisSize to make sure it is in center and is not unconstrained vertically
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Uh Oh... nothing here!',
              style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              'Try selecting a different category!',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
          ],
        ),
      );
    }

    if (title == null) {
      return content;
    }

    //using scaffold because it takes us to a different screen where we need to show new and different content,
    return Scaffold(
      appBar: AppBar(
        //setting the title to 'title' because the title would be according the category that was selected.
        title: Text(title!),
      ),
      //setting the body to the list of the meals to show the meals according the category that was selected.
      //we use the ListView.builder to create a scrollabe list view that makes sure that only items that are actually visible will be displayed to optimize the performance in a scenario where we might have a long list
      body: content,
    );
  }
}
