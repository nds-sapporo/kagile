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
        title: Text("振り返り"),
      ),
      body:Card(
        elevation: 4.0,
        margin: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
//            Image.asset('assets/neko1_600x400.jpg'),
            _titleArea(),
            _graphArea(),
//            _descriptionArea()
          ],
        ),
      )
//      bottomNavigationBar: BottomBar(0),// This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget _titleArea() {
    return Container(
        margin: EdgeInsets.all(16.0),
        width: MediaQuery.of(context).size.width*0.9,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(bottom: 4.0),
              child: Text(
                "夫の今月のおこづかいは",
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 16.0),
              ),
            ),
            Container(  // 3.1.2行目
              child: Text(
                "${summary.moneyHusband()}円",
                style: TextStyle(fontSize: 12.0, color: Colors.grey),
              ),
            ),
            Container(  // 3.1.2行目
              child: Text(
                "です",
                style: TextStyle(fontSize: 12.0, color: Colors.grey),
              ),
            ),Container(
              margin: const EdgeInsets.only(bottom: 4.0),
              child: Text(
                "妻の今月のおこづかいは",
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 16.0),
              ),
            ),
            Container(  // 3.1.2行目
              child: Text(
                "${summary.moneyWife()}円",
                style: TextStyle(fontSize: 12.0, color: Colors.grey),
              ),
            ),
            Container(  // 3.1.2行目
              child: Text(
                "です",
                style: TextStyle(fontSize: 12.0, color: Colors.grey),
              ),
            ),Container(
              margin: const EdgeInsets.only(bottom: 4.0),
              child: Text(
                "キャリーオーバーは",
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 16.0),
              ),
            ),
            Container(  // 3.1.2行目
              child: Text(
                "${summary.moneyOther()}円",
                style: TextStyle(fontSize: 12.0, color: Colors.grey),
              ),
            ),
            Container(  // 3.1.2行目
              child: Text(
                "です",
                style: TextStyle(fontSize: 12.0, color: Colors.grey),
              ),
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