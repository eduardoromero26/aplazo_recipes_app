import 'package:aplazo_recipes_app/domain/models/meal_model.dart';
import 'package:aplazo_recipes_app/presentation/widgets/meal_list_tile.dart';
import 'package:aplazo_recipes_app/routes/route_names.dart';
import 'package:flutter/material.dart';

class MealsSliverList extends StatelessWidget {
  final List<Meal>? meals;
  const MealsSliverList({super.key, this.meals});

  @override
  Widget build(BuildContext context) {
    return SliverSafeArea(
      bottom: true,
      minimum: const EdgeInsets.symmetric(vertical: 8.0),
      sliver: SliverList.builder(
        addAutomaticKeepAlives: true,
        itemCount: meals?.length ?? 0,
        itemBuilder: (BuildContext context, int index) {
          return MealListTile(
            meal: meals![index],
            onTap: () {
              Navigator.pushNamed(
                context,
                RouteNames.details,
                arguments: meals![index],
              );
            },
          );
        },
      ),
    );
  }
}
