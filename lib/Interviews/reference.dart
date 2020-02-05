import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_altaoss/Classes/addreference.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Reference extends StatefulWidget {
  @override
  _ReferenceState createState() => _ReferenceState();
}

class _ReferenceState extends State<Reference> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: new Text("AltaOSS"),
        actions: <Widget>[
          // action button
          IconButton(
              icon: const Icon(Icons.person_add),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddReference()),
                );
              }),
        ],
      ),
    );
  }
}

class AddReference extends StatefulWidget {
  @override
  _AddReferenceState createState() => _AddReferenceState();
}

class _AddReferenceState extends State<AddReference> {
  String fullname,
      qualification,
      experience,
      email,
      mobile,
      designation,
      project,
      referencename,
      referenceid;
  final FirebaseDatabase _database = FirebaseDatabase.instance;

  final _key = new GlobalKey<FormState>();

  submit() {
    final form = _key.currentState;
    if (form.validate()) {
      form.save();
      _submitwalkin();
    }
  }

  _submitwalkin() async {
    String Name = fullname;
    String Qualification = qualification;
    String Experience = experience;
    String Email = email;
    String Mobile = mobile;
    String Designation = designation;
    String Project = project;
    String Referencename = referencename;
    String Referenceid = referenceid;

    String ProjectId = _database.reference().push().key;

    Addreference addreference = new Addreference(
        ProjectId,
        Name,
        Qualification,
        Experience,
        Email,
        Mobile,
        Designation,
        Project,
        Referencename,
        Referenceid);

    _database
        .reference()
        .child("Interviews")
        .child("Reference")
        .child(ProjectId)
        .set(addreference.toJson());

    Fluttertoast.showToast(
        msg: "Reference Candidate has been added",
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
        backgroundColor: Colors.blueGrey,
        title: Text('AltaOSS'),
      ),
      body: new ListView(
        children: <Widget>[
          Form(
            key: _key,
            child: new Column(
              children: <Widget>[
                SizedBox(
                  height: 10.0,
                ),
                new Center(
                  child: Text(
                    "Reference-Interview",
                    style: new TextStyle(
                        color: Colors.orange,
                        fontStyle: FontStyle.italic,
                        fontSize: _width / 15),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, top: 10.0),
                  child: new TextFormField(
                    validator: (e) {
                      if (e.isEmpty) {
                        return "Please enter Fullname";
                      }
                    },
                    onSaved: (e) => fullname = e,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                    ),
                    decoration: InputDecoration(
                      labelText: "FullName",
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(25.0),
                        borderSide: new BorderSide(),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, top: 10.0),
                  child: new TextFormField(
                    validator: (e) {
                      if (e.isEmpty) {
                        return "Please enter qualification";
                      }
                    },
                    onSaved: (e) => qualification = e,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                    ),
                    decoration: InputDecoration(
                      labelText: "Qualification",
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(25.0),
                        borderSide: new BorderSide(),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, top: 10.0),
                  child: new TextFormField(
                    validator: (e) {
                      if (e.isEmpty) {
                        return "Please enter experience";
                      }
                    },
                    onSaved: (e) => experience = e,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                    ),
                    decoration: InputDecoration(
                      labelText: "Experience",
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(25.0),
                        borderSide: new BorderSide(),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, top: 10.0),
                  child: new TextFormField(
                    validator: (e) {
                      if (e.isEmpty) {
                        return "Please enter email";
                      }
                    },
                    onSaved: (e) => email = e,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                    ),
                    decoration: InputDecoration(
                      labelText: "Email",
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(25.0),
                        borderSide: new BorderSide(),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, top: 10.0),
                  child: new TextFormField(
                    validator: (e) {
                      if (e.isEmpty) {
                        return "Please enter Mobile";
                      }
                    },
                    onSaved: (e) => mobile = e,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                    ),
                    decoration: InputDecoration(
                      labelText: "Mobile",
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(25.0),
                        borderSide: new BorderSide(),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, top: 10.0),
                  child: new TextFormField(
                    validator: (e) {
                      if (e.isEmpty) {
                        return "Please enter Designation";
                      }
                    },
                    onSaved: (e) => designation = e,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                    ),
                    decoration: InputDecoration(
                      labelText: "Designation",
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(25.0),
                        borderSide: new BorderSide(),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, top: 10.0),
                  child: new TextFormField(
                    validator: (e) {
                      if (e.isEmpty) {
                        return "Please enter Project";
                      }
                    },
                    onSaved: (e) => project = e,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                    ),
                    decoration: InputDecoration(
                      labelText: "Project",
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(25.0),
                        borderSide: new BorderSide(),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, top: 10.0),
                  child: new TextFormField(
                    validator: (e) {
                      if (e.isEmpty) {
                        return "Please enter ReferenceName";
                      }
                    },
                    onSaved: (e) => project = e,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                    ),
                    decoration: InputDecoration(
                      labelText: "Reference Name",
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(25.0),
                        borderSide: new BorderSide(),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, top: 10.0),
                  child: new TextFormField(
                    validator: (e) {
                      if (e.isEmpty) {
                        return "Please enter ReferenceId";
                      }
                    },
                    onSaved: (e) => project = e,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                    ),
                    decoration: InputDecoration(
                      labelText: "Reference Id",
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(25.0),
                        borderSide: new BorderSide(),
                      ),
                    ),
                  ),
                ),
                new FlatButton(
                  onPressed: () {
                    submit();
                  },
                  color: Colors.amber,
                  child: new Text("Add Reference"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
