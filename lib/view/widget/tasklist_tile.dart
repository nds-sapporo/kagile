import 'package:flutter/material.dart';
import 'package:kagile/view/itemDetail/main.dart';

class TasklistTile extends StatelessWidget {
  final title;
  final subtitle;
  final loginUser;
  final user;
  final limit;
  final comment;
  final point;
  final textColor;
  TasklistTile({this.title, this.subtitle, this.loginUser, this.user, this.limit, this.comment, this.point, this.textColor = Colors.black});
  @override
  Widget build(BuildContext context) {
    var image;
    if( this.user == "husband" ) {
      image = AssetImage("images/ohashi.jpg");
    }
    else if ( this.user == "wife" ){
      image = AssetImage("images/noboribetsu.png");
    }
    return Row(
      // crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
    Stack(
    children: <Widget>[
    CircleAvatar(
    backgroundImage: image,
    radius: 30.0,
    ),
    RawMaterialButton(
    onPressed: () {

      Navigator.push(context,
          MaterialPageRoute(
            settings: RouteSettings(name: "/detail"),
            builder: (context) {
              return DetailPage(title, this.limit, this.comment, this.point );
            },
          ));
    },
    child: Container(
    width: 60.0, // CircleAvatarのradiusの2倍
    height: 60.0,
    ),
    shape: new CircleBorder(),
    elevation: 0.0,
    ),
    ],
    ),
        SizedBox(
          width: 20.0,
        ),
    InkWell(
    child: Text(
      title,
      style: TextStyle(
          fontSize: 24.0, fontWeight: FontWeight.w700, color: textColor),

    ),
    onTap: () {
      Navigator.push(context,
          MaterialPageRoute(
            settings: RouteSettings(name: "/detail"),
            builder: (context) {
              return DetailPage(title, limit, comment, point );
            },
          ));
    },
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
