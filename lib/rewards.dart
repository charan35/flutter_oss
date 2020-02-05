import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_altaoss/Classes/addreward.dart';
import 'package:flutter_altaoss/employee_list.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Rewards extends StatefulWidget {
  @override
  _RewardsState createState() => _RewardsState();
}

class _RewardsState extends State<Rewards> {
  List<EmployeeList> _employeeList;

  final FirebaseDatabase _database = FirebaseDatabase.instance;

  Query query;

  StreamSubscription<Event> _onEmployeeAddedSubscription;
  StreamSubscription<Event> _onEmployeeChangedSubscription;

  @override
  void initState() {
    _employeeList = new List();

    query = _database.reference().child("Users");

    _onEmployeeAddedSubscription = query.onChildAdded.listen(onEntryAdded);
    _onEmployeeChangedSubscription =
        query.onChildChanged.listen(onEntryChanged);
  }

  @override
  void dispose() {
    _onEmployeeChangedSubscription.cancel();
    _onEmployeeAddedSubscription.cancel();
    super.dispose();
  }

  onEntryChanged(Event event) {
    var oldEntry = _employeeList
        .singleWhere((employee) => employee.userid == event.snapshot.key);
    setState(() {
      _employeeList[_employeeList.indexOf(oldEntry)] =
          new EmployeeList.fromSnapshot(event.snapshot);
    });
  }

  onEntryAdded(Event event) {
    setState(() {
      _employeeList.add(new EmployeeList.fromSnapshot(event.snapshot));
    });
  }

  Widget showEmployeeList() {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;

    if (_employeeList.length > 0) {
      return ListView.builder(
          shrinkWrap: true,
          itemCount: _employeeList.length,
          itemBuilder: (BuildContext context, int index) {
            String userid = _employeeList[index].key;
            String empid = _employeeList[index].empid;
            String name = _employeeList[index].name;
            String lastname = _employeeList[index].lastname;
            String middlename = _employeeList[index].middlename;
            String department = _employeeList[index].department;
            String imageUrl = _employeeList[index].imageurl;
            String userId = _employeeList[index].userid;

            return new InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddReward(userId: userId),
                  ),
                );
              },
              child: new Card(
                child: new Column(
                  children: <Widget>[
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: 25,
                        ),
                        new CircleAvatar(
                          radius: 25.0,
                          backgroundImage: NetworkImage(imageUrl),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        new VerticalDivider(
                          width: _width / 30,
                          color: Colors.black,
                        ),
                        new Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              height: 10,
                            ),
                            middlename == null
                                ? new Text(
                                    name + " " + lastname,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: _width / 20,
                                      color: Colors.teal,
                                    ),
                                    textAlign: TextAlign.start,
                                  )
                                : new Text(
                                    name + " " + middlename + " " + lastname,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: _width / 20,
                                      color: Colors.teal,
                                    ),
                                    textAlign: TextAlign.start,
                                  ),
                            new Text(
                              empid,
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: _width / 30,
                                color: Colors.blue,
                              ),
                              textAlign: TextAlign.start,
                            ),
                            new Text(
                              department,
                              style: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: _width / 30,
                                color: Colors.deepOrangeAccent,
                              ),
                              textAlign: TextAlign.start,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ],
                    ),

                    //new Divider(height: _height/30,color: Colors.black),
                  ],
                ),
              ),
            );
          });
    } else {
      return Center(
        child: const CircularProgressIndicator(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
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
      body: showEmployeeList(),
    );
  }
}

class AddReward extends StatefulWidget {
  AddReward({
    Key key,
    this.userId,
  }) : super(key: key);

  String userId;

  @override
  _AddRewardState createState() => _AddRewardState();
}

class _AddRewardState extends State<AddReward> {
  final _key = new GlobalKey<FormState>();
  String name = "",
      empid = "",
      department = "",
      lastname = "",
      middlename = "",
      description;
  final FirebaseDatabase _database = FirebaseDatabase.instance;
  Query query;
  bool _saving = false;

  String rewards = "Performance Based";
  List<String> spinnerItems = [
    'Performance Based',
    'Project Based',
    'Punctuality Based',
    'Client Based',
    'Reference Based',
  ];

  String type = "1 Month";
  List<String> spinnerItems1 = [
    '1 Month',
    '3 Months',
    'Yearly',
  ];

