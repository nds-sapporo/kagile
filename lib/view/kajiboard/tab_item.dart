import 'package:flutter/material.dart';
import 'package:kagile/view/kajiboard/task_list.dart';
import 'package:firebase_database/firebase_database.dart';

import 'task_item.dart';

class MyTabItem extends StatefulWidget {

  MyTabItem({
    status,
    user
  }):
        this.status = status,
        this.user = user
  ;

  final String status;
  final String user;

  @override
  _MyTabItemState createState() => _MyTabItemState();
}

class _MyTabItemState extends State<MyTabItem> {

  var listItem = [];

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();

  TaskList tasklist;

  var reference = FirebaseDatabase.instance.reference().child("task");

  void loadList() {
//    if (tasklist == null) {
      reference.child(widget.status).once().then((snapshot) {
        String user ;
        if( widget.user == "太郎" ){user = "husband";}
        if( widget.user == "花子" ){user = "wife";}

        this.tasklist = TaskList(snapshot.value, widget.status, user);
        setState(() {
          listItem = tasklist.itemList;
        });
      });
//    } else {
//      //setValues();
//    }
  }

  @override
  void initState() {
    super.initState();
    loadList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,

      body: ListView.builder(itemBuilder: (BuildContext context, int index) {
        return listItem[index];
      }, itemCount: listItem.length),

    );
  }

}

