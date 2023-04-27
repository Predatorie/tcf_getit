import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../styles/styles.dart';
import '../providers/wod_notifier.dart';

class WodPage extends StatelessWidget {
  static const String routeName = '/wod';

  const WodPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<WodNotifier>(builder: (context, service, child) {
          return Column(
            children: [
              Align(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 0, 20),
                  child: InkWell(
                      child: const Icon(FontAwesomeIcons.arrowLeft),
                      onTap: () => Navigator.pop(context)),
                ),
                alignment: Alignment.centerLeft,
              ),
              Expanded(
                child: ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: service.wod.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        shadowColor: Colors.black,
                        elevation: 6,
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Center(
                                child: Text(
                                  service.wod[index].attributes.track
                                      .attributesFor.name,
                                  style: const TextStyle(fontSize: 20),
                                ),
                              ),
                              Text(
                                service.wod[index].attributes.title,
                                style: const TextStyle(fontSize: 16),
                              ),
                              verticalMarginSmall(),
                              Text(
                                service.wod[index].attributes.description,
                                style: const TextStyle(fontSize: 16),
                              ),
                              verticalMarginLarge(),
                            ],
                          ),
                        ),
                      );
                    }),
              ),
            ],
          );
        }),
      ),
    );
  }
}
