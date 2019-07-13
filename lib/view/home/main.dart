import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

/// ログイン
class _LoginState  extends State<LoginPage> {
  String dropdownValue = '太郎';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column (
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('images/logo.png'),
            DropdownButton<String>(
              value: dropdownValue,
              onChanged: (String newValue) {
                setState(() {
                  dropdownValue = newValue;
                });
              },
              items: <String>['太郎', '花子']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            OutlineButton(
              onPressed: () {Navigator.of(context).pushNamed('/kajiboard');},
              child: Text("ログイン"),
            ),
          ],
        ),
      ),
      backgroundColor: Color.fromARGB(255, 0, 190, 200),
    );
  }
}
