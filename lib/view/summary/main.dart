import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kagile/view/summary/summary.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class SummaryPage extends StatefulWidget {
  SummaryPage({Key key, this.summary}) : super(key: key);

  final Summary summary;

  @override
  SummaryPageState createState() => SummaryPageState(summary);
}

class SummaryPageState extends State<SummaryPage> {
  var listItem = [];
  final FirebaseMessaging _firebaseMessaging = new FirebaseMessaging();

  Summary summary;
  Map<String, double> dataMap;
  String moneyWife = "";
  String moneyHusband = "";
  String moneyOther = "";
  String pointWife = "";
  String pointHusband = "";

  var reference = FirebaseDatabase.instance.reference().child("summary").child("201907");

  void initDataMap() {
    if (summary != null) {
      this.dataMap.putIfAbsent("夫", () => summary.pointHusband.toDouble());
      this.dataMap.putIfAbsent("妻", () => summary.pointWife.toDouble());
      this.dataMap.putIfAbsent("あきらめた", () => summary.pointOther.toDouble());
    }
  }

  void loadSummary() {
    if (summary == null) {
      reference.once().then((snapshot) {
        this.summary = Summary(snapshot.value);
        setState(() {
          setValues();
        });
      });
    } else {
      setValues();
    }
  }

  void setValues() {
    moneyWife = summary.moneyWife().toString();
    moneyHusband = summary.moneyHusband().toString();
    moneyOther = summary.moneyOther().toString();
    pointWife = summary.weightedWifePoint().toString();
    pointHusband = summary.weightedHusbandPoint().toString();
    initDataMap();
  }

  SummaryPageState(Summary summary) {
    this.summary = summary;
    this.dataMap = new Map();
    loadSummary();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ふりかえり"),
      ),
      body:Card(
        elevation: 4.0,
        margin: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _leadArea(),
            Divider(
              color: Colors.grey,
            ),
            _pointArea(),
            Divider(
              color: Colors.grey,
            ),
            _graphArea(),
          ],
        ),
      )
    );
  }

  Widget _leadArea() {
    return Container(
        margin: EdgeInsets.all(16.0),
        width: MediaQuery.of(context).size.width*0.9,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(bottom: 16.0),
              child: RichText(
                text: TextSpan(
                  text: "夫のおこづかいは: ",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16.0, color: Colors.black
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: "$moneyHusband円",
                      style: TextStyle(fontSize: 18.0, color: Colors.green),
                    ),
                    TextSpan(
                      text: " です",
                      style: TextStyle(fontSize: 16.0, color: Colors.black),
                    ),
                  ]
                ),
              )
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 16.0),
              child: RichText(
                text: TextSpan(
                    text: "妻のおこづかいは: ",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16.0, color: Colors.black
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: "$moneyWife円",
                        style: TextStyle(fontSize: 18.0, color: Colors.green),
                      ),
                      TextSpan(
                        text: " です",
                        style: TextStyle(fontSize: 16.0, color: Colors.black),
                      ),
                    ]
                ),
              )
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 16.0),
              child: RichText(
                text: TextSpan(
                    text: "キャリーオーバーは: ",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16.0, color: Colors.black
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: "$moneyOther円",
                        style: TextStyle(fontSize: 18.0, color: Colors.green),
                      ),
                      TextSpan(
                        text: " です",
                        style: TextStyle(fontSize: 16.0, color: Colors.black),
                      ),
                    ]
                ),
              )
            ),
          ],
        ),
    );
  }

  Widget _pointArea() {
    return Container(
      margin: EdgeInsets.all(16.0),
      width: MediaQuery.of(context).size.width*0.9,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
              margin: const EdgeInsets.only(bottom: 16.0),
              child: RichText(
                text: TextSpan(
                    text: "夫の獲得ポイントは: ",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16.0, color: Colors.black
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: "$pointHusbandポイント",
                        style: TextStyle(fontSize: 18.0, color: Colors.green),
                      ),
                      TextSpan(
                        text: " でした",
                        style: TextStyle(fontSize: 16.0, color: Colors.black),
                      ),
                    ]
                ),
              )
          ),
          Container(
              margin: const EdgeInsets.only(bottom: 16.0),
              child: RichText(
                text: TextSpan(
                    text: "妻の獲得ポイントは: ",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16.0, color: Colors.black
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: "$pointWifeポイント",
                        style: TextStyle(fontSize: 18.0, color: Colors.green),
                      ),
                      TextSpan(
                        text: " でした",
                        style: TextStyle(fontSize: 16.0, color: Colors.black),
                      ),
                    ]
                ),
              )
          ),
        ],
      ),
    );
  }

  Widget _graphArea() {
    return Container(
        margin: EdgeInsets.all(16.0),
        width: MediaQuery.of(context).size.width*0.9,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: Text(
                "ポイント獲得比率",
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.lightGreen,
                ),
              )
            ),
            _graph(),
          ],
        ),
    );
  }

  Widget _graph() {
    if (summary == null) {
      return Container();
    } else {
      return PieChart(
        dataMap: dataMap,
        legendFontColor: Colors.blueGrey[900],
        legendFontSize: 14.0,
        legendFontWeight: FontWeight.w500,
        animationDuration: Duration(milliseconds: 800),
        chartLegendSpacing: 32.0,
        chartRadius: MediaQuery
            .of(context)
            .size
            .width / 2.7,
        showChartValuesInPercentage: true,
        showChartValues: true,
        chartValuesColor: Colors.blueGrey[900].withOpacity(0.9),
      );
    }
  }

  @override
  void initState() {
    super.initState();

    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        _buildDialog(context, "onMessage");
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        _buildDialog(context, "onLaunch");
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        _buildDialog(context, "onResume");
      },
    );
    _firebaseMessaging.getToken().then((String token) {
      assert(token != null);
      print("Push Messaging token: $token");
    });
    _firebaseMessaging.subscribeToTopic("/topics/husband");
    _firebaseMessaging.subscribeToTopic("/topics/wife");

  }

  void _buildDialog(BuildContext context, String message) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new AlertDialog(
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

}

class SummaryValue extends RichText {

}