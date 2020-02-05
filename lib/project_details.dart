import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_altaoss/job_class.dart';
import 'package:flutter_altaoss/job_details.dart';

class ProjectDetails extends StatefulWidget {
  ProjectDetails({Key key, this.fullname, this.empid}) : super(key: key);

  final String fullname;
  final String empid;

  @override
  _ProjectDetailsState createState() => _ProjectDetailsState();
}

class _ProjectDetailsState extends State<ProjectDetails> {
  final FirebaseDatabase _database = FirebaseDatabase.instance;

  Query query;

  List<Job> _jobsList;

  StreamSubscription<Event> _onJobAddedSubscription;
  StreamSubscription<Event> _onJobChangedSubscription;

  @override
  void initState() {
    _jobsList = new List();

    query = _database.reference().child("JobDetails");

    _onJobAddedSubscription = query.onChildAdded.listen(onEntryAdded);
    _onJobChangedSubscription = query.onChildChanged.listen(onEntryChanged);
  }

  @override
  void dispose() {
    _onJobChangedSubscription.cancel();
    _onJobAddedSubscription.cancel();
    super.dispose();
  }

  onEntryChanged(Event event) {
    var oldEntry =
        _jobsList.singleWhere((jobs) => jobs.key == event.snapshot.key);
    setState(() {
      _jobsList[_jobsList.indexOf(oldEntry)] =
          new Job.fromSnapshot(event.snapshot);
    });
  }

  onEntryAdded(Event event) {
    setState(() {
      _jobsList.add(new Job.fromSnapshot(event.snapshot));
    });
  }

