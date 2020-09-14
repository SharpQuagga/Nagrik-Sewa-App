import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:major2/crud.dart';

class MyComplaint extends StatefulWidget {
  @override
   _MyComplaintState createState() => _MyComplaintState();
}
class _MyComplaintState extends State<MyComplaint> {
    QuerySnapshot _myComplaints;
    CrudMethods crudObj = new CrudMethods();

  @override
  void initState() {
    super.initState();
    crudObj.getData().then((resutls){
      setState(() {
      _myComplaints = resutls;
      print("com "+_myComplaints.documents[0].data['ComplaintAbout']);
      });
    });
  }

     _carList(){
      if (_myComplaints != null){
       return ListView.builder(
          itemCount: _myComplaints.documents.length,
          padding: EdgeInsets.all(5),
          itemBuilder: (context,i){
            return Card(
              elevation: 20,
              shadowColor: Colors.white24,
                child: ListTile(
                title: Text(_myComplaints.documents[i].data['ComplaintAbout']),
                subtitle: Text(_myComplaints.documents[i].data['Location']),
              ),
            );
          },
        );
      }else{
        return Center(
          child: Text("You have not logged any complaint."),
        );
      }
    }



   @override
   Widget build(BuildContext context) {
    return _carList();
  }
} 