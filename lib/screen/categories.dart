import 'package:flutter/material.dart';
import 'package:mealapp/data/dummy_data.dart';
import 'package:mealapp/models/meal.dart';
import 'package:mealapp/screen/meals.dart';
import 'package:mealapp/widgets/category_grid_item.dart';
import 'package:mealapp/models/category.dart';

//stateless widget because there wont be any internal state to be managed by the widget
class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key, required this.availableMeals});

  final List<Meal> availableMeals;

  //using a void method not to update any state but to change the screen.
  //accepting context value because in stateless widget it is not globally availaible.
  void _selectedCategory(BuildContext context, Category category) {
    //.where returns a new iterable list that only contains the items that match a certain condition.
    //contain is builtin method on a list to check whether a list contains a certain value
    //
    final filteredMeals = availableMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();

    //navigator.push method is used to navigate to a different screen.
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealsScreen(
          title: category.title,
          meals: filteredMeals,
        ),
      ),
    ); // alternatively this can also be used Navigator.push(context, route);
  }

  @override
  Widget build(BuildContext context) {
    //using scaffold because we want the default styling that it applies
    return GridView(
      padding: const EdgeInsets.all(24),
//gridDelegate is simply used to control the layout of the GridView items. 'silverGridDelegatewithFixedCrossAxisCount' is used to set the nmbr of columns. It is set to 2 so it gets two columns next to eachother
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,

        //    using the childAspectRation to set the custom height and width of grid view. childAspectRation(itemWidth / itnemHeight)
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      children: [
        for (final category in availableCategories)
          CategoryGridItem(
            category: category,
            onSelectCategory: () {
              _selectedCategory(context, category);
            },
          )
      ],
    );
  }
}
