

import 'package:flutter/material.dart';

import 'task_item.dart';

class TaskList {

  List<MyTaskItem> itemList;

  TaskList(dynamic value, String status, String loginUser) {
    itemList = List();
    Map<dynamic, dynamic> items = value;
    for(var i in items.keys) {
      Map<dynamic, dynamic> item = items[i];
      String id = i;
      String user = item["nowplay"];

      //ImageIcon icon;
      //if( user == "husband" ) {
      //  icon = ImageIcon(image: Image.asset('images/dog.jpg'));
      //}

      String nowStatus = status;
      String title = item["title"];
      String limit = "期限:" + item["limit"];
      String point = item["point"].toString();
      String comment = item["comment"];
      itemList.add(MyTaskItem(icon: Icons.android, title: title, limit: limit, point: point, id: id, user: user, comment: comment, nowStatus: nowStatus, loginUser: loginUser));
    }
  }

}