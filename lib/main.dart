import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'branding/branding.dart';
import 'src/providers/affiliate_notifier.dart';
import 'src/providers/athletes_notifier.dart';
import 'src/providers/barbell_notifier.dart';
import 'src/providers/benchmark_notifier.dart';
import 'src/providers/wod_notifier.dart';
import 'src/services/api_service.dart';
import 'src/services/sugarwod_service.dart';
import 'src/views/affiliate_page.dart';
import 'src/views/athletes_page.dart';
import 'src/views/barbells_page.dart';
import 'src/views/benchmark_page.dart';
import 'src/views/home_page.dart';
import 'src/views/wod_page.dart';

void main() {
  // create our singleton api service;
  final sugarWod = SugarWodService(apiService: ApiService.create());
  runApp(
    /// Providers are above [MyApp] instead of inside it, so that tests
    /// can use [MyApp] while mocking the src.providers
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => WodNotifier(sugarWod: sugarWod)),
        ChangeNotifierProvider(
          create: (_) => AthletesNotifier(sugarWod: sugarWod),
        ),
        ChangeNotifierProvider(
          create: (_) => BarbellNotifier(sugarWod: sugarWod),
        ),
        ChangeNotifierProvider(
          create: (_) => AffiliateNotifier(sugarWod: sugarWod),
        ),
        ChangeNotifierProvider(
          create: (_) => BenchmarkNotifier(sugarWod: sugarWod),
        ),
      ],
      child: const MyApp(key: Key('app_key')),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({required Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TCF',
      theme: ThemeData().copyWith(
        primaryColor: tollandCrossFitBlue,
        scaffoldBackgroundColor: Colors.white,
      ),
      routes: {
        '/': (context) => const HomePage(),
        AthletesPage.routeName: (context) => const AthletesPage(),
        WodPage.routeName: (context) => const WodPage(),
        BenchmarkPage.routeName:
            (context) => const BenchmarkPage(key: Key('benchmark_page_key')),
        BarbellsPage.routeName:
            (context) => const BarbellsPage(key: Key('barbells_page_key')),
        AffiliatePage.routeName:
            (context) => const AffiliatePage(key: Key('affiliate_page_key')),
      },
    );
  }
}
