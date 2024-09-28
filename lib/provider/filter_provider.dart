import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mealapp/provider/meals_provider.dart';

//unique identifiers for all the filters that we can set. these are the keys that would be returned in map.
enum Filter {
  glutenFree,
  lactoseFree,
  vegetarian,
  vegan,
}

class FiltersNotifier extends StateNotifier<Map<Filter, bool>> {
  FiltersNotifier()
      : super({
          Filter.glutenFree: false,
          Filter.lactoseFree: false,
          Filter.vegan: false,
          Filter.vegetarian: false,
        });

  void setFilter(Filter filter, bool isActive) {
    state = {
      ...state,
      filter: isActive,
    };
  }

  void setFilters(Map<Filter, bool> chosenFilters) {
    //getting a new map of filters over here which we would use to override the existing state.
    state = chosenFilters;
  }
}

final filtersProvider =
    StateNotifierProvider<FiltersNotifier, Map<Filter, bool>>(
  (ref) => FiltersNotifier(),
);

//creating a provider returning a list of filtered meals, this will be a simple provider because we wont be creating a class
final filteredMealProvider = Provider((ref) {
  final activeFilters = ref.watch(filtersProvider);
  final meals = ref.watch(mealsProvider);
  return meals.where((meal) {
    if (activeFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
      //returning false to exclude meals that are not gluten free
      return false;
    }
    if (activeFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
      return false;
    }
    if (activeFilters[Filter.vegetarian]! && !meal.isVegetarian) {
      return false;
    }
    if (activeFilters[Filter.vegan]! && !meal.isVegan) {
      return false;
    }
    //returning true to keep the meals that dont reach the (if-block).
    return true;
    //.toList to make sure we are actually returning a list and not an iterable.
  }).toList();
});
