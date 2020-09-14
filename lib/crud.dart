import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CrudMethods{
  
  
  bool isLoggedIn(){
    if (FirebaseAuth.instance.currentUser() != null){
      return true;
    }else{
      return false;
    }
  }

  Future<void> addData(complaintData) async{
    if(isLoggedIn()){
      Firestore.instance.collection('complaints').add(complaintData).catchError((e){
        print(e);
      });
    }
  }

  getData() async{
    var _usr = await FirebaseAuth.instance.currentUser();
        String my = _usr.uid;
        print('my '+my);
        // return Firestore.instance.collection('complaints').getDocuments();
    return await Firestore.instance.collection('complaints').where('UserId',isEqualTo:my).getDocuments();
  }

  



}