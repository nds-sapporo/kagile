import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kagile/view/summary/summary.dart';
import 'package:pie_chart/pie_chart.dart';

class SummaryPage extends StatefulWidget {
  SummaryPage({Key key, this.summary}) : super(key: key);

  final Summary summary;

  @override
  SummaryPageState createState() => SummaryPageState(summary);
}

class SummaryPageState extends State<SummaryPage> {
  var listItem = [];

  Summary summary;
  Map<String, double> dataMap;

  SummaryPageState(Summary summary) {
    this.summary = summary;
    this.dataMap = new Map();
    this.dataMap.putIfAbsent("夫", () => summary.pointHusband.toDouble());
    this.dataMap.putIfAbsent("妻", () => summary.pointWife.toDouble());
    this.dataMap.putIfAbsent("あきらめた", () => summary.pointOther.toDouble());
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
                      text: "${summary.moneyHusband()}円",
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
                        text: "${summary.moneyWife()}円",
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
                        text: "${summary.moneyOther()}円",
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
                        text: "${summary.pointHusband}ポイント",
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
                        text: "${summary.pointWife}ポイント",
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
            PieChart(
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
            )
          ],
        ),
    );
  }

  @override
  void initState() {
    super.initState();
  }
}

class SummaryValue extends RichText {

}