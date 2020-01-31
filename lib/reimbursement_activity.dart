

import 'package:flutter/material.dart';

class ReimbursementActivity extends StatefulWidget{

  ReimbursementActivity({Key key, this.fullname, this.empid})
      : super(key: key);


  final String fullname;
  final String empid;

  @override
  _ReimbursementActivityState createState() => _ReimbursementActivityState();
}

class _ReimbursementActivityState  extends State<ReimbursementActivity>{

  bool visibilityTag = false;
  bool visibilityObs = false;


  void _changed(bool visibility, String field) {
    setState(() {
      if (field == "tag"){
        visibilityTag = visibility;
      }
      if (field == "obs"){
        visibilityObs = visibility;
      }
    });
  }

  final _key = new GlobalKey<FormState>();

  String mobileno,mobileoperator,mobilebillno;

  String reimbursementtype="Mobile";

  List <String> spinnerReimbursement=[

    'Mobile',
    'General Expenses',
    'Conveyances',


  ];

  String mobilemonth="Monthly";
  List <String> spinnermobilemonth=[
    "Monthly",
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December",

  ];

  String mobileyear="Yearly";
  List<String>spinnermobileyear=[
    "Yearly",
    "2018",
    "2019",
    "2020",
    "2021",
    "2022",
    "2023",
    "2024",
    "2025",
    "2026",
  ];



  Widget mobilereimbursement(){
    return ListView(
      shrinkWrap: true,
      padding: EdgeInsets.all(15.0),
      children: <Widget>[
        new Center(
          child: Container(
            padding: const EdgeInsets.all(8.0),
            color: Colors.black26,

            child: Form(key:_key,
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      new DropdownButton<String>(
                        value: mobilemonth,
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
                            mobilemonth=data;
                          });
                        },
                        items: spinnermobilemonth.map<DropdownMenuItem<String>>((String value){
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),

                      new DropdownButton<String>(
                        value: mobileyear,
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
                            mobileyear=data;
                          });
                        },
                        items: spinnermobileyear.map<DropdownMenuItem<String>>((String value){
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ],

                  ),
                    new Row(
                     mainAxisAlignment: MainAxisAlignment.start,
                     children: <Widget>[
                       new Text("Mobile number:"),
                       new TextFormField(
                         validator: (e){
                           if(e.isEmpty){
                             return "Please insert Mobile Number";
                           }
                         },
                         keyboardType:TextInputType.number,
                         onSaved: (e) => mobileno = e,
                         style: TextStyle(
                           color: Colors.black,
                           fontSize: 16,
                           fontWeight: FontWeight.w300,
                         ),
                         decoration: InputDecoration(
                             labelText: "Mobile No"),

                       ),
                     ],
                    ),

                      new Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          new Text("Operator:"),
                          new TextFormField(
                            validator: (e){
                              if(e.isEmpty){
                                return "Please insert Operator";
                              }
                            },
                            onSaved: (e) => mobileoperator = e,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w300,

                            ),
                            decoration: InputDecoration(
                                labelText: "Operator"),

                          ),
                        ],
                      ),

