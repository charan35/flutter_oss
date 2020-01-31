

import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'event_class.dart';

class EventsActivity extends StatefulWidget{


  @override
  _EventsActivityState createState() => _EventsActivityState();

}

class _EventsActivityState extends State<EventsActivity>{

  final FirebaseDatabase _database = FirebaseDatabase.instance;

  Query query;

  List<EventClass> _eventslist;

  StreamSubscription<Event> _onEventAddedSubscription;
  StreamSubscription<Event> _onEventChangedSubscription;

  @override
  void initState() {

    _eventslist = new List();

    query=_database.reference().child("Events");

    _onEventAddedSubscription = query.onChildAdded.listen(onEntryAdded);
    _onEventChangedSubscription=query.onChildChanged.listen(onEntryChanged);

  }

  @override
  void dispose() {
    _onEventChangedSubscription.cancel();
    _onEventAddedSubscription.cancel();
    super.dispose();
  }

  onEntryChanged(Event event){
    var oldEntry = _eventslist.singleWhere((events)=>events.key==event.snapshot.key);
    setState(() {
      _eventslist[_eventslist.indexOf(oldEntry)]=new EventClass.fromSnapshot(event.snapshot);
    });

  }

  onEntryAdded(Event event){
    setState(() {
      _eventslist.add(new EventClass.fromSnapshot(event.snapshot));
    });
  }
  Widget showEventsList(){

    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;

    if(_eventslist.length>0){
      return Expanded(child: ListView.builder(shrinkWrap:true,

          itemCount: _eventslist.length,
          itemBuilder: (BuildContext context,int index){

            String key = _eventslist[index].key;
            String EventId=_eventslist[index].eventid;
            String Eventname=_eventslist[index].eventname;
            String EventDesc=_eventslist[index].eventdes;
            String GoDate=_eventslist[index].godate;
            String ToDate=_eventslist[index].todate;


            return new Card(
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[

                  new Text(Eventname,style: TextStyle(fontWeight: FontWeight.normal,fontSize: _width/25, color: Colors.redAccent,),textAlign: TextAlign.start,),

                  new Column(
                    mainAxisAlignment: MainAxisAlignment.start,

                    children: <Widget>[
                      new Text(EventDesc,style: TextStyle(fontWeight: FontWeight.normal,fontSize: _width/25, color: Colors.blue,),textAlign: TextAlign.start,),
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          new Text("From Date"+GoDate,style: TextStyle(fontWeight: FontWeight.normal,fontSize: _width/30, color: Colors.black54,),textAlign: TextAlign.start,),
                          new Text("To Date"+ToDate,style: TextStyle(fontWeight: FontWeight.normal,fontSize: _width/30, color: Colors.black54,),textAlign: TextAlign.start,),
                        ],
                      )

                    ],
                  ),
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

    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    // TODO: implement build
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          new Text("Events",style: TextStyle(fontWeight: FontWeight.normal,fontSize: _width/15, color: Colors.orangeAccent,),textAlign: TextAlign.center,),

            showEventsList(),


        ],
      ),
    );
  }


}