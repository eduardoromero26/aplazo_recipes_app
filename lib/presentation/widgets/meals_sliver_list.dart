import 'package:aplazo_recipes_app/domain/models/meal_model.dart';
import 'package:aplazo_recipes_app/routes/route_names.dart';
import 'package:aplazo_recipes_app/styles/text_styles.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class MealsSliverList extends StatelessWidget {
  final List<Meal>? meals;
  const MealsSliverList({super.key, this.meals});

  @override
  Widget build(BuildContext context) {
    return SliverSafeArea(
      bottom: true,
      minimum: const EdgeInsets.only(bottom: 16.0),
      sliver: SliverList.builder(
        addAutomaticKeepAlives: true,
        itemCount: meals?.length ?? 0,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.grey[200],
            ),
            margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: ListTile(
                contentPadding: const EdgeInsets.only(left: 8.0, right: 16.0),
                title: Text(
                  meals![index].strMeal,
                  style: TypographyTheme.fontSemi20Px,
                ),
                subtitle: Text(
                  meals![index].strCategory,
                  style: TypographyTheme.fontRegular16Px,
                ),
                leading: Hero(
                  tag: meals![index].idMeal,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: CachedNetworkImage(
                      imageUrl: meals![index].strMealThumb,
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                ),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    RouteNames.details,
                    arguments: meals![index],
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
