import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mealapp/models/meal.dart';

//using the angeled brackets to tell the riverpod which kind of data will be managed by this notifier.
class FavouriteMealsNotifier extends StateNotifier<List<Meal>> {
  //we add a initializer list by adding a colon after the constructor function parameter list and then we call out super to reach out to the parent class
  FavouriteMealsNotifier() : super([]);

  bool toggleMealFavouritesStatus(Meal meal) {
    //we are not allowed to edit an existing memory in the StateNotifier instead we must always create a new one

//this would just look into the meals
    final mealISFavourite = state.contains(meal);

//using where to filter a list and get a new list or iterable which we can convert to a list by calling toList.
//keeping the meal whose id is not equal to id i am getting in the method.
//this is used to remove a meal
    if (mealISFavourite) {
      state = state.where((m) => m.id != meal.id).toList();
      return false;

      //to keep the meal
    } else {
      //using the spread operator to pull out all the elements that are stored in the list and add them as individual elements to this new list.
      //using meal after the comma so that we pull out and keep all the existing meals and add them to a new list and we also added new meal the list.
      state = [...state, meal];
      return true;
    }
  }
}

//statenotififerProvider is great to use for data that needs to be changed and is optimized for data that can change.
//connecting notifier to the provider so that we can use this data in our widgets.
//as the statenotifier is generic type so it doesnt know what type of data it yeild in the end so we use angled brackets to tell it
final favouritesMealsProvider =
    StateNotifierProvider<FavouriteMealsNotifier, List<Meal>>((ref) {
  return FavouriteMealsNotifier();
});
