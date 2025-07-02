import 'package:aplazo_recipes_app/domain/models/meal_model.dart';
import 'package:aplazo_recipes_app/presentation/screens/details_recipe_screen.dart';
import 'package:aplazo_recipes_app/presentation/screens/home_screen.dart';
import 'package:aplazo_recipes_app/routes/route_names.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case RouteNames.details:
        final args = settings.arguments as Meal;
        return MaterialPageRoute(
          builder: (_) => DetailsRecipeScreen(selectedMeal: args),
        );
      default:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
    }
  }
}
