import 'package:aplazo_recipes_app/utils/styles/text_styles.dart';
import 'package:flutter/material.dart';

import 'package:lottie/lottie.dart';

class LottieWidget extends StatelessWidget {
  final String? message;
  final String? lottiePath;
  const LottieWidget({super.key, this.message, this.lottiePath});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Lottie.asset(
          lottiePath ?? 'assets/lotties/progress_lottie.json',
          width: MediaQuery.of(context).size.width * 0.5,
        ),
        Text(
          message ?? 'Loading meals...',
          style: TypographyTheme.fontSemi20Px,
        ),
      ],
    );
  }
}

class ErrorLottieView extends StatelessWidget {
  const ErrorLottieView({super.key});

  @override
  Widget build(BuildContext context) {
    return LottieWidget(
      lottiePath: 'assets/lotties/error_lottie.json',
      message: 'Error loading meals',
    );
  }
}

class LoadingLottieView extends StatelessWidget {
  const LoadingLottieView({super.key});

  @override
  Widget build(BuildContext context) {
    return LottieWidget(
      lottiePath: 'assets/lotties/loading_lottie.json',
      message: 'Loading meals...',
    );
  }
}

class EmptySearchLottieView extends StatelessWidget {
  const EmptySearchLottieView({super.key});

  @override
  Widget build(BuildContext context) {
    return LottieWidget(
      lottiePath: 'assets/lotties/empty_search_lottie.json',
      message: 'No meals found',
    );
  }
}
