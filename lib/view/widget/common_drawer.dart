import 'package:flutter/material.dart';
import 'package:kagile/view/furikaeri/main.dart';
import 'package:kagile/view/kajiboard/main.dart';
import 'package:kagile/view/setting/main.dart';
//import 'package:kagile/view/widget/about_tile.dart';
//import 'package:kagile/utils/uidata.dart';

class CommonDrawer extends StatelessWidget {
  final String user;
  final String page;
  CommonDrawer(this.user, this.page);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          if (page == "kajiboard")
            Container(
              child: ListTile(
                title: Text('家事ボード',style: TextStyle(color: Colors.white),),
                onTap: () {Navigator.of(context).pop();},
              ),
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 0, 190, 200)
              ),
            ),
          if (page != "kajiboard") 
          ListTile(
            title: Text('家事ボード'),
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(settings: RouteSettings(name: '/kajiboard'),
                      builder: (context) {
                        return KajiboardPage(user);
                      }));
              },
          ),
          if (page == "furikaeri")
            Container(
              child: ListTile(
                title: Text('ふりかえり',style: TextStyle(color: Colors.white),),
                onTap: () {Navigator.of(context).pop();},
              ),
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 0, 190, 200)
              ),
            ),
          if (page != "furikaeri")
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
          if (page == "omoide") 
            Container(
              child: ListTile(
                title: Text('おもいで',style: TextStyle(color: Colors.white),),
                onTap: () {Navigator.of(context).pop();},
              ),
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 0, 190, 200)
              ),
            ),
          if (page != "omoide")
            ListTile(
              title: Text('おもいで'),
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(settings: RouteSettings(name: '/omoide'),
                    builder: (context) {
                      return SettingPage(user);
                    }));
                },
            ),
          if (page == "setting")
            Container(
              child: ListTile(
                title: Text('設定',style: TextStyle(color: Colors.white),),
                onTap: () {Navigator.of(context).pop();},
              ),
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 0, 190, 200)
              ),
            ),
          if (page != "setting")
          ListTile(
            title: Text('設定'),
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(settings: RouteSettings(name: '/setting'),
                  builder: (context) {
                    return SettingPage(user);
                  }));
              },
          ),
        ],
      ),
    );
  }
}
