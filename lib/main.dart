//we'll start by the category screen where we can select category and see all meals that belong to the category

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mealapp/screen/tabs.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final theme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: const Color.fromARGB(255, 131, 57, 0),
  ),
  textTheme: GoogleFonts.latoTextTheme(),
);

void main() {
  runApp(
    //providerScope is important to use to unlock the state management functionality in the end
    const ProviderScope(
      child: App(),
    ),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(theme: theme, home: const TabScreen());
  }
}
