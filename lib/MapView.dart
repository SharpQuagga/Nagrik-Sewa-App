import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:toast/toast.dart';
import 'MyModel.dart';

class MapView extends StatefulWidget {
  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {

  List<Marker> allMarker = [];
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
    Position _currentPosition;
    String _currentAddress;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    allMarker.add(Marker(
      markerId: MarkerId("MyMarker"),
      draggable: false,
      
      position: LatLng(30.9010,75.8573),
      // position: LatLng(_currentPosition.latitude,_currentPosition.longitude),
    ));
  }

_getCurrentLocation() {
    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        if (position != null){
            _currentPosition = position;
            appData.cPosition = _currentPosition;
            allMarker.clear();
          final marker = Marker(
              markerId: MarkerId("curr_loc"),
              position: LatLng(_currentPosition.latitude, _currentPosition.longitude),
              onTap: (){
                  Toast.show("This is your current location", context);
                },
              infoWindow: InfoWindow(title: 'Your Location'),
          );
          allMarker.add(marker);
        }
      });
      _getAddressFromLatLng();
    }).catchError((e) {
      print(e);
    });
  }


  _getAddressFromLatLng() async {
    try {
      List<Placemark> p = await geolocator.placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);

      Placemark place = p[0];
      Toast.show("Current Location ${place.subLocality}", context);
      setState(() {
        _currentAddress = "${place.subLocality}";
        appData.cAdrs = _currentAddress;
      });
    } catch (e) {
      print(e);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(30.9010,75.8573),
          zoom: 12.0
        ),
        markers: Set.from(allMarker),
      ),
    );
  }


}