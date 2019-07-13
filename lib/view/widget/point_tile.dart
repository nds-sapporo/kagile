import 'package:flutter/material.dart';

class PointTile extends StatelessWidget {
  final title;
  final subtitle;
  final textColor;
  PointTile({this.title, this.subtitle, this.textColor = Colors.black});
  @override
  Widget build(BuildContext context) {
    return Column(
      // crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          subtitle,
          style: TextStyle(
              fontSize: 15.0, fontWeight: FontWeight.normal, color: textColor),
        ),
        SizedBox(
          height: 5.0,
        ),
        Text(
          title,
          style: TextStyle(
              fontSize: 20.0, fontWeight: FontWeight.w700, color: textColor),
        ),
      ],
    );
  }
}
