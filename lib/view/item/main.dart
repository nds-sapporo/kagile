import 'package:flutter/material.dart';
import 'package:kagile/view/kajiboard/main.dart';
import 'package:kagile/view/widget/common_drawer.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';

/// 設定
class AddItemPage extends StatefulWidget {
  AddItemPage(this.user);

  final String user;

  @override
  AddItemPageState createState() => AddItemPageState(user);
}

class AddItemPageState extends State<AddItemPage> {
  AddItemPageState(this.user);

  final String user;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController titleTextController = TextEditingController();
  TextEditingController commentTextController = TextEditingController();
  TextEditingController pointTextController = TextEditingController();
  TextEditingController dateTextController = TextEditingController();

  var formatter = new DateFormat('yyyy/MM/dd HH:mm');

  void addTask() async {

    const url = "https://us-central1-spajam-kajaile.cloudfunctions.net/createOnceTask";
    final response = await http.put(url,
        body: json.encode({
          'title':titleTextController.text,
          'comment':commentTextController.text,
          'limit':dateTextController.text,
          'point': pointTextController.text
        }),
        headers: {"Content-Type": "application/json"});

    print(response);

    Navigator.of(context).pushReplacement(
        MaterialPageRoute(settings: RouteSettings(name: '/kajiboard'),
            builder: (context) {
              return KajiboardPage(user);
            }));
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
                keyboardType: TextInputType.text,
                controller: titleTextController,
                decoration: InputDecoration(labelText: '内容', border: OutlineInputBorder()),
              ),
              SizedBox(height: 16.0),
              TextField(
                keyboardType: TextInputType.text,
                controller: commentTextController,
                decoration: InputDecoration(labelText: 'コメント', border: OutlineInputBorder()),
              ),
              SizedBox(height: 16.0),
              TextField(
                keyboardType: TextInputType.text,
                controller: dateTextController,
                onTap: () {
                  DatePicker.showDateTimePicker(
                    context,
                    showTitleActions: true,
                    locale: LocaleType.jp,
                    // onChanged内の処理はDatepickerの選択に応じて毎回呼び出される
                    onChanged: (date) {
                      // print('change $date');
                    },
                    // onConfirm内の処理はDatepickerで選択完了後に呼び出される
                    onConfirm: (date) {
                      setState(() {
                        dateTextController = TextEditingController(text: formatter.format(date));
                      });
                    },
                    // Datepickerのデフォルトで表示する日時
                    currentTime: DateTime.now(),
                    // localによって色々な言語に対応
                    //  locale: LocaleType.en
                  );
                },
                decoration: InputDecoration(labelText: '期限', border: OutlineInputBorder()),
              ),
              SizedBox(height: 28.0),
              TextField(
                keyboardType: TextInputType.number,
                controller: pointTextController,
                decoration: InputDecoration(labelText: 'ポイント', border: OutlineInputBorder()),
              ),
              SizedBox(height: 28.0),
              OutlineButton(
                onPressed: () {
                  addTask();
                  },
                child: Text("登録", style :  TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold,)),
              ),
            ],
          ),
        ),
      ),
      drawer: CommonDrawer(user, "newTask"),
    );
  }
}