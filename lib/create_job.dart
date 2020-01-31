

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_altaoss/job_class.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CreateJob extends StatefulWidget{

  CreateJob({Key key, this.empid})
      : super(key: key);

  String empid;

  @override
  _CreateJobState createState() => _CreateJobState();
}

class _CreateJobState extends State<CreateJob>{

  final _key = new GlobalKey<FormState>();

  final FirebaseDatabase _database = FirebaseDatabase.instance;


  String jobtitle,noofvacancies,experience,bondperiod,salary,joblocation,interviewlocation,skillrequirements;

  check() {
    final form = _key.currentState;
    if (form.validate()) {
      form.save();
      _submitcreatejob();
    }
  }


  _submitcreatejob(){

    String JobTitle=jobtitle;
    String NoOfVacancies=noofvacancies;
    String Experience=experience;
    String BondPeriod=bondperiod;
    String Salary=salary;
    String JobLocation=joblocation;
    String InterviewLocation=interviewlocation;
    String SkillRequirements=skillrequirements;
    String JobID=_database.reference().push().key;
    String JEmpid=widget.empid;


    Job job=new Job(JobID, JEmpid, JobTitle, NoOfVacancies, Experience, BondPeriod, Salary, JobLocation, InterviewLocation, SkillRequirements);

    _database.reference().child("JobDetails").child(JobID).set(job.toJson());

    Fluttertoast.showToast(
        msg: "Job Created Successfully",
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

                    new Text("Add New Job",style: TextStyle(fontWeight: FontWeight.normal,fontSize: _width/15, color: Colors.black,),textAlign: TextAlign.center,),

                    SizedBox(
                      height: 25,
                    ),

                    new Card(
                      elevation: 6.0,
                      child: TextFormField(
                        validator: (e) {
                          if (e.isEmpty) {
                            return "Please insert Job Title";
                          }
                        },
                        onSaved: (e) => jobtitle = e,
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
                            labelText: "Job Title"),
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
                            return "Please insert No.of Vacancies";
                          }
                        },
                        onSaved: (e) => noofvacancies = e,
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
                            labelText: "No.of Vacancies"),
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
                            return "Please insert Experience";
                          }
                        },
                        onSaved: (e) => experience = e,
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
                            labelText: "Experience"),
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
                            return "Please insert Bond Period";
                          }
                        },
                        onSaved: (e) => bondperiod = e,
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
                            labelText: "Bond Period"),
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
                            return "Please insert Salary";
                          }
                        },
                        onSaved: (e) => salary = e,
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
                            labelText: "Salary"),
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
                            return "Please insert Job Location";
                          }
                        },
                        onSaved: (e) => joblocation = e,
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
                            labelText: "Job Location"),
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
                            return "Please insert Interview Location";
                          }
                        },
                        onSaved: (e) => interviewlocation = e,
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
                            labelText: "Interview Location"),
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
                            return "Please insert Skill Requirements";
                          }
                        },
                        onSaved: (e) => skillrequirements = e,
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
                            labelText: "Skill Requirements"),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),

                    new FlatButton(onPressed: (){
                      check();

                    },
                      color: Colors.lightBlue,
                      child:
                      new Text("Create Job"),

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