                      new Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          new Text("Bill Number:"),
                          new TextFormField(
                            validator: (e){
                              if(e.isEmpty){
                                return "Please insert Bill Number";
                              }
                            },
                            onSaved: (e) => mobilebillno = e,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w300,

                            ),
                            decoration: InputDecoration(
                                labelText: "Bill Number"),

                          ),
                        ],
                      ),





                    ],
            )),
          ),
        ),
      ],
    );

  }

  @override
  Widget build(BuildContext context) {

    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    // TODO: implement build
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.blueGrey,
        title: new Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Image.asset('assets/images/logo.png',height: 30.0,width: 30.0,fit: BoxFit.contain,),

            Container(padding: const EdgeInsets.all(8.0),child: Text('AltaOSS'),)
          ],
        ),

      ),
      body: new Center(
        child: new Column(
          children: <Widget>[
            new Text(widget.empid,style: TextStyle(fontWeight: FontWeight.bold,fontSize: _width/15, color: Colors.black,),textAlign: TextAlign.center,),
            new Text("Change the type of reimbursement by clicking on spinner",style: TextStyle(fontSize: _width/30,color: Colors.lightBlue),textAlign: TextAlign.center,),

            SizedBox(
              height: 8.0,
            ),
            new DropdownButton<String>(
              value: reimbursementtype,
              icon: Icon(Icons.arrow_drop_down),
              iconSize: 24,
              elevation: 16,
              style: TextStyle(color: Colors.black,fontSize: 18),
              underline: Container(
                height: 2,
                color: Colors.black,
              ),
              items: spinnerReimbursement.map<DropdownMenuItem<String>>((String value){
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),

              onChanged: (String data){
                setState(() {
                  reimbursementtype=data;

                  if(reimbursementtype.startsWith('M'))
                    {
                      Visibility(
                        child: Text("Mobile"),
                        visible: false,
                      );
                    }
                });
              },
            ),

            Text(

                'Selected Item = ' + reimbursementtype,
                style: TextStyle
                  (fontSize: 22,
                    color: Colors.black)),

            SizedBox(height: 10.0,),

            new Column(
              children:<Widget>[
                      Text(
                'Mobile',
                style: TextStyle
                  (fontSize: 22,
                      color: Colors.black)),

                Text(
                    'General Expenses',
                    style: TextStyle
                      (fontSize: 22,
                        color: Colors.black)),

                Text(
                    'Conveyances',
                    style: TextStyle
                      (fontSize: 22,
                        color: Colors.black)),
                    ],),


           new Column(
            children: <Widget>[
              visibilityObs ? new Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  new Expanded(
                    flex: 11,
                    child: new TextField(
                      maxLines: 1,
                      style: Theme.of(context).textTheme.title,
                      decoration: new InputDecoration(
                          labelText: "Observation",
                          isDense: true
                      ),
                    ),
                  ),
                  new Expanded(
                    flex: 1,
                    child: new IconButton(
                      color: Colors.grey[400],
                      icon: const Icon(Icons.cancel, size: 22.0,),
                      onPressed: () {
                        _changed(false, "obs");
                      },
                    ),
                  ),
                ],
              ) : new Container(),

              visibilityTag ? new Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  new Expanded(
                    flex: 11,
                    child: new TextField(
                      maxLines: 1,
                      style: Theme.of(context).textTheme.title,
                      decoration: new InputDecoration(
                          labelText: "Tags",
                          isDense: true
                      ),
                    ),
                  ),
                  new Expanded(
                    flex: 1,
                    child: new IconButton(
                      color: Colors.grey[400],
                      icon: const Icon(Icons.cancel, size: 22.0,),
                      onPressed: () {
                        _changed(false, "tag");
                      },
                    ),
                  ),
                ],
              ) : new Container(),
            ],
          ),

          new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new InkWell(
              onTap: () {
                visibilityObs ? null : _changed(true, "obs");
              },
              child: new Container(
                margin: new EdgeInsets.only(top: 16.0),
                child: new Column(
                  children: <Widget>[
                    new Icon(Icons.comment, color: visibilityObs ? Colors.grey[400] : Colors.grey[600]),
                    new Container(
                      margin: const EdgeInsets.only(top: 8.0),
                      child: new Text(
                        "Observation",
                        style: new TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w400,
                          color: visibilityObs ? Colors.grey[400] : Colors.grey[600],
                        ),
                      ),
                    ),
                  ],
                ),
              )
          ),
          new SizedBox(width: 24.0),
          new InkWell(
              onTap: () {
                visibilityTag ? null : _changed(true, "tag");
              },
              child: new Container(
                margin: new EdgeInsets.only(top: 16.0),
                child: new Column(
                  children: <Widget>[
                    new Icon(Icons.local_offer, color: visibilityTag ? Colors.grey[400] : Colors.grey[600]),
                    new Container(
                      margin: const EdgeInsets.only(top: 8.0),
                      child: new Text(
                        "Tags",
                        style: new TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w400,
                          color: visibilityTag ? Colors.grey[400] : Colors.grey[600],
                        ),
                      ),
                    ),
                  ],
                ),
              )
          ),





      ],
        ),
        ]
      ),
      )
    );


  }
}