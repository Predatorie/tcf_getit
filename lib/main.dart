import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tcf_getit/branding/branding.dart';
import 'package:tcf_getit/src/providers/affiliate_notifier.dart';
import 'package:tcf_getit/src/providers/athletes_notifier.dart';
import 'package:tcf_getit/src/providers/barbell_notifier.dart';
import 'package:tcf_getit/src/providers/benchmark_notifier.dart';
import 'package:tcf_getit/src/providers/wod_notifier.dart';
import 'package:tcf_getit/src/services/api_service.dart';
import 'package:tcf_getit/src/services/sugarwod_service.dart';
import 'package:tcf_getit/src/views/affiliate_page.dart';
import 'package:tcf_getit/src/views/athletes_page.dart';
import 'package:tcf_getit/src/views/barbells_page.dart';
import 'package:tcf_getit/src/views/benchmark_page.dart';
import 'package:tcf_getit/src/views/home_page.dart';
import 'package:tcf_getit/src/views/wod_page.dart';

void main() {
  // create our singleton api service;
  final SugarWodService sugarWod =
      SugarWodService(apiService: ApiService.create());
  runApp(
    /// Providers are above [MyApp] instead of inside it, so that tests
    /// can use [MyApp] while mocking the src.providers

    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => WodNotifier(sugarWod: sugarWod)),
        ChangeNotifierProvider(
            create: (_) => AthletesNotifier(sugarWod: sugarWod)),
        ChangeNotifierProvider(
            create: (_) => BarbellNotifier(sugarWod: sugarWod)),
        ChangeNotifierProvider(
            create: (_) => AffiliateNotifier(sugarWod: sugarWod)),
        ChangeNotifierProvider(
            create: (_) => BenchmarkNotifier(sugarWod: sugarWod)),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TCF',
      theme: ThemeData().copyWith(
          primaryColor: tollandCrossFitBlue,
          scaffoldBackgroundColor: Colors.white),
      routes: {
        '/': (context) => HomePage(),
        AthletesPage.routeName: (context) => AthletesPage(),
        WodPage.routeName: (context) => WodPage(),
        BenchmarkPage.routeName: (context) => BenchmarkPage(),
        BarbellsPage.routeName: (context) => BarbellsPage(),
        AffiliatePage.routeName: (context) => AffiliatePage(),
      },
    );
  }
}
