

import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_altaoss/create_job.dart';
import 'package:flutter_altaoss/job_class.dart';
import 'package:flutter_altaoss/job_details.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Careers extends StatefulWidget{
  Careers({Key key, this.empid})
      : super(key: key);

  String empid;
  @override
  _CareersState  createState() => _CareersState();
}

class _CareersState extends State<Careers> {


  final FirebaseDatabase _database = FirebaseDatabase.instance;

  Query query;

  List<Job> _jobsList;

  StreamSubscription<Event> _onJobAddedSubscription;
  StreamSubscription<Event> _onJobChangedSubscription;

  @override
  void initState() {

    _jobsList = new List();

    query=_database.reference().child("JobDetails");

    _onJobAddedSubscription = query.onChildAdded.listen(onEntryAdded);
    _onJobChangedSubscription=query.onChildChanged.listen(onEntryChanged);

  }

  @override
  void dispose() {
    _onJobChangedSubscription.cancel();
    _onJobAddedSubscription.cancel();
    super.dispose();
  }

  onEntryChanged(Event event){
    var oldEntry = _jobsList.singleWhere((jobs)=>jobs.key==event.snapshot.key);
    setState(() {
      _jobsList[_jobsList.indexOf(oldEntry)]=new Job.fromSnapshot(event.snapshot);
    });

  }

  onEntryAdded(Event event){
    setState(() {
      _jobsList.add(new Job.fromSnapshot(event.snapshot));
    });
  }



  Widget showJobsList(){

    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;

    if(_jobsList.length>0){
      return Expanded(child: ListView.builder(shrinkWrap:true,

          itemCount: _jobsList.length,
          itemBuilder: (BuildContext context,int index){

            String key = _jobsList[index].key;
            String jobid=_jobsList[index].jobid;
            String jempid=_jobsList[index].jempid;
            String jobtitle=_jobsList[index].jobtitle;
            String vacancies=_jobsList[index].vacancies;
            String experience=_jobsList[index].experience;
            String bondperiod=_jobsList[index].bondperiod;
            String salary=_jobsList[index].salary;
            String joblocation=_jobsList[index].joblocation;
            String interviewlocation=_jobsList[index].interviewlocation;
            String skillrequirements=_jobsList[index].skillrequirements;

            return new Card(

              child: new InkWell(

                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => JobDetails(jobid: jobid,jobtitle: jobtitle,vacancies: vacancies,experience: experience,
                      bond: bondperiod,salary: salary,jobloc: joblocation,intervieloc: interviewlocation,skill: skillrequirements,),
                    ),
                  );
                },
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[

                    new Text(jobtitle,style: TextStyle(fontWeight: FontWeight.normal,fontSize: _width/25, color: Colors.lightBlue,),textAlign: TextAlign.start,),
                    new Text("No.Of Vacancies:"+vacancies,style: TextStyle(fontWeight: FontWeight.normal,fontSize: _width/30, color: Colors.black,),textAlign: TextAlign.start,),
                    new Text("Job Location:"+joblocation,style: TextStyle(fontWeight: FontWeight.normal,fontSize: _width/30, color: Colors.black,),textAlign: TextAlign.start,),
                    new Text("Experience:"+experience,style: TextStyle(fontWeight: FontWeight.normal,fontSize: _width/30, color: Colors.black54,),textAlign: TextAlign.end,),
                    new Text("Salary:"+salary,style: TextStyle(fontWeight: FontWeight.normal,fontSize: _width/30, color: Colors.black54,),textAlign: TextAlign.end,),
                  ],
                ),
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
        actions: <Widget>[
          IconButton(
            onPressed: () {
              if((widget.empid.startsWith("A"))||(widget.empid.startsWith("H"))){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CreateJob(empid: widget.empid,),
                  ),
                );
              }
              else{
                Fluttertoast.showToast(
                    msg: "You Don't Have Permission to Access",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIos: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0);
              }
            },
            icon: Icon(Icons.assignment,color: Colors.white,),
          )
        ],
      ),
      body: new Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          new Text("Jobs List",style: TextStyle(fontWeight: FontWeight.normal,fontSize: _width/15, color: Colors.orangeAccent,),textAlign: TextAlign.center,),

          showJobsList(),




        ],
      ),
    );
  }
}