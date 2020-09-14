// import 'dart:html';
import 'dart:io';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:major2/auth.dart';
import 'package:toast/toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'MyModel.dart';
import 'package:major2/crud.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:progress_dialog/progress_dialog.dart';

class NewComplaint extends StatefulWidget {
  @override
  _NewComplaintState createState() => _NewComplaintState();
}

class _NewComplaintState extends State<NewComplaint> {
  File _image;
  String _complaintAbout, _objectDetected, _downloadUrl;
  var _response;
  var _imageUrl;
  bool _imageuploaded = false;
  CrudMethods crudObj = new CrudMethods();
  var time = DateTime.now();
  final _formKey = GlobalKey<FormState>();
  ProgressDialog pr;
  TextEditingController _wardController = new TextEditingController();
  TextEditingController _complaintcontroller = new TextEditingController();
  TextEditingController _yearcontroller = new TextEditingController();
  TextEditingController _objectcontroller = new TextEditingController();
  List<String> _dropitems = ['Stray Animals','Inadequate Street Light','Potholes','Trash Disposal','Other'];
  String _selectedType;
  String _upload='Stray Animals';
  

  _inputDecoration(label) => InputDecoration(
      labelText: label,
      fillColor: Colors.white,
      border: new OutlineInputBorder(
          borderRadius: new BorderRadius.circular(18.0),
          borderSide: new BorderSide()));

  Future _getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = image;
    });
    if (_image != null) {
      print("Path" + _image.path);
    } else {
      Toast.show("Image Fetching Unsuccessfull", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    }
  }

  _uploadImage(File file) async {
    Toast.show("msg", context);
    Dio dio = new Dio();
    String fileName = file.path.split('/').last;

    FormData data = FormData.fromMap({
      "file": await MultipartFile.fromFile(
        file.path,
        filename: fileName,
      ),
    });

    //!  RESPONSE FOR API
    _response = "DONE";
    // _response = await dio.post("http://d0a894f9.ngrok.io", data: data, options: Options(
    // method: 'POST',
    // responseType: ResponseType.json
    // ))
    // .then((response) => (){print("response",response);})
    // .catchError((error) => print(error));

    if (_response != null) {
      Toast.show("Response Fetched ", context);
      setState(() {
        _objectDetected = _response;
      });
    } else {
      Toast.show("Error Uploading ", context);
    }
  }

  Future _storageUpload(File file) async {
    final StorageReference storageRef =
        FirebaseStorage.instance.ref().child(time.toIso8601String());
    final StorageUploadTask task = storageRef.putFile(_image);
    // _imageUrl = storageRef.getDownloadURL();
    var url = await (await task.onComplete).ref.getDownloadURL();
    setState(() {
      _downloadUrl = url.toString();
      print(_downloadUrl);
      Toast.show('urlll' + url.toString(), context);
    });
    return url.toString();
  }

  Future<void> _firebaseUpload(File file) async {
    if (file == null) {
      Toast.show("Error, please fill all the fields !", context);
    } else {
        // pr.show();
       _uploadImage(file);
        _downloadUrl = await _storageUpload(file);
        if(_formKey.currentState.validate()){
        _formKey.currentState.save();
       Firestore.instance.collection('complaints').add({
          'UserId': appData.uid,
          'Location': appData.cAdrs,
          'WardNo': _wardController.text,
          'ComplaintYear': time.year.toString(),
          'ComplaintAbout': _upload,
          'ImageUrl': _downloadUrl,
          'ObjectDetected': '3',
        }
            // {'UserId':appData.uid,'Location':appData.cAdrs,'WardNo':1,'ComplaintYear':time.year,'ComplaintAbout':_complaintAbout,'ImageUrl':_downloadUrl,'ObjectDetected':_objectDetected,}
            ).catchError((e) {
          print(e);
        });
      // pr.dismiss();
      _formKey.currentState.reset();
      Toast.show("Complaint Registered", context);
        }else{
      Toast.show("Fill all values", context);

        }
    }
  }

  @override
  Widget build(BuildContext context) {
    const primaryColor = const Color(0xFFfbab66);
    pr = new ProgressDialog(context);
    pr.style(
        message: 'Registering your Complaint',
        borderRadius: 10.0,
        backgroundColor: Colors.white,
        progressWidget: CircularProgressIndicator(),
        elevation: 10.0,
        insetAnimCurve: Curves.easeInOut,
        progress: 0.0,
        maxProgress: 100.0,
        progressTextStyle: TextStyle(
            color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
        messageTextStyle: TextStyle(
            color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600));

    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(left: 8, bottom: 8, right: 8, top: 15),
      child: Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            TextFormField(
              key: new Key('Current Location'),
              decoration: _inputDecoration("Current Location"),
              readOnly: true,
              enabled: false,
              initialValue: appData.cAdrs,
              style: TextStyle(),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: _wardController,
              key: new Key('Ward No'),
              decoration: _inputDecoration("Ward No"),
              //  readOnly: true,
              //  enabled: false,
              //  initialValue: time.year.toString(),
              keyboardType: TextInputType.number,
              style: TextStyle(),
            ),
            SizedBox(
              height: 10,
            ),
            DropdownButton<String>(
              items:_dropitems.map((String val){
                return DropdownMenuItem<String>(
                  value: val,
                  child: new Text(val),
                );
              }).toList(),
             hint:Text("Select Complaint Reason"),
              value: _selectedType,
              onChanged: ((value){
                  _selectedType = value;
                setState(() {
                  print("sle"+_selectedType);
                  _upload = _selectedType;
                });
              })
              ),
            // TextFormField(
            //   controller: _ComplaintController,
            //   key: new Key('Complaint About'),
            //   decoration: _inputDecoration("Complaint About"),             
            //   validator: (val) => val.length<2 ? 'Value too short.' : null,
            //   onSaved: (val) => _complaintAbout = val.toString(),
            //   style: TextStyle(),
            // ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              // controller: _yearcontroller,
              key: new Key('Complaint Date'),
              decoration: _inputDecoration("Complaint Year"),
               readOnly: true,
               enabled: false,
              initialValue: time.year.toString(),
              keyboardType: TextInputType.number,
            ),
            SizedBox(
              height: 10,
            ),
            // TextFormField(
            //   controller: _objectcontroller,
            //   key: new Key('Object Detected'),
            //   decoration: _inputDecoration("Object Detected"),
            //   keyboardType: TextInputType.number,
            //   style: TextStyle(),
            // ),
            // SizedBox(
            //   height: 10,
            // ),
            SizedBox(
              width: double.infinity,
              child: RaisedButton(
                onPressed: () {
                  _getImage();
                },
                color: primaryColor,
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(18.0),
                    side: BorderSide(color: primaryColor)),
                textColor: Colors.white,
                elevation: 10,
                child: Text("Select Image"),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: _image != null ? Image.file(_image) : null,
            ),
            RaisedButton(
              onPressed: () {
                _firebaseUpload(_image);
              },
              color: primaryColor,
              shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(18.0),
                  side: BorderSide(color: primaryColor)),
              textColor: Colors.white,
              elevation: 10,
              child: Text("Log Complaint"),
            )
          ],
        ),
      ),
    );
  }
}
