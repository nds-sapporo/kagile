import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kagile/view/kajiboard/main.dart';

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
            Image.asset('images/logo.png', height: 110.0,),
            SizedBox(
              height : 65.0, 
              child:DropdownButton<String>(
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
                      child: Text(value, style : TextStyle(fontSize: 40.0)),
                    );
                }).toList(),
              ),
            ),
            Text('',),
            OutlineButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(settings: RouteSettings(name:'/kajiboard'),
                      builder: (context) {
                        return KajiboardPage(dropdownValue);
                      }
                    )
                );
                },
              child: Text("ログイン", style : TextStyle(fontSize: 30.0)),
            ),
          ],
        ),
      ),
      backgroundColor: Color.fromARGB(255, 0, 190, 200),
    );
  }
}

