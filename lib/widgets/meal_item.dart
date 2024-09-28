import 'package:flutter/material.dart';
import 'package:mealapp/models/meal.dart';
import 'package:mealapp/widgets/meal_item_trait.dart';
import 'package:transparent_image/transparent_image.dart';

class MealItem extends StatelessWidget {
  const MealItem({super.key, required this.meal, required this.onSelectmeal});

  final Meal meal;
  final void Function(Meal meal) onSelectmeal;

  String get complexityText {
//using the index[0] to access the first character. because in our dummy data the complexity is simple written with lowercase letter but we want the first letter of 'Simple' to be uppercase.
    return meal.complexity.name[0].toUpperCase() +
        //using the substring to cancatinate the uppercase letter with the other letters because without cancatinatng it will just return one word
        meal.complexity.name.substring(1);
  }

  String get affordabilityText {
    return meal.affordability.name[0].toUpperCase() +
        meal.affordability.name.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      //clipBehavior removes any child widget content in card that goes beyond the Rounder border radius.
      clipBehavior: Clip.hardEdge,
      //using elevation to give a little 3D effect to the image by throwing a little shadow behind.
      elevation: 2,
      child: InkWell(
        onTap: () {
          onSelectmeal(meal);
        },
// stack is a widget which is used to stack multiple widgets above each other. Not like a column but stack the widgets directly above eachother. example having image at the background and setting text at top of it.
        child: Stack(
          children: [
            //FadeInImage is utility widget which is used to fade in an image very smoothly that doesnt look ugly.
            // installed transparent_image package and using MemoryImage which is image provider class provided by flutter
            FadeInImage(
              placeholder: MemoryImage
                  //NetworkImage() is used to fetch image from the internet
                  (kTransparentImage),
              image: NetworkImage(meal.imageUrl),
              //fit is used to cut off the image instead of being distorted if it doesnt fit in the box.
              fit: BoxFit.cover,
              height: 200,
              width: double.infinity,
            ),
            //positioned widget is used allow us to use additional parameters to define how this child widget should be positioned on top of the image.
            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  color: Colors.black54,
                  padding:
                      const EdgeInsets.symmetric(vertical: 6, horizontal: 44),
                  child: Column(
                    children: [
                      Text(
                        meal.title, maxLines: 2, textAlign: TextAlign.center,
                        //softwrap is used to make sure that the text is wrapped in a good looking way
                        softWrap: true,
                        //overflow is used to show how our text should look like if it is cut off because of being too long as we have maxlines: 2.
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MealItemTrait(
                              icon: Icons.schedule,
                              //as the meal.duration is int therefore we injected its value through the '$'.
                              label: '${meal.duration} min'),
                          const SizedBox(
                            width: 12,
                          ),
                          MealItemTrait(
                              icon: Icons.work, label: complexityText),
                          const SizedBox(
                            width: 12,
                          ),
                          MealItemTrait(
                              icon: Icons.attach_money,
                              label: affordabilityText),
                        ],
                      )
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
