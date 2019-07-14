import 'package:flutter/material.dart';
import 'package:kagile/view/home/main.dart';
import 'package:kagile/view/kajiboard/main.dart';
import 'package:kagile/view/furikaeri/main.dart';
import 'package:kagile/view/omoide/main.dart';
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
//        "/kajiboard": (_) => KajiboardPage(),
        "/furikaeri": (_) => FurikaeriPage(),
        "/omoide":  (_) => OmoidePage(),
        "/summary": (_) => SummaryPage(),
//        "/setting": (_) => SettingPage(),
      },
    );
  }
}
