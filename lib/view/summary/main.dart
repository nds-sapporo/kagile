import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_database/firebase_database.dart';

class SummaryPage extends StatefulWidget {
  SummaryPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  SummaryPageState createState() => SummaryPageState();
}

class SummaryPageState extends State<SummaryPage> {
  var listItem = [];

  final _mainReference = FirebaseDatabase.instance.reference().child("summary").child("201905");
  final _textEditController = TextEditingController();
  String valueText = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("振り返り"),
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            valueText
          ),
          RichText(
            text: TextSpan(
              text: "おこづかいは",
//              style: DefaultTextStyle.of(context).style,
              children: <TextSpan>[
                TextSpan(text: '20000円', style: TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(text: 'です!!'),
              ]
            )
          ),
          RichText(
              text: TextSpan(
                  text:"20000円",
                  style: TextStyle(fontWeight: FontWeight.bold),
                  children: <TextSpan>[
                    TextSpan(text: 'です!!'),
                  ]
              )
          ),
          RichText(
              text: TextSpan(
                  text:"です",
              )
          ),

        ],
      ),
//      bottomNavigationBar: BottomBar(0),// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
  
  @override
  void initState() {
    _mainReference.child("husband").once().then((snapshot) {
      setState(() {
        valueText = snapshot.value.toString();
      });
    });
    super.initState();
  }
}

class SummaryValue extends RichText {

}