  Widget showJobsList() {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;

    if (_jobsList.length > 0) {
      return Expanded(
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: _jobsList.length,
            itemBuilder: (BuildContext context, int index) {
              String key = _jobsList[index].key;
              String jobid = _jobsList[index].jobid;
              String jempid = _jobsList[index].jempid;
              String jobtitle = _jobsList[index].jobtitle;
              String vacancies = _jobsList[index].vacancies;
              String experience = _jobsList[index].experience;
              String bondperiod = _jobsList[index].bondperiod;
              String salary = _jobsList[index].salary;
              String joblocation = _jobsList[index].joblocation;
              String interviewlocation = _jobsList[index].interviewlocation;
              String skillrequirements = _jobsList[index].skillrequirements;

              return new Card(
                child: new InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => JobDetails(
                          jobid: jobid,
                          jobtitle: jobtitle,
                          vacancies: vacancies,
                          experience: experience,
                          bond: bondperiod,
                          salary: salary,
                          jobloc: joblocation,
                          intervieloc: interviewlocation,
                          skill: skillrequirements,
                        ),
                      ),
                    );
                  },
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      new Text(
                        jobtitle,
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: _width / 25,
                          color: Colors.lightBlue,
                        ),
                        textAlign: TextAlign.start,
                      ),
                      new Text(
                        "No.Of Vacancies:" + vacancies,
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: _width / 30,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.start,
                      ),
                      new Text(
                        "Job Location:" + joblocation,
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: _width / 30,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.start,
                      ),
                      new Text(
                        "Experience:" + experience,
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: _width / 30,
                          color: Colors.black54,
                        ),
                        textAlign: TextAlign.end,
                      ),
                      new Text(
                        "Salary:" + salary,
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: _width / 30,
                          color: Colors.black54,
                        ),
                        textAlign: TextAlign.end,
                      ),
                    ],
                  ),
                ),
              );
            }),
      );
    } else {
      return Center(
        child: const CircularProgressIndicator(),
      );
    }
  }

  bool visibilityTotal = false;
  bool visibilityOngoing = false;
  bool visibilityCompleted = false;
  bool visibilityFuture = false;

  void _changed(bool visibility, String field) {
    setState(() {
      if (field == "total") {
        visibilityTotal = visibility;
      }
      if (field == "ongoing") {
        visibilityOngoing = visibility;
      }
      if (field == "completed") {
        visibilityCompleted = visibility;
      }
      if (field == "future") {
        visibilityFuture = visibility;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.blueGrey,
        title: new Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Image.asset(
              'assets/images/logo.png',
              height: 30.0,
              width: 30.0,
              fit: BoxFit.contain,
            ),
            Container(
              padding: const EdgeInsets.all(8.0),
              child: Text('AltaOSS'),
            )
          ],
        ),
      ),
      body: new Column(
        children: <Widget>[
          new Text(
            widget.empid,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: _width / 20,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
          new Text(
            "Total Projects List",
            style: TextStyle(
                fontSize: _width / 15,
                color: Colors.deepOrange,
                fontStyle: FontStyle.italic),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 10.0,
          ),
          new Container(
            child: new Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                new Column(
                  // Replace with a Row for horizontal icon + text
                  children: <Widget>[
                    //showJobsList(),
                    IconButton(
                        icon:
                            new Image.asset('assets/images/totalprojects.png'),
                        iconSize: 50.0,
                        onPressed: () {
                          visibilityTotal ? null : _changed(true, "total");
                          _changed(false, "ongoing");
                          _changed(false, "completed");
                          _changed(false, "future");
                        }),
                    Text(
                      "Total Projects",
                      style: new TextStyle(color: Colors.red),
                    ),
                  ],
                ),
                new Column(
                  // Replace with a Row for horizontal icon + text
                  children: <Widget>[
                    IconButton(
                      icon: new Image.asset('assets/images/calendar.png'),
                      iconSize: 50.0,
                      onPressed: () {
                        visibilityOngoing ? null : _changed(true, "ongoing");
                        _changed(false, "total");
                        _changed(false, "completed");
                        _changed(false, "future");
                      },
                    ),
                    Text(
                      "Ongoing Projects",
                      style: new TextStyle(color: Colors.red),
                    ),
                  ],
                ),
                new Column(
                  // Replace with a Row for horizontal icon + text
                  children: <Widget>[
                    IconButton(
                      icon: new Image.asset('assets/images/checklist.png'),
                      iconSize: 50.0,
                      onPressed: () {
                        visibilityCompleted
                            ? null
                            : _changed(true, "completed");
                        _changed(false, "ongoing");
                        _changed(false, "total");
                        _changed(false, "future");
                      },
                    ),
                    Text(
                      "Completed Projects",
                      style: new TextStyle(color: Colors.red),
                    ),
                  ],
                ),
                new Column(
                  // Replace with a Row for horizontal icon + text
                  children: <Widget>[
                    IconButton(
                      icon: new Image.asset('assets/images/conference.png'),
                      iconSize: 50.0,
                      onPressed: () {
                        visibilityFuture ? null : _changed(true, "future");
                        _changed(false, "ongoing");
                        _changed(false, "completed");
                        _changed(false, "total");
                      },
                    ),
                    Text(
                      "Future Projects",
                      style: new TextStyle(color: Colors.red),
                    ),
                  ],
                ),
              ],
            ),
          ),
          showJobsList(),
          SizedBox(
            height: 20.0,
          ),
          visibilityTotal
              ? new Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Total projects',
                      style: new TextStyle(fontSize: 20.0),
                    ),
                  ],
                )
              : new Container(),
          visibilityOngoing
              ? new Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Ongoing projects',
                      style: new TextStyle(fontSize: 20.0),
                    ),
                  ],
                )
              : new Container(),
          visibilityCompleted
              ? new Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Completed projects',
                      style: new TextStyle(fontSize: 20.0),
                    ),
                  ],
                )
              : new Container(),
          visibilityFuture
              ? new Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Future projects',
                      style: new TextStyle(fontSize: 20.0),
                    ),
                  ],
                )
              : new Container(),
        ],
      ),
    );
  }
}
