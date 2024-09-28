import 'package:flutter/material.dart';
import 'package:mealapp/screen/tabs.dart';
import 'package:mealapp/widgets/main_drawer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mealapp/provider/filter_provider.dart';

//stateful because we would be presenting multiple switches to the user that can be used by the user to set various filters.
class FiltersScreen extends ConsumerWidget {
  const FiltersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //watch sets up a listner that rexecutes the build method whenever the state in the provider changes.
    final activeFilters = ref.watch(filtersProvider);
    return Scaffold(
      //this drawer would be also shown in the filters screen where if we tap on the meals button it will take us to mealScreen.
      drawer: MainDrawer(
        onSelectScreen: (identifier) {
          Navigator.of(context).pop();
          if (identifier == 'meals') {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: ((context) => const TabScreen()),
              ),
            );
          }
        },
      ),
      appBar: AppBar(
        title: const Text('Your Filters'),
      ),
      //using PopScope to handle system's back navigation button.
      body: Column(
        children: [
          //it is a widget provided by flutter that is optimized for being presented in a list full of switches where we can set lable for every switch
          SwitchListTile(
            value: activeFilters[Filter.glutenFree]!,
            onChanged: (isChecked) {
              //using isChecked information to update glutenfreefilterset
              //using ref.read to call out the provider class and set the state.
              ref
                  .read(filtersProvider.notifier)
                  .setFilter(Filter.glutenFree, isChecked);
            },
            title: Text(
              'Gluten-free',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
            //using subtitle to render some typically smaller text below the main title.
            subtitle: Text(
              'Only include Gluten-free meals.',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
            //using this allows us to control which color will be used for rendering the switch, if it's activated.
            activeColor: Theme.of(context).colorScheme.tertiary,
            //to control how much padding would be used inside of this list tile in the end. '.only' targets specific directions of the padding
            contentPadding: const EdgeInsets.only(left: 34, right: 22),
          ),

          SwitchListTile(
            value: activeFilters[Filter.lactoseFree]!,
            onChanged: (isChecked) {
              //using isChecked information to update glutenfreefilterset
              //using ref.read to call out the provider class and set the state.
              ref
                  .read(filtersProvider.notifier)
                  .setFilter(Filter.lactoseFree, isChecked);
            },
            title: Text(
              'Lactose-free',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
            //using subtitle to render some typically smaller text below the main title.
            subtitle: Text(
              'Only include Lactose-free meals.',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
            //using this allows us to control which color will be used for rendering the switch, if it's activated.
            activeColor: Theme.of(context).colorScheme.tertiary,
            //to control how much padding would be used inside of this list tile in the end. '.only' targets specific directions of the padding
            contentPadding: const EdgeInsets.only(left: 34, right: 22),
          ),

          SwitchListTile(
            value: activeFilters[Filter.vegetarian]!,
            onChanged: (isChecked) {
              //using isChecked information to update glutenfreefilterset
              //using ref.read to call out the provider class and set the state.
              ref
                  .read(filtersProvider.notifier)
                  .setFilter(Filter.vegetarian, isChecked);
            },
            title: Text(
              'Vagetarian',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
            //using subtitle to render some typically smaller text below the main title.
            subtitle: Text(
              'Only include Vagetarian meals.',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
            //using this allows us to control which color will be used for rendering the switch, if it's activated.
            activeColor: Theme.of(context).colorScheme.tertiary,
            //to control how much padding would be used inside of this list tile in the end. '.only' targets specific directions of the padding
            contentPadding: const EdgeInsets.only(left: 34, right: 22),
          ),

          SwitchListTile(
            value: activeFilters[Filter.vegan]!,
            onChanged: (isChecked) {
              //using isChecked information to update glutenfreefilterset
              //using ref.read to call out the provider class and set the state.
              ref
                  .read(filtersProvider.notifier)
                  .setFilter(Filter.vegan, isChecked);
            },
            title: Text(
              'Vegan',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
            //using subtitle to render some typically smaller text below the main title.
            subtitle: Text(
              'Only include Vegan meals.',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
            //using this allows us to control which color will be used for rendering the switch, if it's activated.
            activeColor: Theme.of(context).colorScheme.tertiary,
            //to control how much padding would be used inside of this list tile in the end. '.only' targets specific directions of the padding
            contentPadding: const EdgeInsets.only(left: 34, right: 22),
          ),
        ],
      ),
    );
  }
}
