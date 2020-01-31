import 'package:flutter/material.dart';

 class Reim extends StatefulWidget{

  Reim({Key key, this.fullname, this.empid})
      : super(key: key);


  final String fullname;
  final String empid;
  @override
  _ReimState createState() => _ReimState();
}

class _ReimState extends State<Reim> {

 final _key = new GlobalKey<FormState>();
 String mobileno,mobileoperator,mobilebillno;

 bool visibilityTag = false;
 bool visibilityObs = false;
 bool visibilityCon = false;

 void _changed(bool visibility, String field) {
  setState(() {
   if (field == "tag"){
    visibilityTag = visibility;
   }
   if (field == "obs"){
    visibilityObs = visibility;
   }
   if (field == "con"){
    visibilityCon = visibility;
   }
  });
 }

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


    body: new ListView(
     children: <Widget>[

      new Text(widget.empid,style: TextStyle(fontWeight: FontWeight.bold,fontSize: _width/15, color: Colors.black,),textAlign: TextAlign.center,),
      new Text("Select the Reimbursement type",style: TextStyle(fontSize: _width/30,color: Colors.lightBlue),textAlign: TextAlign.center,),

      SizedBox(
       height: 8.0,
      ),

      new Container(
          margin: new EdgeInsets.only(left: 16.0, right: 16.0),
          child: new Column(
           children: <Widget>[
            new Column(
             mainAxisAlignment: MainAxisAlignment.center,
             children: <Widget>[
              
              new RaisedButton(
                  child: new Text('Mobile'),
                  onPressed:(){
                   visibilityObs ? null : _changed(true, "obs");
                    _changed(false, "tag");
                    _changed(false, "con");
                  }),

              new RaisedButton(
                  child: new Text('General Expenses'),
                  onPressed:(){
                   visibilityTag ? null : _changed(true, "tag");
                   _changed(false, "obs");
                   _changed(false, "con");
                  }),

              new RaisedButton(
                  child: new Text('Conveyances'),
                  onPressed:(){
                   visibilityCon? null : _changed(true, "con");
                   _changed(false, "obs");
                   _changed(false, "tag");
                  }),
             ],
            ),



            visibilityObs? new Column(
                crossAxisAlignment: CrossAxisAlignment.end,
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
            ) : new Container(),




           /* visibilityObs ? new Row(
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
            ) : new Container(),*/

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
          )
      ),
     ],
   ),
   );

  }
}