import 'package:flutter/material.dart';

//we need to show the filtered items as drawer on both tabs therefore we use the drawer in tabs scaffold.
class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key, required this.onSelectScreen});

//we need this function to communicate with the tabs screen and just filter the items that were selected
  final void Function(String identifier) onSelectScreen;

  @override
  Widget build(BuildContext context) {
    //drawer is a widget that is already optimized to be presented as a drawer.
    return Drawer(
      //Column because we have multiple items in the drawer above eachother
      child: Column(
        children: [
          //using DrawerHeader to show some header inside of the drawer at the top
          DrawerHeader(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  //starting color
                  Theme.of(context).colorScheme.primaryContainer,
                  //ending color with slight opacity to show transparency
                  Theme.of(context)
                      .colorScheme
                      .primaryContainer
                      .withOpacity(0.8),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            //using Row because we want multiple items next to eachother inside of that DrawerHeader.
            child: Row(
              children: [
                Icon(
                  Icons.fastfood,
                  size: 48,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(
                  width: 18,
                ),
                Text(
                  'Cooking up!',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: Theme.of(context).colorScheme.primary),
                ),
              ],
            ),
          ),
          //Adding the links of the different screens that we wanna support in this app. Below the widget is not exlusive to the drawer but we can use in any list that we might be outputting. It is optimized for bundling different pieces of information together in a single row. (Displayed at the start of the row)
          ListTile(
            //Listile also gives as a 'leading' widget which allows us to set a widget that will be presented at the beginning of this row of this list item, so that the title comes after the leading widget.
            leading: Icon(
              Icons.restaurant,
              size: 26,
              color: Theme.of(context).colorScheme.onBackground,
            ),
            title: Text(
              'Meals',
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                    fontSize: 24,
                  ),
            ),
            //will navigate to a different screen when tapped
            onTap: () {
              onSelectScreen('meals');
            },
          ),

          ListTile(
            leading: Icon(
              Icons.settings,
              size: 26,
              color: Theme.of(context).colorScheme.onBackground,
            ),
            title: Text(
              'Filters',
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                    fontSize: 24,
                  ),
            ),
            onTap: () {
              onSelectScreen('filters');
            },
          ),
        ],
      ),
    );
  }
}
