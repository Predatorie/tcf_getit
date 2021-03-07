import 'package:flutter/material.dart';
import 'package:tcf_getit/src/locator/locator.dart';
import 'package:tcf_getit/src/services/athletes_repository.dart';
import 'package:tcf_getit/src/views/athletes_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // locate the api manager
    final apiManager = serviceLocator<AthletesRepository>();

    return Scaffold(
      appBar: AppBar(
        title: Text('TOLLAND CROSSFIT'),
        centerTitle: true,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: Center(
            child: ElevatedButton(
                child: Text('Get Athletes'),
                onPressed: () async {
                  await apiManager.getAthletesAsync();

                  if (apiManager.errorMessage.isNotEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(apiManager.errorMessage)));
                  } else {
                    await Navigator.pushNamed(context, AthletesPage.routeName);
                  }
                })),
      ),
    );
  }
}
