
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kagile/view/itemDetail/main.dart';
import 'package:kagile/view/widget/task_tile.dart';

class MyTaskItem extends StatelessWidget {
  final IconButton icon;
  final String message;

  MyTaskItem({
    icon,
    message,
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
        this.message = message
  ;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
        key: Key("some id"),
        background: Container(color: Colors.red), // start to endの背景
        secondaryBackground: Container(color:Colors.yellow), // end to startの背景
        onDismissed: (direction) {
            print(direction);
            if (direction == DismissDirection.endToStart) {
                print("end to start"); // (日本語だと)右から左のとき
            } else {
                print("start to end"); // (日本語だと?)左から右のとき
            }
        },
      child: TaskTile(
        title: "夕食",
        subtitle: "期限：2019/07/14 20:00",
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

class YourTalkItem extends StatelessWidget {
  final Icon icon;
  final String message;

  YourTalkItem({
    icon,
    message
  }):
        this.icon = Icon(icon), this.message = message;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(this.message),
      leading: this.icon,
    );
  }
}