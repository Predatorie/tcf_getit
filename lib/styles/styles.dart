import 'package:flutter/material.dart';
import 'package:tcf_getit/branding/branding.dart';
import 'package:tcf_getit/src/models/wods_dto.dart';

Widget verticalMarginSmall() => SizedBox(
      height: 2,
    );

Widget verticalMarginMedium() => SizedBox(
      height: 4,
    );

Widget verticalMarginLarge() => SizedBox(
      height: 6,
    );

class WorkoutOfTheDayCard extends StatelessWidget {
  @required
  final List<Datum> data;
  final Function func;

  const WorkoutOfTheDayCard({Key key, this.data, this.func}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
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

  const MenuCard({Key key, this.title, this.subtitle, this.func})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: tollandCrossFitRed,
      onTap: func,
      child: Card(
        shadowColor: tollandCrossFitBlue,
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(
                color: tollandCrossFitBlue,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              subtitle,
              style: TextStyle(
                  color: tollandCrossFitGrey,
                  fontWeight: FontWeight.normal,
                  fontSize: 12),
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
    {@required IconData icon, @required double size, @required Function func}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: InkWell(
      onTap: func,
      child: Icon(
        icon,
        size: size,
        color: tollandCrossFitBlue,
      ),
    ),
  );
}
