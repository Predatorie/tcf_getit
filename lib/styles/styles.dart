import 'package:flutter/material.dart';

import '../branding/branding.dart';
import '../src/models/wods_dto.dart';

const fontStyleMenuTitle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    fontFamily: 'NotoSans-Bold',
    color: tollandCrossFitBlue);

const fontStyleMenuSubtitle = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    fontFamily: 'NotoSans-Regular',
    color: tollandCrossFitGrey);

const fontStyleCardTitle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    fontFamily: 'NotoSans-Bold',
    color: tollandCrossFitBlue);

const fontStyleCardNormal = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.normal,
  fontFamily: 'NotoSans-Regular',
);

const fontStyleCardMicro = TextStyle(
  fontSize: 12,
  fontWeight: FontWeight.normal,
  fontFamily: 'NotoSans-Light',
);

const double menuCardHeight = 80;

const double menuCardWidth = 120;

Widget verticalMarginSmall() => const SizedBox(
      height: 2,
    );

Widget verticalMarginMedium() => const SizedBox(
      height: 4,
    );

Widget verticalMarginLarge() => const SizedBox(
      height: 6,
    );

Widget verticalMarginExtraLarge() => const SizedBox(
      height: 10,
    );

class WorkoutOfTheDayCard extends StatelessWidget {
  @required
  final List<WodDatum> data;
  final Function func;

  const WorkoutOfTheDayCard(
      {required Key key, required this.data, required this.func})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const InkWell(
      child: Card(
        child: Column(
          children: [],
        ),
      ),
    );
  }
}

class MenuCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final Function func;

  const MenuCard(
      {required Key key,
      required this.title,
      required this.subtitle,
      required this.func})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: tollandCrossFitRed,
      onTap: () => func(),
      child: Card(
        shadowColor: tollandCrossFitBlue,
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: fontStyleMenuTitle,
            ),
            Text(
              subtitle,
              style: fontStyleMenuSubtitle,
            ),
          ],
        )),
        elevation: 6,
        color: Colors.white,
      ),
    );
  }
}

Widget iconWidgetButton(
    {required IconData icon, required double size, required Function func}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: InkWell(
      onTap: () => func(),
      child: Icon(
        icon,
        size: size,
        color: tollandCrossFitBlue,
      ),
    ),
  );
}
