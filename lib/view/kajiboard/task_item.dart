
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kagile/view/itemDetail/main.dart';
import 'package:kagile/view/widget/tasklist_tile.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MyTaskItem extends StatelessWidget {
  final IconButton icon;
  final String id;
  final String user;
  final String loginUser;
  final String nowStatus;
  final String title;
  final String limit;
  final String point;

  MyTaskItem({
    icon,
    id,
    user,
    loginUser,
    nowStatus,
    title,
    limit,
    point,
    context,
  }):
        this.icon = IconButton(
          icon: Icon(icon),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(
                    settings: RouteSettings(name: "/detail"),
                    builder: (context) {
                      return DetailPage(title: "detail page",);
                    },
                ));
          }
        ),
        this.id = id,
        this.user = user,
        this.nowStatus = nowStatus,
        this.title = title,
        this.limit = limit,
        this.point = point,
        this.loginUser = loginUser
  ;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
        key: Key("some id"),
        background: Container(
            color: Color.fromARGB(255, 0, 190, 200),
            child: Text("やるよ！"),
        ),
        secondaryBackground: Container(
            color:Colors.red,
            child: Text("戻します・・"),
        ), // end to startの背景

      onDismissed: (direction) async {
        try {
          String preStatus = this.nowStatus;
          String nextStatus;
          String user = loginUser;

          if (direction == DismissDirection.endToStart) {
            if (this.nowStatus == "status_a") {
              // 「やって」から前には更新しない
              nextStatus = "status_a";
              user = "other";
              return;
            }
            if (this.nowStatus == "status_b") {
              nextStatus = "status_a";
              user = "other";
            }
            if (this.nowStatus == "status_c") {
              nextStatus = "status_b";
              if( user == "husband") {
                user = "wife";
              }
              else {
                user = "husband";
              }
            }
            if (this.nowStatus == "status_d") {
              nextStatus = "status_c";
              if( user == "husband") {
                user = "wife";
              }
              else {
                user = "husband";
              }
            }
          }
          else {
            if (this.nowStatus == "status_a") {
              nextStatus = "status_b";
              user = this.user;
            }
            if (this.nowStatus == "status_b") {
              nextStatus = "status_c";
              if( user == "husband") {
                user = "wife";
              }
              else {
                user = "husband";
              }
            }
            if (this.nowStatus == "status_c") {
              nextStatus = "status_d";
              if( user == "husband") {
                user = "wife";
              }
              else {
                user = "husband";
              }
            }
            if (this.nowStatus == "status_d") {
              // 「出来た」から後続には更新しない
              nextStatus = "status_d";
              user = this.user;
              return;
            }
          }

          const url = "https://us-central1-spajam-kajaile.cloudfunctions.net/moveTask";
          final response = await http.put(url,
              body: json.encode({
                'taskId':this.id,
                'preStatus':preStatus,
                'nextStatus':nextStatus,
                'nowplay': user
              }),
              headers: {"Content-Type": "application/json"});
          print(response);

//          final HttpsCallable callable = CloudFunctions.instance.getHttpsCallable(
//            functionName: 'moveTask',
//          );
          
//          final dynamic resp = await callable.call(
//            <String, dynamic>{
//              'taskId':this.id,
//              'preStatus':preStatus,
//              'nextStatus':nextStatus,
//              'nowplay': user
//            },
//          );
//          print(resp);
        } on CloudFunctionsException catch (e) {
          print('caught firebase functions exception');
          print(e.code);
          print(e.message);
          print(e.details);
        } catch (e) {
          print('caught generic exception');
          print(e);
        }
      },
/*
        onDismissed: (direction) {
            print(direction);
            if (direction == DismissDirection.endToStart) {
                print("end to start"); // (日本語だと)右から左のとき
            } else {
                print("start to end"); // (日本語だと?)左から右のとき
            }
        },
*/
      child: TasklistTile(
        title: this.title,
        subtitle: this.limit,
        textColor:Colors.black,
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




/*
        child: ListTile(
            trailing: this.icon,
            title: Text(this.message, textAlign: TextAlign.start,),
        ),
*/
    );
  }
}
