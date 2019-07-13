import 'package:flutter/material.dart';
import 'package:kagile/view/kajiboard/main.dart';
import 'package:kagile/view/widget/common_drawer.dart';
import 'package:firebase_database/firebase_database.dart';

/// 設定
class SettingPage extends StatefulWidget {
  SettingPage(this.user);

  final String user;

  @override
  SettingPageState createState() => SettingPageState(user);
}

class SettingPageState extends State<SettingPage> {
  SettingPageState(this.user);

  final String user;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController valueTextController = TextEditingController();
  TextEditingController taroTextController = TextEditingController();
  TextEditingController hanakoTextController = TextEditingController();

  var reference = FirebaseDatabase.instance.reference().child("master");

  void saveSetting() async {
    await reference.update({
      "okozukai": valueTextController.text,
      "weight": {
        "husband": double.parse(taroTextController.text),
        "wife": double.parse(hanakoTextController.text),
      }
    });

    Navigator.of(context).push(
        MaterialPageRoute(settings: RouteSettings(name: '/kajiboard'),
            builder: (context) {
              return KajiboardPage(user);
            }));
  }

  @override
  void initState() {
    super.initState();
    reference.once().then((snapshot) {
      Map<dynamic, dynamic> v = snapshot.value;
      Map<dynamic, dynamic> weight = v["weight"];

      setState(() {
        valueTextController = TextEditingController(text: v["okozukai"].toString());
        taroTextController = TextEditingController(text: weight["husband"].toString());
        hanakoTextController = TextEditingController(text: weight["wife"].toString());
      });
    });
  }

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
                controller: valueTextController,
                decoration: InputDecoration(labelText: 'おこづかい原資', border: OutlineInputBorder()),
              ),
              SizedBox(height: 16.0),
//              TextField(
//                keyboardType: TextInputType.number,
//                decoration: InputDecoration(labelText: '太郎のベース額', border: OutlineInputBorder()),
//              ),
//              SizedBox(height: 16.0),
              TextField(
                keyboardType: TextInputType.number,
                controller: taroTextController,
                decoration: InputDecoration(labelText: '太郎の倍率', border: OutlineInputBorder()),
              ),
              SizedBox(height: 16.0),
//              TextField(
//                keyboardType: TextInputType.number,
//                decoration: InputDecoration(labelText: '花子のベース額', border: OutlineInputBorder()),
//              ),
//              SizedBox(height: 16.0),
              TextField(
                keyboardType: TextInputType.number,
                controller: hanakoTextController,
                decoration: InputDecoration(labelText: '花子の倍率', border: OutlineInputBorder()),
              ),
              SizedBox(height: 28.0),
              OutlineButton(
                onPressed: () {
                  saveSetting();
                  },
                child: Text("登録", style :  TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold,)),
              ),
            ],
          ),
        ),
      ),
      drawer: CommonDrawer(user, "setting"),
    );
  }
}