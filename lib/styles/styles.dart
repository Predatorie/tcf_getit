import 'package:flutter/material.dart';
import 'package:tcf_getit/branding/branding.dart';

Widget menuCard(
    {@required String title,
    @required String subtitle,
    @required Function func}) {
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
