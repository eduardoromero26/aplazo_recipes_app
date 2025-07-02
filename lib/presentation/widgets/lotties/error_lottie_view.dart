import 'package:aplazo_recipes_app/presentation/bloc/recipes_bloc.dart';
import 'package:aplazo_recipes_app/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class ErrorLottieView extends StatelessWidget {
  const ErrorLottieView({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Lottie.asset(
            'assets/lotties/error_lottie.json',
            width: MediaQuery.of(context).size.width * 0.36,
          ),
          const SizedBox(height: 40),
          const Text(
            'Error during the network request',
            style: TypographyTheme.fontSemi20Px,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              context.read<RecipesBloc>().add(
                SearchMealByNameEvent(
                  name: context.read<RecipesBloc>().searchFieldController.text,
                ),
              );
            },
            child: const Text('Try again', style: TypographyTheme.fontSemi20Px),
          ),
        ],
      ),
    );
  }
}
