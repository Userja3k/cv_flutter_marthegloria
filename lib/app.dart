import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'pages/login_page.dart';
import 'theme/app_colors.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CV Mathe-Gloria',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.background,
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
            .apply(
              bodyColor: AppColors.textPrimary,
              displayColor: AppColors.textPrimary,
            ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          surface: AppColors.background,
        ),
        useMaterial3: true,
      ),
      home: const LoginPage(),
    );
  }
}
