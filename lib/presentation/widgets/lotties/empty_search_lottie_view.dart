import 'package:aplazo_recipes_app/presentation/bloc/recipes_bloc.dart';
import 'package:aplazo_recipes_app/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class EmptySearchLottieView extends StatelessWidget {
  const EmptySearchLottieView({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Lottie.asset(
            'assets/lotties/not_found_lottie.json',
            width: MediaQuery.of(context).size.width * 0.5,
          ),
          const SizedBox(height: 40),
          Text(
            'Not meals founded: ${context.read<RecipesBloc>().searchFieldController.text}',
            style: TypographyTheme.fontSemi20Px,
          ),
        ],
      ),
    );
  }
}
