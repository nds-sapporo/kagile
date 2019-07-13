import 'package:flutter/material.dart';

class TasklistTile extends StatelessWidget {
  final title;
  final subtitle;
  final textColor;
  TasklistTile({this.title, this.subtitle, this.textColor = Colors.black});
  @override
  Widget build(BuildContext context) {
    return Row(
      // crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 10.0,
        ),
        CircleAvatar(
          backgroundImage: NetworkImage(
              "https://avatars0.githubusercontent.com/u/12619420?s=460&v=4"),
          foregroundColor: Colors.black,
          radius: 30.0,
        ),
        SizedBox(
          width: 10.0,
        ),
        Text(
          title,
          style: TextStyle(
              fontSize: 24.0, fontWeight: FontWeight.w700, color: textColor),

        ),
//        SizedBox(
//          width: 10.0,
//        ),
//        Text(
//          subtitle,
//          style: TextStyle(
//              fontSize: 15.0, fontWeight: FontWeight.normal, color: textColor),
//        ),
      ],
    );
  }
}
