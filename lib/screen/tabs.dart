import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mealapp/screen/categories.dart';
import 'package:mealapp/screen/filters.dart';
import 'package:mealapp/screen/meals.dart';
import 'package:mealapp/widgets/main_drawer.dart';
import 'package:mealapp/provider/favourites_provider.dart';
import 'package:mealapp/provider/filter_provider.dart';

//global variable holding values
const kInitialFilters = {
  //the filters would be initially false but would be updated once some filters have been set.
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetarian: false,
  Filter.vegan: false,
};

//a stateful widget provided by the riverpod package which has some added functionalitites that allow us to listen to our providers and to changes in those provider values
class TabScreen extends ConsumerStatefulWidget {
  const TabScreen({super.key});

  @override
  ConsumerState<TabScreen> createState() {
    return _TabScreenState();
  }
}

class _TabScreenState extends ConsumerState<TabScreen> {
  int _selectPageIndex = 0;

  //this variable will store the selected filter and would be of type Map

// //this function should either add a meal or remove a meal from favourites. one function that acts both
//   void _toggleMealFavouriteStatus(Meal meal) {
//     //to check if the meal we are getting in the parametre is contained in the list.
//     final isExisting = _favouriteMeals.contains(meal);

//     //condition to check if the meal exits remove it, if it doesnt exist add it.
//     if (isExisting) {
//       setState(() {
//         _favouriteMeals.remove(meal);
//         _showInfoMessage('Meal is no longer a favourite.');
//       });
//     } else {
//       setState(() {
//         _favouriteMeals.add(meal);
//         _showInfoMessage('Marked as favourite.');
//       });
//     }
//   }

//when the bottomNavigationbar tab is clicked then it will send an index here will it will update the page index based on index it recieves.
  void _selectPage(int index) {
    setState(() {
      _selectPageIndex = index;
    });
  }

//this function will be passed MainDrawer.
//we'll be adding an if condition to check if the identifier == filters that load the filters screen otherwise the tabs screen from where the mealscreen would be displayed.
//using async here for the future value because the data wouldnt be able immediatly but when the user goes back.
  void _setScreen(String identifier) async {
    {
      //despite of any condition the drawer should be closed.
      Navigator.of(context).pop();
      if (identifier == 'filters') {
        await Navigator.of(context)
            //pushReplacement is also used to replace the current active screen with the screen we are pushing and not to push it over the stack of screens.
            .push<Map<Filter, bool>>(
          MaterialPageRoute(
            builder: (ctx) => const FiltersScreen(),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    //ref property allows us to set up listeners to our providers
    //filteredMealProvider returns list of meals
    final availableMeals = ref.watch(filteredMealProvider);

    Widget activeScreen = CategoriesScreen(
      availableMeals: availableMeals,
    );
    var activeScreentitle = 'Categories';

    if (_selectPageIndex == 1) {
      final favouriteMeals = ref.watch(favouritesMealsProvider);
      activeScreen = MealsScreen(
        meals: favouriteMeals,
      );
      activeScreentitle = 'Your Favourites';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activeScreentitle),
      ),
      //we need to show the filtered items as drawer on both tabs therefore we use the drawer in tabs scaffold.
      drawer: MainDrawer(
        onSelectScreen: _setScreen,
      ),
      //body should be set dynamically based on which tab was pressed.
      body: activeScreen,
      //this is used for the navigation bar at the bottom of the app
      bottomNavigationBar: BottomNavigationBar(
        //onTap would recieve the index of the tab that was tabbed
        onTap: _selectPage,
        //this will simply control which tab would highlighted
        currentIndex: _selectPageIndex,
        //list of tabs
        items: const [
          //with this tab the user will go to the categories screen
          BottomNavigationBarItem(
              icon: Icon(Icons.set_meal), label: 'Categories'),
          //with this tab the user will go to the favourites screen
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favourites'),
        ],
      ),
    );
  }
}
