import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tcf_getit/branding/branding.dart';
import 'package:tcf_getit/src/locator/locator.dart';
import 'package:tcf_getit/src/services/athletes_repository.dart';
import 'package:tcf_getit/src/views/athletes_page.dart';
import 'package:tcf_getit/src/views/home_page.dart';

void main() {
  registerTypes();

  runApp(
    /// Providers are above [MyApp] instead of inside it, so that tests
    /// can use [MyApp] while mocking the providers
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => serviceLocator<AthletesRepository>()),
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
      ),
      routes: {
        '/': (context) => HomePage(),
        AthletesPage.routeName: (context) => AthletesPage()
      },
    );
  }
}
