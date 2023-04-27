import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../styles/styles.dart';
import '../providers/affiliate_notifier.dart';

class AffiliatePage extends StatelessWidget {
  static const String routeName = '/box';

  const AffiliatePage({required Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<AffiliateNotifier>(builder: (context, service, child) {
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
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Image.network(
                      service.info.attributes.logoUrl,
                      fit: BoxFit.cover,
                      height: 256,
                      width: 256,
                    ),
                    verticalMarginExtraLarge(),
                    Text(
                      service.info.attributes.name,
                      style: fontStyleMenuTitle,
                    ),
                    verticalMarginExtraLarge(),
                    Text(service.info.attributes.nickname),
                    Text(service.info.attributes.street),
                    Text(service.info.attributes.city),
                    Text(service.info.attributes.stateOrProvince),
                  ],
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
