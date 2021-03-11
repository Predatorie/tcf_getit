import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tcf_getit/branding/branding.dart';
import 'package:tcf_getit/src/providers/athletes_provider.dart';
import 'package:tcf_getit/src/providers/heroes_service.dart';
import 'package:tcf_getit/src/providers/wod_provider.dart';
import 'package:tcf_getit/src/services/api_service.dart';
import 'package:tcf_getit/src/views/athletes_page.dart';
import 'package:tcf_getit/src/views/heroes_page.dart';
import 'package:tcf_getit/src/views/home_page.dart';
import 'package:tcf_getit/src/views/wod_page.dart';

void main() {
  // create our singleton api service;
  final ApiService apiService = ApiService.create();
  runApp(
    /// Providers are above [MyApp] instead of inside it, so that tests
    /// can use [MyApp] while mocking the src.providers

    MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => WodService(apiService: apiService)),
        ChangeNotifierProvider(
            create: (_) => AthletesService(apiService: apiService)),
        ChangeNotifierProvider(
            create: (_) => HeroesService(apiService: apiService)),
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
        HeroesPage.routeName: (context) => HeroesPage(),
      },
    );
  }
}
