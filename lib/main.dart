import 'package:flutter/material.dart';
import 'package:kagile/view/home/main.dart';
import 'package:kagile/view/kajiboard/main.dart';
import 'package:kagile/view/furikaeri/main.dart';
import 'package:kagile/view/summary/main.dart';
import 'package:kagile/view/setting/main.dart';
import 'package:kagile/view/widget/common_drawer.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        "/": (_) => LoginPage(),
        "/kajiboard": (_) => KajiboardPage(),
        "/furikaeri": (_) => FurikaeriPage(),
        "/summary": (_) => SummaryPage(),
        "/setting": (_) => SettingPage(),
      },
    );
  }
}


/// Omoide
class Omoide extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body:DefaultTabController(
        length: 1,
        child: Scaffold(
          key: _scaffoldKey,
          body: new NestedScrollView(
            controller: ScrollController(),
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                new SliverAppBar(
                  leading: IconButton(
                      tooltip: 'menu button',
                      icon: const Icon(Icons.menu,color: Colors.white,),
                      onPressed: () => _scaffoldKey.currentState.openDrawer()),
                  title: Image.asset('images/head.png'),
                  pinned: true,
                  floating: true,
                  forceElevated: innerBoxIsScrolled,
                  backgroundColor: Color.fromARGB(255, 0, 190, 200),
                )
              ];
            },
            body: Text("bbbbbbbbbbbb")
          ),
          drawer: CommonDrawer(),
        ),
      ),
    );
  }
}
