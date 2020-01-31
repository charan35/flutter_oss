



import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_altaoss/event_class.dart';
import 'package:flutter_altaoss/events_activity.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class CalendarActivity extends StatefulWidget{


  @override
  _CalendarState createState() => _CalendarState();
}



class _CalendarState extends State<CalendarActivity>{

  final _key = new GlobalKey<FormState>();

  String eventname,eventdescription,fromdate="0000-00-00",todate="0000-00-00";

  final FirebaseDatabase _database = FirebaseDatabase.instance;

  static const List<String> choices = <String>[
    "Query",
    "Public Holiday",
    "Events"
  ];

  DateTime selectFromDate=DateTime.now();

  DateTime selectToDate=DateTime.now();

  Future<Null> _selecFromtDate(BuildContext context)async{
    final DateTime picked = await showDatePicker(context: context, initialDate: selectFromDate, firstDate: DateTime(2015,8), lastDate: DateTime(2101));
    if(picked !=null&& picked !=selectFromDate){
      setState(() {
        selectFromDate=picked;
        fromdate =  DateFormat('yyyy-MM-dd').format(selectFromDate);


      });
    }
  }

  Future<Null> _selectToDate(BuildContext context)async{
    final DateTime picked = await showDatePicker(context: context, initialDate: selectToDate, firstDate: DateTime(2015,8), lastDate: DateTime(2101));
    if(picked !=null&& picked !=selectToDate){
      setState(() {
        selectToDate=picked;
        todate =  DateFormat('yyyy-MM-dd').format(selectToDate);
      });
    }
  }

  check() {
    final form = _key.currentState;
    if (form.validate()) {
      form.save();
      _addEvent();
    }
  }

  _addEvent(){

    String EventName=eventname;
    String Godate=fromdate;
    String ToDate=todate;
    String EventDescr=eventdescription;
    String EventId=_database.reference().push().key;

    EventClass event = new EventClass(EventId, EventName, Godate, ToDate, EventDescr);

    _database.reference().child("Events").child(EventId).set(event.toJson());

    Fluttertoast.showToast(
        msg: "Event Created Successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);

  }
  

  void choiceAction(String choice){
    if(choice == "Query"){

    }
    else if(choice=="Public Holiday"){

    }
    else if(choice == "Events"){

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => EventsActivity(),
        ),
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
        actions: <Widget>[
          
          PopupMenuButton<String>(
            onSelected: choiceAction,
           icon: Icon(Icons.more_vert),
            itemBuilder: (BuildContext context){
              return choices.map((String choice){
                return PopupMenuItem<String>(
                  value:choice,
                  child: Text(choice),
                );
              }).toList();
          }
          )
        ],
      ),
      body:  ListView(
        shrinkWrap: true,
        padding: EdgeInsets.all(15.0),
        children: <Widget>[
          new Center(
            child: new Container(

              padding: const EdgeInsets.all(8.0),
              color: Colors.blue,

              child: Form(
                key: _key,
                child: new Column(
                  children: <Widget>[

                    new Text("Add New Events",style: TextStyle(fontWeight: FontWeight.normal,fontSize: _width/15, color: Colors.black,),textAlign: TextAlign.center,),

                    SizedBox(
                      height: 25,
                    ),

                    new Card(
                      elevation: 6.0,
                      child: TextFormField(
                        validator: (e) {
                          if (e.isEmpty) {
                            return "Please insert Event Name";
                          }
                        },
                        onSaved: (e) => eventname = e,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                        ),
                        decoration: InputDecoration(
                            prefixIcon: Padding(
                              padding: EdgeInsets.only(left: 20, right: 15),

                            ),
                            contentPadding: EdgeInsets.all(18),
                            labelText: "Event Name"),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[

                        new Text("From Date:"),
                        new Text("${fromdate}"),
                        new IconButton(icon: Icon(Icons.calendar_today), onPressed:  ()=>_selecFromtDate(context),color: Colors.orangeAccent,)

                      ],
                    ),

                    SizedBox(
                      height: 25,
                    ),

                    new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[

                        new Text("To Date:"),
                        new Text("${todate}"),
                        new IconButton(icon: Icon(Icons.calendar_today), onPressed:  ()=>_selectToDate(context),color: Colors.orangeAccent,)

                      ],
                    ),

                    new Card(
                      elevation: 6.0,
                      child: TextFormField(
                        validator: (e) {
                          if (e.isEmpty) {
                            return "Please insert Description";
                          }
                        },
                        onSaved: (e) => eventdescription = e,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                        ),
                        decoration: InputDecoration(
                            prefixIcon: Padding(
                              padding: EdgeInsets.only(left: 20, right: 15),

                            ),
                            contentPadding: EdgeInsets.all(18),
                            labelText: "Event Description"),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),

                    new FlatButton(onPressed: (){
                      check();

                    },
                      color: Colors.black,
                      child:
                      new Text("Create Event",style: TextStyle(color: Colors.white),),

                    ),



                  ],
                ),
              ),


            ),
          ),
        ],
      ),
    );
  }


}