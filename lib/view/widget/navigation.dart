import 'package:flutter/material.dart';
//import 'package:helloworld/view/home/main.dart';

class BottomBar extends StatelessWidget{

  final int index;

  BottomBar(index):
      this.index = index;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: [
        new BottomNavigationBarItem(
          icon: IconButton(
            icon: Icon(Icons.insert_comment),
            onPressed: () {
              Navigator.pushReplacementNamed(context, "/");
            },
          ),
          title: new Text('チャット'),
        ),

        new BottomNavigationBarItem(
          icon: IconButton(
            icon: Icon(Icons.backup),
            onPressed: () {
              Navigator.pushReplacementNamed(context, "/share");
            },),
          title: new Text('共有'),
        )
      ],
      elevation: 0,
      backgroundColor: Color.fromARGB(127, 192, 192, 192),
      currentIndex: index,

    );
  }
}