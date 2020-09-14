import 'package:geolocator/geolocator.dart';

class MyModel {
  static final MyModel _appData = new MyModel._internal();
  
  Position cPosition;
  String cAdrs;
  var uid;

  factory MyModel() {
    return _appData;
  }
  MyModel._internal();
}
final appData = MyModel();