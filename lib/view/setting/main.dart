import 'package:flutter/material.dart';
import 'package:kagile/view/widget/common_drawer.dart';

/// 設定
class SettingPage extends StatelessWidget {
  SettingPage(this.user);

  final String user;
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
              body: Text("SettingPage")
          ),
          drawer: CommonDrawer(user),
        ),
      ),
    );
  }
}