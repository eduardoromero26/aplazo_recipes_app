import 'package:aplazo_recipes_app/domain/models/meal_model.dart';
import 'package:aplazo_recipes_app/styles/text_styles.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class MealListTile extends StatelessWidget {
  final Meal meal;
  final Function()? onTap;
  const MealListTile({super.key, required this.meal, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.grey[200],
      ),
      margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: ListTile(
          contentPadding: const EdgeInsets.only(left: 8.0, right: 16.0),
          title: Text(meal.strMeal, style: TypographyTheme.fontSemi20Px),
          subtitle: Text(
            meal.strCategory,
            style: TypographyTheme.fontRegular16Px,
          ),
          leading: Hero(
            tag: meal.idMeal,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: CachedNetworkImage(
                imageUrl: meal.strMealThumb,
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
          ),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: onTap,
        ),
      ),
    );
  }
}
