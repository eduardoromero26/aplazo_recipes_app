import 'package:aplazo_recipes_app/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadingLottieView extends StatelessWidget {
  final String? message;
  const LoadingLottieView({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Lottie.asset(
            'assets/lotties/progress_lottie.json',
            width: MediaQuery.of(context).size.width * 0.5,
          ),
          Text(
            message ?? 'Loading meals...',
            style: TypographyTheme.fontSemi20Px,
          ),
        ],
      ),
    );
  }
}
