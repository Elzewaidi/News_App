import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'model/article_repository.dart';
import 'cubit/bookmark_cubit.dart';
import 'cubit/article_cubit.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => ArticleRepository()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => BookmarkCubit(
              repository: context.read<ArticleRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => ArticleCubit(
              repository: context.read<ArticleRepository>(),
            ),
          ),
        ],
        child: MaterialApp(
          title: 'News App',
          theme: ThemeData(
            primaryColor: const Color(0xFF2E5BCC),
            fontFamily: 'Inter', // Assuming standard clean generic modern sans-serif
          ),
          debugShowCheckedModeBanner: false,
          home: const SplashScreen(),
        ),
      ),
    );
  }
}