  @override
  void initState() {
    super.initState();

    query = _database
        .reference()
        .child("Users")
        .orderByChild("userId")
        .equalTo(widget.userId);

    query.once().then((DataSnapshot snapshot) {
      Map<dynamic, dynamic> values = snapshot.value;
      values.forEach((key, values) {
        setState(() {
          name = values["name"];
          empid = values["empid"];
          department = values["department"];
          lastname = values["lastname"];
          middlename = values["middlename"];

          print(values["name"]);
          print(values["empid"]);
          print(values["department"]);
          print(values["middlename"]);
          print(values["lastname"]);
        });
      });
    });
  }

  submit() {
    final form = _key.currentState;
    if (form.validate()) {
      form.save();
      _submitproject();
    }
  }

  _submitproject() async {
    String Empid = empid;
    String Name = name + middlename + lastname;
    String Department = department;
    String Category = rewards;
    String Type = type;
    String Description = description;

    String ProjectId = _database.reference().push().key;

    AddRewards addrewards = new AddRewards(
        ProjectId, Empid, Name, Department, Category, Type, Description);

    _database
        .reference()
        .child("Rewards")
        .child(ProjectId)
        .set(addrewards.toJson());

    Fluttertoast.showToast(
        msg: empid + "has been Rewarded",
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
    return Scaffold(
      appBar: AppBar(
        title: Text('AltaOSS'),
      ),
      body: new ListView(
        children: <Widget>[
          Form(
            key: _key,
            child: new Column(
              children: <Widget>[
                new Center(
                  child: Text(
                    "Rewards",
                    style: new TextStyle(
                        color: Colors.orange,
                        fontStyle: FontStyle.italic,
                        fontSize: _width / 15),
                  ),
                ),
                SizedBox(height: 10.0),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, top: 10.0),
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Text(
                        'ID:',
                        style: new TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: _width / 20,
                            color: Colors.blue),
                      ),
                      new Text(
                        empid,
                        style: new TextStyle(
                            fontStyle: FontStyle.italic,
                            fontSize: _width / 25,
                            color: Colors.black),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, top: 10.0),
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Text(
                        'Name:',
                        style: new TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: _width / 20,
                            color: Colors.blue),
                      ),
                      new Text(
                        name + middlename + lastname,
                        style: new TextStyle(
                            fontStyle: FontStyle.italic,
                            fontSize: _width / 25,
                            color: Colors.black),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, top: 10.0),
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Text(
                        'Department:',
                        style: new TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: _width / 20,
                            color: Colors.blue),
                      ),
                      new Text(
                        department,
                        style: new TextStyle(
                            fontStyle: FontStyle.italic,
                            fontSize: _width / 25,
                            color: Colors.black),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, top: 10.0),
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      new Text(
                        "Category:",
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: _width / 20,
                            color: Colors.blue),
                      ),
                      new DropdownButton<String>(
                        value: rewards,
                        icon: Icon(Icons.arrow_drop_down),
                        iconSize: 24,
                        elevation: 16,
                        style: TextStyle(color: Colors.black, fontSize: 18),
                        underline: Container(
                          height: 2,
                          color: Colors.black,
                        ),
                        onChanged: (String data) {
                          setState(() {
                            rewards = data;
                          });
                        },
                        items: spinnerItems
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, top: 10.0),
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      new Text(
                        "Type:",
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: _width / 20,
                            color: Colors.blue),
                      ),
                      new DropdownButton<String>(
                        value: type,
                        icon: Icon(Icons.arrow_drop_down),
                        iconSize: 24,
                        elevation: 16,
                        style: TextStyle(color: Colors.black, fontSize: 18),
                        underline: Container(
                          height: 2,
                          color: Colors.black,
                        ),
                        onChanged: (String data) {
                          setState(() {
                            type = data;
                          });
                        },
                        items: spinnerItems1
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, top: 10.0),
                  child: new TextFormField(
                    validator: (e) {
                      if (e.isEmpty) {
                        return "Please Write Description";
                      }
                    },
                    onSaved: (e) => description = e,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                    ),
                    decoration: InputDecoration(labelText: "Description"),
                  ),
                ),
                new FlatButton(
                  onPressed: () {
                    submit();
                  },
                  color: Colors.amber,
                  child: new Text("Submit"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
