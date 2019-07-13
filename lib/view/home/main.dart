import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kagile/view/kajiboard/main.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

/// ログイン
class _LoginState  extends State<LoginPage> {
  String dropdownValue = '太郎';
  final FirebaseMessaging _firebaseMessaging = new FirebaseMessaging();

  @override
  void initState() {
    super.initState();

    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        Map<dynamic, dynamic> notification = message["notification"];
        _buildDialog(context, notification["title"], notification["body"]);
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        Map<String, dynamic> notification = message["notification"];
        _buildDialog(context, notification["title"], notification["body"]);
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        Map<String, dynamic> notification = message["notification"];
        _buildDialog(context, notification["title"], notification["body"]);
      },
    );
    _firebaseMessaging.getToken().then((String token) {
      assert(token != null);
      print("Push Messaging token: $token");
    });

  }

  void _buildDialog(BuildContext context, String title, String message) {
    print("build dialog: $title");
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new AlertDialog(
            title: new Text("$title"),
            content: new Text("$message"),
            actions: <Widget>[
              new FlatButton(
                child: const Text('CLOSE'),
                onPressed: () {
                  Navigator.pop(context, false);
                },
              ),
            ],
          );
        }
    );
  }

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
            SizedBox(height: 16.0),
            OutlineButton(
              onPressed: () {

                if (dropdownValue == "太郎") {
                  print("subcribe: 太郎");
                  _firebaseMessaging.subscribeToTopic("/topics/husband");
                }
                if (dropdownValue == "花子") {
                  print("subcribe: 花子");
                  _firebaseMessaging.subscribeToTopic("/topics/wife");
                }
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

