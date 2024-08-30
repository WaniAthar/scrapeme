import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scrapeme/routes/routes.dart';
import 'constants/constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: ScrapeApp()));
}



class ScrapeApp extends StatelessWidget {
  const ScrapeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Scrape App',
      initialRoute: Routes.login,
      routes: Routes.routes,
      onGenerateRoute: Routes.generateRoute,
      theme: ThemeData(
        pageTransitionsTheme: const PageTransitionsTheme(builders: {
          TargetPlatform.windows: CupertinoPageTransitionsBuilder()
        }),
        primaryColor: Colours.primaryColor,
        colorScheme: ColorScheme.fromSeed(seedColor: Colours.primaryColor),
        appBarTheme: AppBarTheme(
          iconTheme: const IconThemeData(
            color: Colours.primaryColor,
          ),
          titleTextStyle: GoogleFonts.poppins(
            fontSize: 26.0,
            color: Colours.textColor,
            fontWeight: FontWeight.w600,
          ),
          backgroundColor: Colours.backgroundColor,
          foregroundColor: Colours.textColor,
        ),
      ),
    );
  }
}
