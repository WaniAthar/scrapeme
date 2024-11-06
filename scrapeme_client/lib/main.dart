import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:scrapeme/routes/routes.dart';
import 'constants/constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:toastification/toastification.dart';

void main() async {
  setUrlStrategy(PathUrlStrategy());
  WidgetsFlutterBinding.ensureInitialized();
  await initialisations();
  runApp(const ProviderScope(child: ToastificationWrapper(child: ScrapeApp())));
}

Future<void> initialisations() async {
  await Hive.initFlutter();
  await Hive.openBox('cacheBox');
  // await Hive.openBox('userBox');
}

class ScrapeApp extends StatelessWidget {
  const ScrapeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Scrape App',
      initialRoute: Routes.splash,
      routes: Routes.routes,
      onGenerateRoute: Routes.generateRoute,
      theme: ThemeData(
        pageTransitionsTheme: const PageTransitionsTheme(builders: {
          TargetPlatform.windows: CupertinoPageTransitionsBuilder(),
          TargetPlatform.linux: CupertinoPageTransitionsBuilder()
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
