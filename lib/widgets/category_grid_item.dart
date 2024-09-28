import 'package:mealapp/models/category.dart';
import 'package:flutter/material.dart';

class CategoryGridItem extends StatelessWidget {
  const CategoryGridItem(
      {super.key, required this.category, required this.onSelectCategory});

//to accept some external data to be outputted on the screen
  final Category category;
  final void Function() onSelectCategory;

  @override
  Widget build(BuildContext context) {
    //InkWell makes the card tapable. We can also use the GestureDetector to make the card tapable but with the Inkwell we also get a nice looking feedback
    return InkWell(
      //setting up a function to be triggered when the card is tapped.
      onTap: onSelectCategory,
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [
              category.color.withOpacity(
                0.55,
              ),
              category.color.withOpacity(0.9),
            ],
            //defining where it should being and end
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Text(
          category.title,
          //using '!' to tell dart that the titlelarge text theme will be defined.
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: Theme.of(context).colorScheme.onBackground),
        ),
      ),
    );
  }
}
