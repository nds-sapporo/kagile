import 'package:flutter/material.dart';
import 'package:kagile/view/widget/common_drawer.dart';

/// ふりかえり
class FurikaeriPage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  var descTextStyle = TextStyle(fontSize: 25.0,);
  // 設定値格納変数
  String gankin = '60,000';
  String taroValue = '10,000';
  String taroMag = '1.2';
  String hanakoValue = '5,000';
  String hanakoMag = '1.0';
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
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('以下の設定値で集計します。', style : descTextStyle),
                  Text('よろしいですか？', style : descTextStyle),
                  Text('', style : descTextStyle),
                  Text('お小遣い原資 ： $gankin 円', style : TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold,)),
                  Text('', style : descTextStyle),
                  Text('太郎のベース額 ： $taroValue 円', style : descTextStyle),
                  Text('太郎の倍率 ： $taroMag 倍', style : descTextStyle),
                  Text('', style : descTextStyle),
                  Text('花子のベース額 ： $hanakoValue 円', style : descTextStyle),
                  Text('花子の倍率 ： $hanakoMag 倍', style : descTextStyle),
                  Text('', style : descTextStyle),
                  OutlineButton(
                    onPressed: () {Navigator.of(context).pushNamed('/summary');},
                    child: Text("集計", style :  TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold,)),
                  ),
                ],
              ),
            ),
          ),
          drawer: CommonDrawer(),
        ),
      ),
    );
  }
}

