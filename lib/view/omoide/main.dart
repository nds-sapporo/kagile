import 'package:flutter/material.dart';
import 'package:kagile/view/kajiboard/main.dart';
import 'package:kagile/view/widget/common_drawer.dart';
import 'package:firebase_database/firebase_database.dart';

/// Omoide
class OmoidePage extends StatefulWidget {
  OmoidePage(this.user);

  final String user;

  @override
  OmoidePageState createState() => OmoidePageState(user);
}

class OmoidePageState extends State<OmoidePage> {
  OmoidePageState(this.user);

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
            body: ListView(
              children: [
                Image.asset('images/6.png'), 
                SizedBox(height: 45.0),
                Image.asset('images/5.png'), 
              ],
            ),
          ),
          drawer: CommonDrawer(user, "omoide"),
        ),
      ),
    );
  }
}