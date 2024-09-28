import 'package:flutter/material.dart';
import 'package:mealapp/models/meal.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mealapp/provider/favourites_provider.dart';

class MealDetailsScreen extends ConsumerWidget {
  const MealDetailsScreen({
    super.key,
    required this.meal,
  });

  final Meal meal;

  @override
  //when using riverpod we also add WidgetRef ref in the build method to listen to the providers
  Widget build(BuildContext context, WidgetRef ref) {
    final favouriteMeals = ref.watch(favouritesMealsProvider);

    //using contain to check weather favourite meals contains meal here for which screen widget is being rendered.
    final isFavourite = favouriteMeals.contains(meal);
    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
        //adding the favourite button on meal details screen in the app bar
        actions: [
          IconButton(
              onPressed: () {
                //using read because we are in function and want the provider to read it once, on the read we called the function/method to toggle favourite status.
                final wasAdded = ref
                    .read(favouritesMealsProvider.notifier)
                    .toggleMealFavouritesStatus(
                        meal); //to clear any snackbar being shown
                ScaffoldMessenger.of(context).clearSnackBars();
                //to show the info/feedback
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    //using ternary expression to check whether the meal was added or removed.
                    content: Text(wasAdded
                        ? 'Meal added as a favourite.'
                        : 'Meal removed.'),
                  ),
                );
              },
              //icon would be now displayed dynamically depending on status of the meal for which we would use ternary expression.
              icon: Icon(isFavourite ? Icons.star : Icons.star_border))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(
              meal.imageUrl,
              width: double.infinity,
              height: 300,
              //to make sure the image is sized appropriately but not distorted.
              fit: BoxFit.cover,
            ),
            const SizedBox(
              height: 14,
            ),
            Text(
              'Ingredients',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 14,
            ),
            //using for loop to iterate through the ingredients in the dummydata and show them on this screen, As ingredients are list of strings so we are outputting a string.
            for (final ingredients in meal.ingredients)
              Text(ingredients,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground)),
            const SizedBox(
              height: 24,
            ),

            Text('Steps',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold)),
            const SizedBox(
              height: 14,
            ),

            for (final step in meal.steps)
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                child: Text(step,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground)),
              )
          ],
        ),
      ),
    );
  }
}
