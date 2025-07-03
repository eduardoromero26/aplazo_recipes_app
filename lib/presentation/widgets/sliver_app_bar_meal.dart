import 'package:aplazo_recipes_app/domain/models/meal_model.dart';
import 'package:aplazo_recipes_app/presentation/bloc/recipes_bloc.dart';
import 'package:aplazo_recipes_app/utils/styles/colors_theme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SliverAppBarMeal extends StatefulWidget {
  final Meal selectedMeal;

  const SliverAppBarMeal({super.key, required this.selectedMeal});

  @override
  State<SliverAppBarMeal> createState() => _SliverAppBarMealState();
}

class _SliverAppBarMealState extends State<SliverAppBarMeal> {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: ColorsTheme.primaryColor,
      pinned: true,

      leading: IconButton(
        style: ButtonStyle(
          foregroundColor: WidgetStateProperty.all(Colors.white),
          backgroundColor: WidgetStateProperty.all(ColorsTheme.primaryColor),
        ),
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      actions: [
        BlocBuilder<RecipesBloc, RecipesState>(
          builder: (context, state) {
            final isFavorite = context.watch<RecipesBloc>().isMealFavorite(
              widget.selectedMeal.idMeal,
            );

            return IconButton(
              style: ButtonStyle(
                foregroundColor: WidgetStateProperty.all(Colors.white),
                backgroundColor: WidgetStateProperty.all(
                  ColorsTheme.primaryColor,
                ),
              ),
              icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
              onPressed: () {
                context.read<RecipesBloc>().add(
                  ToggleFavoriteMealEvent(meal: widget.selectedMeal),
                );
                setState(() {});
              },
            );
          },
        ),
      ],
      expandedHeight: MediaQuery.of(context).size.height * 0.32,
      floating: true,
      flexibleSpace: FlexibleSpaceBar(
        background: Hero(
          tag: widget.selectedMeal.idMeal,
          child: CachedNetworkImage(
            imageUrl: widget.selectedMeal.strMealThumb,
            fit: BoxFit.cover,
            placeholder: (context, url) => const SizedBox(
              height: 40,
              width: 40,
              child: CircularProgressIndicator(),
            ),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ),
      ),
    );
  }
}
