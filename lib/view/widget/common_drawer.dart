import 'package:flutter/material.dart';
import 'package:kagile/view/furikaeri/main.dart';
//import 'package:kagile/view/widget/about_tile.dart';
//import 'package:kagile/utils/uidata.dart';

class CommonDrawer extends StatelessWidget {
  final String user;
  CommonDrawer(this.user);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the Drawer if there isn't enough vertical
      // space to fit everything.
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          ListTile(
            title: Text('家事ボード'),
            onTap: () {Navigator.of(context).pushNamed('/kajiboard');},
          ),
          ListTile(
            title: Text('ふりかえり'),
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(
                      settings: RouteSettings(name: '/furikaeri'),
                    builder: (context) {
                        return FurikaeriPage(user:user);
                    }
                  )
              );
              },
          ),
          Container(
            child: ListTile(
              title: Text('おもいで',style: TextStyle(color: Colors.white),),
              onTap: () {Navigator.of(context).pop();},
            ),
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 0, 190, 200)
            ),
          ),
          ListTile(
            title: Text('設定'),
            onTap: () {Navigator.of(context).pushNamed('/setting');},
          ),
        ],
      ),
    );
  }
}
