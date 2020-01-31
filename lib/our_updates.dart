

import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_altaoss/add_our_updates.dart';
import 'package:flutter_altaoss/our_updates_class.dart';

class OurUpdates extends StatefulWidget{

  OurUpdates({Key key,  this.empid, })
      : super(key: key);

  String empid;

  @override
  _OurUpdatesState createState() => _OurUpdatesState();
}

class _OurUpdatesState extends State<OurUpdates> {


  final FirebaseDatabase _database = FirebaseDatabase.instance;

  Query query;

  List<OurUpDatesForm> _updateslist;

  StreamSubscription<Event> _onUpdateAddedSubscription;
  StreamSubscription<Event> _onUpdateChangedSubscription;

  @override
  void initState() {

    _updateslist = new List();

    query=_database.reference().child("OurUpdates");

    _onUpdateAddedSubscription = query.onChildAdded.listen(onEntryAdded);
    _onUpdateChangedSubscription=query.onChildChanged.listen(onEntryChanged);

  }

  @override
  void dispose() {
    _onUpdateChangedSubscription.cancel();
    _onUpdateAddedSubscription.cancel();
    super.dispose();
  }

  onEntryChanged(Event event){
    var oldEntry = _updateslist.singleWhere((updates)=>updates.key==event.snapshot.key);
    setState(() {
      _updateslist[_updateslist.indexOf(oldEntry)]=new OurUpDatesForm.fromSnapshot(event.snapshot);
    });

  }

  onEntryAdded(Event event){
    setState(() {
      _updateslist.add(new OurUpDatesForm.fromSnapshot(event.snapshot));
    });
  }



  Widget showOurUpdatesList(){

    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;

    if(_updateslist.length>0){
      return Expanded(child: ListView.builder(shrinkWrap:true,

          itemCount: _updateslist.length,
          itemBuilder: (BuildContext context,int index){

            String key = _updateslist[index].key;
            String empid=_updateslist[index].empid;
            String projectname=_updateslist[index].projectname;
            String date=_updateslist[index].date;
            String notes=_updateslist[index].notes;
            String taskstatus=_updateslist[index].taskstatus;
            String updatedby=_updateslist[index].updatedby;
            String updateid=_updateslist[index].updateid;
            String utype=_updateslist[index].uype;

            return new Card(
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[

                  new Text(empid,style: TextStyle(fontWeight: FontWeight.normal,fontSize: _width/25, color: Colors.redAccent,),textAlign: TextAlign.start,),
                  new Text(projectname,style: TextStyle(fontWeight: FontWeight.normal,fontSize: _width/25, color: Colors.blue,),textAlign: TextAlign.start,),
                  new Text(taskstatus,style: TextStyle(fontWeight: FontWeight.normal,fontSize: _width/30, color: Colors.black,),textAlign: TextAlign.start,),
                  new Text(date,style: TextStyle(fontWeight: FontWeight.normal,fontSize: _width/30, color: Colors.black54,),textAlign: TextAlign.end,),



                  //new Divider(height: _height/30,color: Colors.black),
                ],
              ),
            );

          }),
      );

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

    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: new Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Image.asset('assets/images/logo.png',height: 30.0,width: 30.0,fit: BoxFit.contain,),

            Container(padding: const EdgeInsets.all(8.0),child: Text('AltaOSS'),)
          ],
        ),
      ),

      body:new Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            new Text("Our Updates",style: TextStyle(fontWeight: FontWeight.normal,fontSize: _width/15, color: Colors.orangeAccent,),textAlign: TextAlign.center,),

            showOurUpdatesList(),

             Align(
              alignment: FractionalOffset.bottomCenter,
              child: new FlatButton(onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddNewUpdate(
                    empid: widget.empid,
                  )
                  ),
                );

              },

                color: Colors.amber,
                child:
                new Text("New Update"),

              ),
            ),


          ],
        ),



    );
  }


}