import 'package:flutter/material.dart';
import 'ComplaintsModel.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class CompareWard extends StatefulWidget {
  @override
  _CompareWardState createState() => _CompareWardState();
}

class _CompareWardState extends State<CompareWard> {
  List<charts.Series> seriesList;

  List<charts.Series<CompareNPS, String>> _createRandomData() {
    final ward3 = [
      new CompareNPS(
          year: '2020',
          nps: 70,
          barColor: charts.ColorUtil.fromDartColor(Colors.blue)),
      new CompareNPS(
          year: '2019',
          nps: 65,
          barColor: charts.ColorUtil.fromDartColor(Colors.green)),
      new CompareNPS(
          year: '2018',
          nps: 60,
          barColor: charts.ColorUtil.fromDartColor(Colors.red)),
    ];

    final ward20 = [
      new CompareNPS(
          year: '2020',
          nps: 50,
          barColor: charts.ColorUtil.fromDartColor(Colors.blue)),
      new CompareNPS(
          year: '2019',
          nps: 50,
          barColor: charts.ColorUtil.fromDartColor(Colors.green)),
      new CompareNPS(
          year: '2018',
          nps: 40,
          barColor: charts.ColorUtil.fromDartColor(Colors.red)),
    ];

    final ward30 = [
      new CompareNPS(
          year: '2020',
          nps: 45,
          barColor: charts.ColorUtil.fromDartColor(Colors.blue)),
      new CompareNPS(
          year: '2019',
          nps: 60,
          barColor: charts.ColorUtil.fromDartColor(Colors.green)),
      new CompareNPS(
          year: '2018',
          nps: 50,
          barColor: charts.ColorUtil.fromDartColor(Colors.red)),
    ];

    return [
      new charts.Series<CompareNPS, String>(
        id: 'Ward3',
        domainFn: (CompareNPS sales, _) => sales.year,
        measureFn: (CompareNPS sales, _) => sales.nps,
        data: ward3,
        fillColorFn: (CompareNPS sales, _) {
          return charts.MaterialPalette.blue.shadeDefault;
        },
      ),
      new charts.Series<CompareNPS, String>(
        id: 'Ward20',
        domainFn: (CompareNPS sales, _) => sales.year,
        measureFn: (CompareNPS sales, _) => sales.nps,
        data: ward20,
        fillColorFn: (CompareNPS sales, _) {
          return charts.MaterialPalette.green.shadeDefault;
        },
      ),
      new charts.Series<CompareNPS, String>(
        id: 'Ward30',
        domainFn: (CompareNPS sales, _) => sales.year,
        measureFn: (CompareNPS sales, _) => sales.nps,
        data: ward30,
        fillColorFn: (CompareNPS sales, _) {
          return charts.MaterialPalette.red.shadeDefault;
        },
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Nagrik Sewa",style: TextStyle(fontFamily: 'Quicksand')),
        centerTitle: true,
        backgroundColor: Color(0xFFfbab66),
      ),
      body: Container(
        padding: EdgeInsets.all(8),
        child: Column(
          children: <Widget>[
            Text(
              "Ward Comparison (2018-2020)",
              style: TextStyle(fontSize: 20),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 40),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 10,
                  width: 10,
                  child: Container(
                    color: Colors.blue,
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Text("Ward-No 3"),
                SizedBox(width: 20),
                SizedBox(
                  height: 10,
                  width: 10,
                  child: Container(
                    color: Colors.green,
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Text("Ward-No 20"),
                SizedBox(width: 20),
                SizedBox(
                  height: 10,
                  width: 10,
                  child: Container(
                    color: Colors.red,
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Text("Ward-No 30"),
              ],
            ),
            Container(
                height: MediaQuery.of(context).size.height / 2,
                width: MediaQuery.of(context).size.width - 20,
                child: charts.BarChart(
                  seriesList,
                  animate: true,
                  // barRendererDecorator: new charts.BarLabelDecorator<String>(),
                  
                  defaultRenderer: charts.BarRendererConfig(
                    groupingType: charts.BarGroupingType.grouped,
                    strokeWidthPx: 3.0,
                  ),
                  behaviors: [
                    charts.LinePointHighlighter(
                      drawFollowLinesAcrossChart: true,
                      showHorizontalFollowLine:
                          charts.LinePointHighlighterFollowLineType.all,
                    ),
                    new charts.ChartTitle('Year',
                        behaviorPosition: charts.BehaviorPosition.bottom,
                        titleStyleSpec: charts.TextStyleSpec(fontSize: 13),
                        titleOutsideJustification:
                            charts.OutsideJustification.middleDrawArea),
                    new charts.ChartTitle('NPS Score',
                        behaviorPosition: charts.BehaviorPosition.start,
                        titleStyleSpec: charts.TextStyleSpec(fontSize: 13),
                        titleOutsideJustification:
                            charts.OutsideJustification.middleDrawArea)
                  ],
                  barGroupingType: charts.BarGroupingType.grouped,
                )),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    seriesList = _createRandomData();
  }
}
