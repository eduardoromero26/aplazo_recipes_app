import 'package:aplazo_recipes_app/routes/router_generator.dart';
import 'package:aplazo_recipes_app/core/dependency_injection.dart';
import 'package:aplazo_recipes_app/presentation/bloc/recipes_bloc.dart';
import 'package:aplazo_recipes_app/utils/styles/colors_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  setupDependencies();

  await dotenv.load(fileName: "assets/env/.env.dev");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<RecipesBloc>(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Aplazo Recipes App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: ColorsTheme.primaryColor,
          ),
        ),
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}
