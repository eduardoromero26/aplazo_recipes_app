import 'package:aplazo_recipes_app/domain/models/meal_model.dart' show Meal;
import 'package:aplazo_recipes_app/presentation/widgets/lotties/empty_search_lottie_view.dart';
import 'package:aplazo_recipes_app/presentation/widgets/sliver_app_bar_meal.dart';
import 'package:aplazo_recipes_app/styles/text_styles.dart';
import 'package:flutter/material.dart';

class DetailsRecipeScreen extends StatelessWidget {
  final Meal selectedMeal;
  const DetailsRecipeScreen({super.key, required this.selectedMeal});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBarMeal(selectedMeal: selectedMeal),
            selectedMeal.strMeal.isNotEmpty
                ? SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20),
                          Text(
                            selectedMeal.strMeal,
                            style: TypographyTheme.fontSemi24Px,
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                selectedMeal.strCategory,
                                style: TypographyTheme.fontMedium20Px,
                              ),
                              Text(
                                selectedMeal.strArea,
                                style: TypographyTheme.fontMedium20Px,
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          const Divider(color: Colors.grey),
                          const SizedBox(height: 16),
                          const Text(
                            'Ingredients',
                            style: TypographyTheme.fontSemi20Px,
                          ),
                          const SizedBox(height: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: selectedMeal.ingredients
                                .asMap()
                                .entries
                                .map((entry) {
                                  int i = entry.key;
                                  String? ingredient = entry.value;
                                  String? measure =
                                      selectedMeal.measures.length > i
                                      ? selectedMeal.measures[i]
                                      : null;
                                  return (ingredient.isNotEmpty &&
                                          measure != null &&
                                          measure.isNotEmpty)
                                      ? Text(
                                          '$ingredient - $measure',
                                          style:
                                              TypographyTheme.fontRegular16Px,
                                        )
                                      : const SizedBox.shrink();
                                })
                                .toList(),
                          ),
                          const SizedBox(height: 12),
                          const Divider(color: Colors.grey),
                          const SizedBox(height: 16),
                          const Text(
                            'Instructions',
                            style: TypographyTheme.fontSemi20Px,
                          ),
                          const SizedBox(height: 8),
                          Wrap(
                            children: [
                              Text(
                                selectedMeal.strInstructions,
                                style: TypographyTheme.fontRegular16Px,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                : const EmptySearchLottieView(),
          ],
        ),
      ),
    );
  }
}
