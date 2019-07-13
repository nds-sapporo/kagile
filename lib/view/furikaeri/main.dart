import 'package:flutter/material.dart';
import 'package:kagile/view/summary/main.dart';
import 'package:kagile/view/widget/common_drawer.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

/// ふりかえり
class FurikaeriPage extends StatefulWidget {
  FurikaeriPage({Key key, this.user}) : super(key: key);

  final String user;

  @override
  FurikaeriPageState createState() => FurikaeriPageState(user);
}

class FurikaeriPageState extends State<FurikaeriPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  var reference = FirebaseDatabase.instance.reference().child("master");

  var descTextStyle = TextStyle(fontSize: 25.0,);
  // 設定値格納変数
  String gankin = '';
  String taroValue = '';
  String taroMag = '';
  String hanakoValue = '';
  String hanakoMag = '';
  final String user;

  FurikaeriPageState(this.user);

  @override
  void initState() {
    super.initState();
    reference.once().then((snapshot) {
      setState(() {
        Map<dynamic, dynamic> master = snapshot.value;
        gankin = master["okozukai"].toString();
        Map<dynamic, dynamic> weight = master["weight"];
        taroMag = weight["husband"].toString();
        hanakoMag =weight["wife"].toString();
        taroValue = ((num.parse(gankin) * num.parse(taroMag)) / ((num.parse(taroMag) + num.parse(hanakoMag)))).toString();
        hanakoValue = ((num.parse(gankin) * num.parse(hanakoMag)) / ((num.parse(taroMag) + num.parse(hanakoMag)))).toString();
      });
    });
  }

   void summary() async {

    const url = "https://us-central1-spajam-kajaile.cloudfunctions.net/calcSummary";
    final response = await http.put(url,
        headers: {"Content-Type": "application/json"});

    print(response);

    Navigator.of(context).push(
        MaterialPageRoute(settings: RouteSettings(name:'/summary'),
            builder: (context) {
              return SummaryPage(user:user);
            }
        ));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: DefaultTabController(
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
                  SizedBox(height: 28.0),
                  Text('おこづかい原資 ： $gankin 円', style : TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold,)),
                  SizedBox(height: 28.0),
//                  Text('太郎のベース額 ： $taroValue 円', style : descTextStyle),
                  Text('太郎の倍率 ： $taroMag 倍', style : descTextStyle),
                  SizedBox(height: 28.0),
//                  Text('花子のベース額 ： $hanakoValue 円', style : descTextStyle),
                  Text('花子の倍率 ： $hanakoMag 倍', style : descTextStyle),
                  SizedBox(height: 28.0),
                  OutlineButton(
                    onPressed: () {
                      summary();
                      },
                    child: Text("集計", style :  TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold,)),
                  ),
                ],
              ),
            ),
          ),
          drawer: CommonDrawer(this.user),
        ),
      ),
    );
  }
}

