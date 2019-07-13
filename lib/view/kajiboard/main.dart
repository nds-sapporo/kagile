import 'package:flutter/material.dart';
import 'package:kagile/view/widget/common_drawer.dart';
import 'tab_item.dart';

/// 家事ボード
class KajiboardPage extends StatelessWidget {
  KajiboardPage(this.user);

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final String user;

  @override
  Widget build(BuildContext context) {
    final tabs = ['やって！', 'やってる！', 'やったよ！', 'できた！'];
    return new Scaffold(
      body:DefaultTabController(
        length: tabs.length,
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
                  bottom: TabBar(
                    labelColor:Colors.white,
                    unselectedLabelColor: Colors.black45,
                    tabs: tabs.map((String name) => Tab(text: name)).toList(),
                  ),
                  backgroundColor: Color.fromARGB(255, 0, 190, 200),
                )
              ];
            },
            body: TabBarView(
              children: [
                MyTabItem(status: "status_a", user: this.user),
                MyTabItem(status: "status_b", user: this.user),
                MyTabItem(status: "status_c", user: this.user),
                MyTabItem(status: "status_d", user: this.user),
              ],
            ),
          ),
          drawer: CommonDrawer(user),
          floatingActionButton: new FloatingActionButton(
              onPressed: () => {},
              backgroundColor: Color.fromARGB(255, 0, 190, 200),
              child: new Stack(children: [
                new Positioned ( // headline
                  child: new Container(
                    child: new Icon(Icons.add),
                  ),
                ), ])
          ),
        ),
      ),
    );
  }
}

