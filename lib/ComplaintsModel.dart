import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ComplaintOfWard {
  final String year;
  final int count;
  final charts.Color barColor;

  ComplaintOfWard(
      {@required this.year,
      @required this.count,
      @required this.barColor});
}

class CompareNPS {
  final int nps;
  final String year;
  final charts.Color barColor;

  CompareNPS(
      {@required this.year,
      @required this.nps,
      @required this.barColor});
}

