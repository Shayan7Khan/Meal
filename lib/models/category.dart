import 'package:flutter/material.dart';

//not a widget but just a blueprint for a regular object.
class Category {
  const Category(
      {required this.id,
      required this.title,
      //if no color is provided this color would be used by default
      this.color = Colors.orange});

  final String id;
  final String title;
  final Color color;
}
