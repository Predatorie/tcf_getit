import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../styles/styles.dart';
import '../providers/affiliate_notifier.dart';
import '../providers/athletes_notifier.dart';
import '../providers/barbell_notifier.dart';
import '../providers/benchmark_notifier.dart';
import '../providers/wod_notifier.dart';
import 'affiliate_page.dart';
import 'athletes_page.dart';
import 'barbells_page.dart';
import 'benchmark_page.dart';
import 'wod_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            alignment: Alignment.center,
            color: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.min,
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
                  child: SizedBox(
                    height: 320,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              height: menuCardHeight,
                              width: menuCardWidth,
                              child: Consumer<WodNotifier>(
                                builder: (context, service, _) {
                                  return MenuCard(
                                      key: const Key('wodKey'),
                                      title: 'WOD',
                                      subtitle: 'Today\'s',
                                      func: () async {
                                        /// ignore repeated presses
                                        if (!service.isBusy) {
                                          /// get the wod of the day
                                          await service
                                              .getWorkOutOfTheDayByDateAsync(
                                                  DateTime.now());

                                          /// check for any errors
                                          if (service.hasError) {
                                            /// show a snack bar
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                              content:
                                                  Text(service.errorMessage),
                                            ));
                                          } else {
                                            /// navigate to the wod page
                                            await Navigator.pushNamed(
                                                context, WodPage.routeName);
                                          }
                                        }
                                      });
                                },
                              ),
                            ),
                            SizedBox(
                              height: menuCardHeight,
                              width: menuCardWidth,
                              child: Consumer<BenchmarkNotifier>(
                                builder: (context, service, child) {
                                  return MenuCard(
                                      key: const Key('heroesKey'),
                                      title: 'HEROES',
                                      subtitle: 'Benchmark',
                                      func: () async {
                                        /// ignore repeated presses
                                        if (!service.isBusy) {
                                          /// get the wod of the day
                                          await service
                                              .getBenchmarkByCategoryAsync(
                                                  'heroes');

                                          /// check for any errors
                                          if (service.hasError) {
                                            /// show a snack bar
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                              content:
                                                  Text(service.errorMessage),
                                            ));
                                          } else {
                                            /// navigate to the wod page
                                            await Navigator.pushNamed(context,
                                                BenchmarkPage.routeName);
                                          }
                                        }
                                      });
                                },
                              ),
                            ),
                            SizedBox(
                              height: menuCardHeight,
                              width: menuCardWidth,
                              child: Consumer<BenchmarkNotifier>(
                                builder: (context, service, child) {
                                  return MenuCard(
                                      key: const Key('girlsKey'),
                                      title: 'GIRLS',
                                      subtitle: 'Benchmark',
                                      func: () async {
                                        /// ignore repeated presses
                                        if (!service.isBusy) {
                                          /// get the wod of the day
                                          await service
                                              .getBenchmarkByCategoryAsync(
                                                  'girls');

                                          /// check for any errors
                                          if (service.hasError) {
                                            /// show a snack bar
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                              content:
                                                  Text(service.errorMessage),
                                            ));
                                          } else {
                                            /// navigate to the wod page
                                            await Navigator.pushNamed(context,
                                                BenchmarkPage.routeName);
                                          }
                                        }
                                      });
                                },
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              height: menuCardHeight,
                              width: menuCardWidth,
                              child: Consumer<BenchmarkNotifier>(
                                builder: (context, service, child) {
                                  return MenuCard(
                                    title: 'GAMES',
                                    subtitle: 'Benchmark',
                                    func: () async {
                                      // ignore repeated presses
                                      if (!service.isBusy) {
                                        /// get the first page of athletes
                                        await service
                                            .getBenchmarkByCategoryAsync(
                                                'games');

                                        /// check for errors
                                        if (service.hasError) {
                                          /// show a snack bar
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                            content: Text(service.errorMessage),
                                          ));
                                        } else {
                                          /// navigate to the athletes page
                                          if (service.hasNextPage) {
                                            await Navigator.pushNamed(context,
                                                BenchmarkPage.routeName);
                                          }
                                        }
                                      }
                                    },
                                    key: const Key('games_key'),
                                  );
                                },
                              ),
                            ),
                            SizedBox(
                              height: menuCardHeight,
                              width: menuCardWidth,
                              child: Consumer<BenchmarkNotifier>(
                                builder: (context, service, child) {
                                  return MenuCard(
                                    title: 'GYMNASTICS',
                                    subtitle: 'Benchmark',
                                    func: () async {
                                      // ignore repeated presses
                                      if (!service.isBusy) {
                                        /// get the first page of athletes
                                        await service
                                            .getBenchmarkByCategoryAsync(
                                                'gymnastics');

                                        /// check for errors
                                        if (service.hasError) {
                                          /// show a snack bar
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                            content: Text(service.errorMessage),
                                          ));
                                        } else {
                                          /// navigate to the athletes page
                                          if (service.hasNextPage) {
                                            await Navigator.pushNamed(context,
                                                BenchmarkPage.routeName);
                                          }
                                        }
                                      }
                                    },
                                    key: const Key('gymnastics_key'),
                                  );
                                },
                              ),
                            ),
                            SizedBox(
                              height: menuCardHeight,
                              width: menuCardWidth,
                              child: Consumer<BenchmarkNotifier>(
                                builder: (context, service, child) {
                                  return MenuCard(
                                    title: 'NOTABLES',
                                    subtitle: 'Benchmark',
                                    func: () async {
                                      // ignore repeated presses
                                      if (!service.isBusy) {
                                        /// get the first page of athletes
                                        await service
                                            .getBenchmarkByCategoryAsync(
                                                'notables');

                                        /// check for errors
                                        if (service.hasError) {
                                          /// show a snack bar
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                            content: Text(service.errorMessage),
                                          ));
                                        } else {
                                          /// navigate to the athletes page
                                          if (service.hasNextPage) {
                                            await Navigator.pushNamed(context,
                                                BenchmarkPage.routeName);
                                          }
                                        }
                                      }
                                    },
                                    key: const Key('notables_key'),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              height: menuCardHeight,
                              width: menuCardWidth,
                              child: Consumer<AffiliateNotifier>(
                                builder: (context, service, child) {
                                  return MenuCard(
                                    title: 'BOX',
                                    subtitle: 'Information',
                                    func: () async {
                                      // ignore repeated presses
                                      if (!service.isBusy) {
                                        await service.getAffiliateAsync();

                                        /// check for errors
                                        if (service.hasError) {
                                          /// show a snack bar
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                            content: Text(service.errorMessage),
                                          ));
                                        } else {
                                          await Navigator.pushNamed(
                                              context, AffiliatePage.routeName);
                                        }
                                      }
                                    },
                                    key: const Key('box_key'),
                                  );
                                },
                              ),
                            ),
                            SizedBox(
                              height: menuCardHeight,
                              width: menuCardWidth,
                              child: Consumer<BarbellNotifier>(
                                builder: (context, service, child) {
                                  return MenuCard(
                                    title: 'BARBELLS',
                                    subtitle: 'Information',
                                    func: () async {
                                      // ignore repeated presses
                                      if (!service.isBusy) {
                                        /// get the first page of athletes
                                        await service.getBarbellsAsync();

                                        /// check for errors
                                        if (service.hasError) {
                                          /// show a snack bar
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                            content: Text(service.errorMessage),
                                          ));
                                        } else {
                                          /// navigate to the athletes page
                                          if (service.hasNextPage) {
                                            await Navigator.pushNamed(context,
                                                BarbellsPage.routeName);
                                          }
                                        }
                                      }
                                    },
                                    key: const Key('barbell_key'),
                                  );
                                },
                              ),
                            ),
                            SizedBox(
                              height: menuCardHeight,
                              width: menuCardWidth,
                              child: Consumer<AthletesNotifier>(
                                builder: (context, service, child) {
                                  return MenuCard(
                                    title: 'ATHLETES',
                                    subtitle: 'Information',
                                    func: () async {
                                      // ignore repeated presses
                                      if (!service.isBusy) {
                                        /// get the first page of athletes
                                        await service.getAthletesAsync();

                                        /// check for errors
                                        if (service.hasError) {
                                          /// show a snack bar
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                            content: Text(service.errorMessage),
                                          ));
                                        } else {
                                          /// navigate to the athletes page
                                          if (service.hasNextPage) {
                                            await Navigator.pushNamed(context,
                                                AthletesPage.routeName);
                                          }
                                        }
                                      }
                                    },
                                    key: const Key('athlete_key'),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    iconWidgetButton(
                        icon: FontAwesomeIcons.squareTwitter,
                        size: 38,
                        func: () =>
                            print('https://twitter.com/TollandCrossFit')),
                    iconWidgetButton(
                        icon: FontAwesomeIcons.squareFacebook,
                        size: 38,
                        func: () =>
                            print('https://www.facebook.com/tollandcrossfit/')),
                    iconWidgetButton(
                        icon: FontAwesomeIcons.squareInstagram,
                        size: 38,
                        func: () => print(
                            'https://www.instagram.com/TollandCrossFit/')),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
