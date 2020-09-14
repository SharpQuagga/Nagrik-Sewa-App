import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:major2/CompareResult.dart';
import 'package:major2/ComplaintsModel.dart';

final List<ComplaintOfWard> data = [
  ComplaintOfWard(
    year: "2020",
    count: 40,
    barColor: charts.ColorUtil.fromDartColor(Colors.blue),
  ),
  ComplaintOfWard(
    year: "2019",
    count: 50,
    barColor: charts.ColorUtil.fromDartColor(Colors.orange),
  ),
  ComplaintOfWard(
    year: "2018",
    count: 45,
    barColor: charts.ColorUtil.fromDartColor(Colors.red),
  ),
];

class Results extends StatefulWidget {
  @override
  _ResultsState createState() => _ResultsState();
}

class _ResultsState extends State<Results> {
  // String _selectedWardNo;

  @override
  Widget build(BuildContext context) {
    List<charts.Series<ComplaintOfWard, String>> series = [
      charts.Series(
          id: "Complaints",
          data: data,
          domainFn: (ComplaintOfWard series, _) => series.year,
          measureFn: (ComplaintOfWard series, _) => series.count,
          colorFn: (ComplaintOfWard series, _) => series.barColor)
    ];

    return Column(
      children: <Widget>[
        SizedBox(height: 20),
        Text(
          "Complaint Count (2018-2020)",
          style: TextStyle(fontSize: 20),
        ),
        SizedBox(
          height: 20,
        ),
        Text("Councellor: Mr.Harjeet Singh"),
        SizedBox(
          height: 10,
        ),
        Text("Ward NPS Score: 70"),
        SizedBox(
          height: 20,
        ),
        Expanded(
            child: Container(
          height: MediaQuery.of(context).size.height / 2,
          padding: EdgeInsets.all(20),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: charts.BarChart(series, animate: true),
                  ),
                ],
              ),
            ),
          ),
        )),
        RaisedButton(
          color: Color(0xFFfbab66),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>CompareWard()));
          },
          child: Text("Compare Result",style: TextStyle(fontFamily: 'Quicksand',color: Colors.white),),
        ),
      ],
    );
  }
}
