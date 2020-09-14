import 'package:flutter/material.dart';
import 'package:major2/auth.dart';
import './MapView.dart';
import './MyComplaints.dart';
import './Results.dart';
import './NewComplaints.dart';


class OptionPage extends StatefulWidget {
  @override
   _OptionPageState createState() => _OptionPageState();
}
class _OptionPageState extends State<OptionPage> {

  int _selectedPage = 0;
  final pageOptions = [
    MapView(),
    MyComplaint(),
    NewComplaint(),
    Results()
  ];

   @override
   Widget build(BuildContext context) {
     const primaryColor = const Color(0xFFfbab66);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
       home: Scaffold(
         appBar: AppBar(
           centerTitle: true,
           backgroundColor: primaryColor,
           title: Text("Nagrik Sewa",style: TextStyle(fontFamily: 'Quicksand'),),),
         bottomNavigationBar: BottomNavigationBar(
           currentIndex: _selectedPage,
           backgroundColor: Colors.purple,
          selectedLabelStyle: TextStyle(fontSize: 13),
           elevation: 30,
           unselectedItemColor: Colors.grey,
           selectedItemColor: Colors.black,
           selectedFontSize: 10,
           onTap: (int index){
             setState(() {
               _selectedPage = index;
             });
           },
           items: [
             BottomNavigationBarItem(
               icon: Icon(Icons.map),
               backgroundColor: Colors.grey[50],
               title: Text("Map View")
             ),
             BottomNavigationBarItem(
               icon: Icon(Icons.account_circle),
               title: Text("My Complaints")
             ),
             BottomNavigationBarItem(
               icon: Icon(Icons.backup),
               title: Text("New Complaints")
             ),
             BottomNavigationBarItem(
               icon: Icon(Icons.assessment),
               title: Text("Results")
             ),
           ],
         ),
         body: pageOptions[_selectedPage]
       ),
    );
  }
} 