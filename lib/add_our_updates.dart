

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_altaoss/our_updates_class.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class AddNewUpdate extends StatefulWidget{

  AddNewUpdate({Key key,  this.empid, })
      : super(key: key);

  String empid;

  @override
  _AddNewUpdateState createState() => _AddNewUpdateState();
}

class _AddNewUpdateState extends State<AddNewUpdate>{

  final _key = new GlobalKey<FormState>();

  String projectname,notes,updatedto;
  String date="0000-00-00";

  String projectstatus='Select Project Status';
  List <String> spinnerItems=[

    'Select Project Status',
    'Running',
    'Discussing',
    'Completed',

  ];



  final FirebaseDatabase _database = FirebaseDatabase.instance;


 /* Future<Null> _selectDate(BuildContext context)async{
    final DateTime picked = await showDatePicker(context: context, initialDate: selectDate, firstDate: DateTime(2015,8), lastDate: DateTime(2101));
    if(picked !=null&& picked !=selectDate){
      setState(() {
        selectDate=picked;
        date =  DateFormat('yyyy-MM-dd').format(selectDate);


      });
    }
  }*/

 _selectDate(){
   DateTime selectDate=DateTime.now();
   setState(() {
     date=DateFormat('yyyy-MM-dd').format(selectDate);
   });

 }

  check() {
    final form = _key.currentState;
    if (form.validate()) {
      form.save();
      _submitourupdate();
    }
  }

  _submitourupdate() async {
    String Empid=widget.empid;
    String ProjectName=projectname.toString();
    String Notes= notes.toString();
    String Date=date.toString();

    String UpdatedTo=updatedto.toString();
    String ProjectStatus=projectstatus.toString();
    String Utype="Updates";
    String Updatedid=_database.reference().push().key;

    OurUpDatesForm ourUpDatesForm = new OurUpDatesForm(ProjectName,Date,Empid,Notes,ProjectStatus,UpdatedTo,Updatedid,Utype);

    _database.reference().child("OurUpdates").child(Updatedid).set(ourUpDatesForm.toJson());

    Fluttertoast.showToast(
        msg: "Updated Successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);


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

                    new Text("Add New Update",style: TextStyle(fontWeight: FontWeight.normal,fontSize: _width/15, color: Colors.black,),textAlign: TextAlign.center,),

                    SizedBox(
                      height: 25,
                    ),

                    new Card(
                      elevation: 6.0,
                      child: TextFormField(
                        validator: (e) {
                          if (e.isEmpty) {
                            return "Please insert Project Name";
                          }
                        },
                        onSaved: (e) => projectname = e,
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
                            labelText: "Project Name"),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    new Card(
                      elevation: 6.0,
                      child: TextFormField(
                        validator: (e) {
                          if (e.isEmpty) {
                            return "Please insert Notes";
                          }
                        },
                        onSaved: (e) => notes = e,
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
                            labelText: "Notes"),
                      ),
                    ),

                    SizedBox(
                      height: 25,
                    ),

                    new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        new Text("Project Status",style: TextStyle(fontWeight: FontWeight.normal,fontSize: _width/20,color: Colors.black),),
                        new DropdownButton<String>(
                          value: projectstatus,
                          icon: Icon(Icons.arrow_drop_down),
                          iconSize: 24,
                          elevation: 16,
                          style: TextStyle(color: Colors.red,fontSize: 18),
                          underline: Container(
                            height: 2,
                            color: Colors.black,
                          ),
                          onChanged: (String data){
                            setState(() {
                              projectstatus=data;
                            });
                          },
                          items: spinnerItems.map<DropdownMenuItem<String>>((String value){
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 25,
                    ),

                    new Card(
                      elevation: 6.0,
                      child: TextFormField(
                        validator: (e) {
                          if (e.isEmpty) {
                            return "Please insert Updated to";
                          }
                        },
                        onSaved: (e) => updatedto = e,
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
                            labelText: "Updated to"),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),


                    new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[

                        new Text("Date"),
                        new Text("${date}"),
                        new IconButton(icon: Icon(Icons.calendar_today), onPressed:  ()=>_selectDate(),color: Colors.orangeAccent,)

                      ],
                    ),

                    new FlatButton(onPressed: (){
                      check();

                    },
                      color: Colors.amber,
                      child:
                      new Text("Submit"),

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