import 'package:aplazo_recipes_app/domain/models/meal_model.dart';
import 'package:aplazo_recipes_app/presentation/bloc/recipes_bloc.dart';
import 'package:aplazo_recipes_app/presentation/widgets/layout_widget.dart';
import 'package:aplazo_recipes_app/presentation/widgets/lotties/empty_search_lottie_view.dart';
import 'package:aplazo_recipes_app/presentation/widgets/lotties/error_lottie_view.dart';
import 'package:aplazo_recipes_app/presentation/widgets/lotties/loading_lottie_view.dart';
import 'package:aplazo_recipes_app/presentation/widgets/meal_list_tile.dart';
import 'package:aplazo_recipes_app/routes/route_names.dart';
import 'package:aplazo_recipes_app/styles/colors_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteMealsScreen extends StatefulWidget {
  const FavoriteMealsScreen({super.key});

  @override
  State<FavoriteMealsScreen> createState() => _FavoriteMealsScreenState();
}

class _FavoriteMealsScreenState extends State<FavoriteMealsScreen> {
  List<Meal> favoriteMeals = [];

  @override
  void initState() {
    super.initState();
    _updateFavorites();
  }

  void _updateFavorites() {
    final bloc = context.read<RecipesBloc>();
    setState(() {
      favoriteMeals = List.from(bloc.favoriteMeals);
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _updateFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutWidget(
      currentIndex: 1,
      child: BlocConsumer<RecipesBloc, RecipesState>(
        listener: (BuildContext context, RecipesState state) {
          // Actualizar la lista local cuando el estado cambie
          if (state.runtimeType.toString().contains('LoadedSuccess') ||
              state.runtimeType.toString().contains('FavoritesUpdated')) {
            final dynamic loadedState = state;
            final favorites = loadedState.favorites as List<Meal>?;
            if (favorites != null) {
              setState(() {
                favoriteMeals = List.from(favorites);
              });
            }
          }
        },
        builder: (context, state) {
          return CustomScrollView(
            slivers: <Widget>[
              // Hero Header estético
              _HeroHeader(),
              switch (state) {
                RecipesState() when state == const RecipesState.initial() =>
                  const SliverToBoxAdapter(
                    child: Center(
                      child: Text(
                        'Load your favorite recipes!',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                RecipesState()
                    when state == const RecipesState.loadingStarted() =>
                  LoadingLottieView(message: 'Loading favorite meals...'),
                RecipesState()
                    when state.runtimeType.toString().contains(
                      'LoadedSuccess',
                    ) =>
                  () {
                    if (favoriteMeals.isNotEmpty) {
                      return _Content(
                        meals: favoriteMeals,
                        onMealTap: (meal) async {
                          // Navegar y esperar a que regrese
                          await Navigator.pushNamed(
                            context,
                            RouteNames.details,
                            arguments: meal,
                          );
                          // Recargar favoritos cuando regrese
                          _updateFavorites();
                        },
                      );
                    } else {
                      return const EmptySearchLottieView();
                    }
                  }(),
                RecipesState()
                    when state.runtimeType.toString().contains(
                      'LoadedFailed',
                    ) =>
                  const SliverToBoxAdapter(child: ErrorLottieView()),
                _ => const SliverToBoxAdapter(child: SizedBox.shrink()),
              },
            ],
          );
        },
      ),
    );
  }
}

class _Content extends StatelessWidget {
  final List<Meal>? meals;
  final Function(Meal)? onMealTap;

  const _Content({this.meals, this.onMealTap});

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
            onTap: () async {
              if (onMealTap != null) {
                await onMealTap!(meals![index]);
              } else {
                // Navegación por defecto
                Navigator.pushNamed(
                  context,
                  RouteNames.details,
                  arguments: meals![index],
                );
              }
            },
          );
        },
      ),
    );
  }
}

class _HeroHeader extends StatelessWidget {
  const _HeroHeader();

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        height: 140,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              ColorsTheme.primaryColor,
              ColorsTheme.primaryColor.withOpacity(0.8),
              ColorsTheme.secondaryColor,
            ],
          ),
        ),
        child: Stack(
          children: [
            // Patrón decorativo de fondo
            Positioned.fill(child: CustomPaint(painter: _PatternPainter())),
            // Contenido principal
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'My Favorite Recipes',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          offset: Offset(0, 2),
                          blurRadius: 4,
                          color: Colors.black26,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Subtítulo
                  const Text(
                    'Discover your saved culinary treasures',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.05)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    // Dibujar círculos decorativos
    for (int i = 0; i < 5; i++) {
      final radius = (i + 1) * 20.0;
      canvas.drawCircle(
        Offset(size.width * 0.8, size.height * 0.3),
        radius,
        paint,
      );
    }

    // Dibujar líneas decorativas
    for (int i = 0; i < 8; i++) {
      final y = (i * 25.0);
      canvas.drawLine(
        Offset(size.width * 0.1, y),
        Offset(size.width * 0.3, y + 20),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
