import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tcf_getit/src/providers/affiliate_service.dart';

class AffiliatePage extends StatelessWidget {
  static const String routeName = '/box';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<AffiliateService>(builder: (context, service, child) {
          return Container(
              child: Column(
            children: [
              Container(
                child: Align(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 0, 20),
                    child: InkWell(
                        child: Icon(FontAwesomeIcons.arrowLeft),
                        onTap: () => Navigator.pop(context)),
                  ),
                  alignment: Alignment.centerLeft,
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(service.info.attributes.name),
                    Text(service.info.attributes.street),
                    Text(service.info.attributes.city),
                    Text(service.info.attributes.stateOrProvince),
                  ],
                ),
              ),
            ],
          ));
        }),
      ),
    );
  }
}
