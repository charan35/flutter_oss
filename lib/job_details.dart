

import 'package:flutter/material.dart';

class JobDetails extends StatefulWidget{

  JobDetails({Key key, this.jobid,this.jobtitle,this.vacancies,this.experience,this.bond,this.salary,this.jobloc,this.intervieloc,this.skill})
      : super(key: key);

  String jobid,jobtitle,vacancies,experience,bond,salary,jobloc,intervieloc,skill;
  @override
  _JobDetailsState createState() => _JobDetailsState();


}

class _JobDetailsState extends State<JobDetails>{
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

      body: new Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            new Text("Job Title:"+widget.jobtitle,style: TextStyle(fontWeight: FontWeight.normal,fontSize: _width/25, color: Colors.black54,),textAlign: TextAlign.start,),
            new Text("Vacancies:"+widget.vacancies,style: TextStyle(fontWeight: FontWeight.normal,fontSize: _width/25, color: Colors.black54,),textAlign: TextAlign.start,),

            new Text("Experience:"+widget.experience,style: TextStyle(fontWeight: FontWeight.normal,fontSize: _width/25, color: Colors.black54,),textAlign: TextAlign.start,),
            new Text("Bond Period:"+widget.bond,style: TextStyle(fontWeight: FontWeight.normal,fontSize: _width/25, color: Colors.black54,),textAlign: TextAlign.start,),
            new Text("Salary:"+widget.salary,style: TextStyle(fontWeight: FontWeight.normal,fontSize: _width/25, color: Colors.black54,),textAlign: TextAlign.start,),
            new Text("Job Location:"+widget.jobloc,style: TextStyle(fontWeight: FontWeight.normal,fontSize: _width/25, color: Colors.black54,),textAlign: TextAlign.start,),
            new Text("Interview Location:"+widget.intervieloc,style: TextStyle(fontWeight: FontWeight.normal,fontSize: _width/25, color: Colors.black54,),textAlign: TextAlign.start,),
            new Text("Skill Requirements:"+widget.skill,style: TextStyle(fontWeight: FontWeight.normal,fontSize: _width/25, color: Colors.black54,),textAlign: TextAlign.start,),






          ],
        ),
      ),
    );
  }

}