import 'package:flutter/material.dart';
import 'package:kagile/view/kajiboard/main.dart';
import 'package:kagile/view/widget/common_scaffold.dart';
import 'package:kagile/view/widget/task_tile.dart';
import 'package:kagile/view/widget/point_tile.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DetailPage extends StatelessWidget {
  DetailPage(this.title, this.limit, this.comment, this.point, this.user, this.id, this.status, {Key key}) : super(key: key);
  Size deviceSize;
  final String title;
  final String limit;
  final String comment;
  final String point;
  final String user;
  final String id;
  final String status;

  Widget profileHeader() => Container(
    height: deviceSize.height / 8,
    width: double.infinity,
    color: Color.fromARGB(255, 0, 190, 200),
    child: Padding(
      padding: const EdgeInsets.all(5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          TaskTile(
            title: this.title,
            subtitle: this.limit,
              textColor:Colors.white,
          ),
        ],
      ),
/*
      child: Card(
        clipBehavior: Clip.antiAlias,
        color: Color.fromARGB(255, 0, 190, 200),
        child: FittedBox(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(
                "夕食",
                style: TextStyle(color: Colors.white, fontSize: 24.0),
              ),
              Text(
                "期限：2019/07/14 20:00",
                style: TextStyle(color: Colors.white),
              )
            ],
          ),
        ),
      ),
*/
    ),
  );

  Widget imagesCard() => Container(
    height: deviceSize.height / 6,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "コメント",
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18.0),
            ),
          ),
          Expanded(
            child: Card(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 1,
                itemBuilder: (context, i) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    this.comment,
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14.0),
                  ),
//                  child: Image.network(
//                      "https://cdn.pixabay.com/photo/2016/10/31/18/14/ice-1786311_960_720.jpg"),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );

  Widget profileColumn() => Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        CircleAvatar(
          backgroundImage: NetworkImage(
              "https://avatars0.githubusercontent.com/u/12619420?s=460&v=4"),
        ),
        Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Pawan Kumar posted a photo",
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    "25 mins ago",
                  )
                ],
              ),
            ))
      ],
    ),
  );

  Widget followColumn(Size deviceSize) => Container(
    height: deviceSize.height * 0.13,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        PointTile(
          title: this.point + "pt",
          subtitle: "ポイント",
        ),
      ],
    ),
  );



  Widget postCard() => Container(
    width: double.infinity,
    height: deviceSize.height / 3,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Post",
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18.0),
            ),
          ),
          profileColumn(),
          Expanded(
            child: Card(
              elevation: 2.0,
              child: Image.network(
                "https://cdn.pixabay.com/photo/2018/06/12/01/04/road-3469810_960_720.jpg",
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    ),
  );

  void cancel(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text("この家事をあきらめますか？"),
        actions: <Widget>[
          FlatButton(
            child: Text("はい"),
            onPressed: () async {
              const url = "https://us-central1-spajam-kajaile.cloudfunctions.net/moveTask";
              final response = await http.put(url,
                  body: json.encode({
                    'taskId':this.id,
                    'preStatus':this.status,
                    'nextStatus':"status_d",
                    'nowplay': "other"
                  }),
                  headers: {"Content-Type": "application/json"});
              print(response);
              print("deleted user: $user");

              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(settings: RouteSettings(name:'/kajiboard'),
                      builder: (context) {
                        return KajiboardPage(user);
                      }
                  )
              );
            },
          ),
          FlatButton(
            child: Text("いいえ"),
            onPressed: () => Navigator.pop(context),
          )
        ],
      ),
    );
  }

  Widget cancelButton(BuildContext context) {
    return
      OutlineButton(
        onPressed: () {
          cancel(context);
        },
        child: Text("あきらめる", style : TextStyle(fontSize: 30.0)),
      );
  }

  Widget bodyData(BuildContext context) => SingleChildScrollView(
    child: Column(
      children: <Widget>[
        profileHeader(),
        followColumn(deviceSize),
        imagesCard(),
        cancelButton(context),
//        postCard(),
      ],
    ),
  );

  @override
  Widget build(BuildContext context) {
    deviceSize = MediaQuery.of(context).size;
    return CommonScaffold(
      appTitle: "家事 詳細",
      bodyData: bodyData(context),
      elevation: 0.0,
    );
  }
}
