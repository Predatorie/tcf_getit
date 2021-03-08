import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tcf_getit/src/services/athletes_repository.dart';
import 'package:tcf_getit/src/views/athletes_page.dart';
import 'package:tcf_getit/styles/styles.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          color: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Image.asset(
                'assets/images/tcf_logo_small.png',
                alignment: Alignment.center,
                fit: BoxFit.cover,
                height: 256,
                width: 256,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 3,
                  mainAxisSpacing: 2,
                  crossAxisSpacing: 2,
                  padding: const EdgeInsets.all(8.0),
                  children: [
                    menuCard(
                        title: 'WOD',
                        subtitle: 'Today\'s',
                        func: () => print('wod')),
                    menuCard(
                        title: 'HEROES',
                        subtitle: 'Benchmark',
                        func: () => print('heroes')),
                    menuCard(
                        title: 'GIRLS',
                        subtitle: 'Benchmark',
                        func: () => print('girls')),
                    menuCard(
                        title: 'GAMES',
                        subtitle: 'Benchmark',
                        func: () => print('games')),
                    menuCard(
                        title: 'GYMNASTICS',
                        subtitle: 'Benchmark',
                        func: () => print('gymnastics')),
                    menuCard(
                        title: 'NOTABLES',
                        subtitle: 'Benchmark',
                        func: () => print('notables')),
                    menuCard(
                        title: 'BARBELLS',
                        subtitle: 'Benchmark',
                        func: () => print('barbells')),
                    menuCard(
                        title: 'AFFILIATE',
                        subtitle: 'Information',
                        func: () => print('box')),
                    menuCard(
                        title: 'ATHLETES',
                        subtitle: 'Information',
                        func: () async {
                          await Provider.of<AthletesRepository>(context,
                                  listen: false)
                              .getAthletesAsync();

                          if (Provider.of<AthletesRepository>(context,
                                  listen: false)
                              .hasNextPage) {
                            await Navigator.pushNamed(
                                context, AthletesPage.routeName);
                          }
                        }),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.min,
                children: [
                  iconWidgetButton(
                      icon: FontAwesomeIcons.twitterSquare,
                      size: 38,
                      func: () => print('https://twitter.com/TollandCrossFit')),
                  iconWidgetButton(
                      icon: FontAwesomeIcons.facebookSquare,
                      size: 38,
                      func: () =>
                          print('https://www.facebook.com/tollandcrossfit/')),
                  iconWidgetButton(
                      icon: FontAwesomeIcons.instagramSquare,
                      size: 38,
                      func: () =>
                          print('https://www.instagram.com/TollandCrossFit/')),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
