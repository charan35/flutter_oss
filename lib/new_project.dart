
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_altaoss/project_class.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class NewProject extends StatefulWidget{
  NewProject({Key key,  this.empid, })
      : super(key: key);

  String empid;



  @override
  _NewProjectState createState() => _NewProjectState();

}

class _NewProjectState extends State<NewProject> {

  final _key = new GlobalKey<FormState>();

  String projectname,teamleadername,clientname;

  final FirebaseDatabase _database = FirebaseDatabase.instance;

  String fromdate="0000-00-00",todate="0000-00-00";
  String projectstatus="Running";
  List <String> spinnerItems=[
    'Running',
    'Discussing',
    'Completed',

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
      _submitproject();

    }
  }

  _submitproject() async {
    String Empid=widget.empid;
    String ProjectName=projectname;
    String TeamLeaderName=teamleadername;
    String ClientName=clientname;
    String ProjectStatus=projectstatus;
    String StartDate=fromdate.toString();
    String EndDate=todate.toString();
    String ProjectId=_database.reference().push().key;

    AddProject addProject=new AddProject(ProjectId, Empid, ProjectName, TeamLeaderName, ClientName, StartDate, EndDate, ProjectStatus);

    _database.reference().child("Projects").child(ProjectId).set(addProject.toJson());

    Fluttertoast.showToast(
        msg: "Project added Successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);

  }


  @override
  Widget build(BuildContext context) {

    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    // TODO: implement build
    return Scaffold(
      appBar:AppBar(
        backgroundColor: Colors.blueGrey,
        title: new Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Image.asset('assets/images/logo.png',height: 30.0,width: 30.0,fit: BoxFit.contain,),

            Container(padding: const EdgeInsets.all(8.0),child: Text('AltaOSS'),)
          ],
        ),
      ),

      body:ListView(
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

                    new Text("Add New Project",style: TextStyle(fontWeight: FontWeight.normal,fontSize: _width/15, color: Colors.black,),textAlign: TextAlign.center,),

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
                            return "Please insert Team Leader Name";
                          }
                        },
                        onSaved: (e) => teamleadername = e,
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
                            labelText: "Team Leader Name"),
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
                            return "Please insert Client Name";
                          }
                        },
                        onSaved: (e) => clientname = e,
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
                            labelText: "Client Name"),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),


                    new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[

                        new Text("Start Date:"),
                        new Text("${fromdate}"),
                        new IconButton(icon: Icon(Icons.calendar_today), onPressed:  ()=>_selecFromtDate(context),color: Colors.orangeAccent,)
                        /*new RaisedButton(onPressed: ()=>_selecFromtDate(context),
                          child: Text("Select From Date"),
                        ),*/

                      ],
                    ),

                    SizedBox(
                      height: 25,
                    ),

                    new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[

                        new Text("End Date:"),
                        new Text("${todate}"),
                        new IconButton(icon: Icon(Icons.calendar_today), onPressed:  ()=>_selectToDate(context),color: Colors.orangeAccent,)

                        /*new RaisedButton(onPressed: ()=>_selectToDate(context),
                          child: Text("Select To Date"),
                        ),*/

                      ],
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
                          style: TextStyle(color: Colors.black,fontSize: 18),
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