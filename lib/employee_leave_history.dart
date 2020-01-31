


import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_altaoss/apply_leave_form_class.dart';

class EmployeeLeaveHistory extends StatefulWidget{

  EmployeeLeaveHistory({Key key, this.empid})
      : super(key: key);

  String empid;

  @override
  State<StatefulWidget> createState() => new _EmployeeLeaveHistoryState();
}

class _EmployeeLeaveHistoryState extends State<EmployeeLeaveHistory>{

  List<ApplyLeaveForm> _leavehistory;

  final FirebaseDatabase _database = FirebaseDatabase.instance;

  Query query;

  StreamSubscription<Event> _onLeaveAddedSubscription;
  StreamSubscription<Event> _onLeaveChangedSubscription;

  @override
  void initState() {
    _leavehistory = new List();

    query=_database.reference().child("Leaves").orderByChild("empid").equalTo(widget.empid);

    _onLeaveAddedSubscription = query.onChildAdded.listen(onEntryAdded);
    _onLeaveChangedSubscription=query.onChildChanged.listen(onEntryChanged);

  }


  @override
  void dispose() {
    _onLeaveChangedSubscription.cancel();
    _onLeaveAddedSubscription.cancel();
    super.dispose();
  }

  onEntryChanged(Event event){
    var oldEntry = _leavehistory.singleWhere((leaves)=>leaves.key==event.snapshot.key);
    setState(() {
      _leavehistory[_leavehistory.indexOf(oldEntry)]=new ApplyLeaveForm.fromSnapshot(event.snapshot);
    });

  }

  onEntryAdded(Event event){
    setState(() {
      _leavehistory.add(new ApplyLeaveForm.fromSnapshot(event.snapshot));
    });
  }


  Widget showLeaveHistory(){

    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;

    if(_leavehistory.length>0){
      return Expanded(child: ListView.builder(shrinkWrap:true,
          itemCount: _leavehistory.length,
          itemBuilder: (BuildContext context,int index){
            String leavehistoryId = _leavehistory[index].key;
            String empid=_leavehistory[index].empid;
            String leavetype=_leavehistory[index].leavetype;
            String fromdate=_leavehistory[index].fromdate;
            String todate=_leavehistory[index].todate;
            String noofdays=_leavehistory[index].noofdays;
            String applyto=_leavehistory[index].applyto;
            String reason=_leavehistory[index].reason;
            String status=_leavehistory[index].status;
            String month=_leavehistory[index].month;
            String year=_leavehistory[index].year;
            String monthandyear=_leavehistory[index].monthandyear;
            String empidmonthandyear=_leavehistory[index].empidmonthandyear;
            String empidyear=_leavehistory[index].empidyear;
            String description=_leavehistory[index].description;


            return Card(
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  new Text(empid,style: TextStyle(fontWeight: FontWeight.bold, fontSize: _width/20, color: Colors.blue,),textAlign: TextAlign.left,),
                  new Text("Leave type: "+leavetype,style: TextStyle(fontWeight: FontWeight.bold, fontSize: _width/25, color: Colors.amber),textAlign: TextAlign.left,),
                  new Text("From Date: "+fromdate,style: TextStyle(fontWeight: FontWeight.normal, fontSize: _width/30, color: Colors.black87),textAlign: TextAlign.left,),
                  new Text("To date: "+todate,style: TextStyle(fontWeight: FontWeight.normal, fontSize: _width/30, color: Colors.black87),textAlign: TextAlign.left,),
                  new Text("No.ofdays: "+noofdays,style: TextStyle(fontWeight: FontWeight.bold, fontSize: _width/30, color: Colors.black87),textAlign: TextAlign.left,),
                  new Text(applyto,style: TextStyle(fontWeight: FontWeight.normal, fontSize: _width/25, color: Colors.black87),textAlign: TextAlign.left,),
                  new Text(description,style: TextStyle(fontWeight: FontWeight.normal, fontSize: _width/25, color: Colors.blueGrey),textAlign: TextAlign.left,),
                  if(status=="Leave Request")
                    new Text(status,style: TextStyle(fontWeight: FontWeight.bold, fontSize: _width/25, color: Colors.lightBlue),textAlign: TextAlign.left,),
                  if(status=="Approved")
                    new Text(status,style: TextStyle(fontWeight: FontWeight.bold, fontSize: _width/25, color: Colors.teal),textAlign: TextAlign.left,),
                  if(status=="Rejected")
                    new Text(status,style: TextStyle(fontWeight: FontWeight.bold, fontSize: _width/25, color: Colors.redAccent),textAlign: TextAlign.left,),
                ],
              ),
            );
          }),);

    }
    else{
      return Center(
        child:const CircularProgressIndicator(),

      );
    }

  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
      appBar:  AppBar(
        backgroundColor: Colors.blueGrey,
        title: new Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Image.asset('assets/images/logo.png',height: 30.0,width: 30.0,fit: BoxFit.contain,),

            Container(padding: const EdgeInsets.all(8.0),child: Text('AltaOSS'),)
          ],
        ),      ),

      body: new Column(
        children: <Widget>[

          showLeaveHistory(),
        ],
      ),



    );
  }

}