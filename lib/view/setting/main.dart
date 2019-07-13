import 'package:flutter/material.dart';
import 'package:kagile/view/widget/common_drawer.dart';

/// 設定
class SettingPage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: NestedScrollView(
        controller: ScrollController(),
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            new SliverAppBar(
              leading: IconButton(
                  tooltip: 'menu button',
                  icon: const Icon(Icons.menu,color: Colors.white,),
                  onPressed: () => Scaffold.of(context).openDrawer()
              ),
              title: Image.asset('images/head.png'),
              pinned: true,
              floating: true,
              forceElevated: innerBoxIsScrolled,
              backgroundColor: Color.fromARGB(255, 0, 190, 200),
            )
          ];
        },
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: ListView(
            children: [
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'おこづかい原資', border: OutlineInputBorder()),
              ),
              SizedBox(height: 16.0),
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: '太郎のベース額', border: OutlineInputBorder()),
              ),
              SizedBox(height: 16.0),
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: '太郎の倍率', border: OutlineInputBorder()),
              ),
              SizedBox(height: 16.0),
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: '花子のベース額', border: OutlineInputBorder()),
              ),
              SizedBox(height: 16.0),
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: '花子の倍率', border: OutlineInputBorder()),
              ),
              SizedBox(height: 28.0),
              OutlineButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/summary');
                  },
                child: Text("登録", style :  TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold,)),
              ),
            ],
          ),
          
        ),
      ),
      drawer: CommonDrawer(),
    );
  }
}