import 'package:flutter/material.dart';
import 'package:flutter_altaoss/Classes/conveyanceReim.dart';
import 'package:flutter_altaoss/Classes/generalReim.dart';
import 'package:intl/intl.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_altaoss/Classes/mobileReim.dart';


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
 final FirebaseDatabase _database = FirebaseDatabase.instance;

 String mobileno,
     mobileoperator,
     mobilebillno,
     billdate = "0000-00-00",
     mobileclaimedamount,
     uploadeddate = "0000-00-00";
 String billno1, generalclaimedamount;
 String startdate = "0000-00-00",
     enddate = "0000-00-00",
     source,
     destination,
     totalkms,
     rate;


 bool visibilityMobile = false;
 bool visibilityGeneral = false;
 bool visibilityCon = false;

 void _changed(bool visibility, String field) {
  setState(() {
   if (field == "mobile") {
    visibilityMobile = visibility;
   }
   if (field == "general") {
    visibilityGeneral = visibility;
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

 DateTime selectBillDate = DateTime.now();

 Future<Null> _selectBillDate(BuildContext context) async {
  final DateTime picked = await showDatePicker(context: context,
      initialDate: selectBillDate,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101));
  if (picked != null && picked != selectBillDate) {
   setState(() {
    selectBillDate = picked;
    billdate = DateFormat('yyyy-MM-dd').format(selectBillDate);
   });
  }
 }

 String payment = "Select";
 List<String>paymentspinner = [
  "Select",
  "Cash",
  "Credit Card",
 ];

 DateTime selectuploadeddate = DateTime.now();

 Future<Null> _selectuploadeddate(BuildContext context) async {
  final DateTime picked = await showDatePicker(context: context,
      initialDate: selectuploadeddate,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101));
  if (picked != null && picked != selectuploadeddate) {
   setState(() {
    selectuploadeddate = picked;
    uploadeddate = DateFormat('yyyy-MM-dd').format(selectuploadeddate);
   });
  }
 }

 ///////////////////////General Expenses

 String general = "Select";
 List<String>generalspinner = [
  "Select",
  "Courier Charges",
  "Diesel and Petrol Charges",
  "Electricity and Water Bills",
  "Entertainment and Business Promotion",
  "Gifts and Presentations",
  "Media Charges",
  "Medical",
  "Office Telephone Bills",
  "Other Expenses",
  "Printing and Stationary",
  "Rent Bills",
  "Tea or Coffee and etc bills",
  "HouseKeeping and Miscellanous Charges"
 ];


 ////////////////////////CONVEYANCES

 DateTime selectStartDate = DateTime.now();

 Future<Null> _selectStartDate(BuildContext context) async {
  final DateTime picked = await showDatePicker(context: context,
      initialDate: selectStartDate,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101));
  if (picked != null && picked != selectStartDate) {
   setState(() {
    selectStartDate = picked;
    startdate = DateFormat('yyyy-MM-dd').format(selectStartDate);
   });
  }
 }


 DateTime selectenddate = DateTime.now();

 Future<Null> _selectenddate(BuildContext context) async {
  final DateTime picked = await showDatePicker(context: context,
      initialDate: selectenddate,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101));
  if (picked != null && picked != selectenddate) {
   setState(() {
    selectenddate = picked;
    enddate = DateFormat('yyyy-MM-dd').format(selectenddate);
   });
  }
 }

 check() {
  final form = _key.currentState;
  if (form.validate()) {
   form.save();
   _mobile();
  }
 }

 _mobile() async {
  String Empid = widget.empid;
  String Month = mobilemonth;
  String Year = mobileyear;
  String Mobileno = mobileno;
  String Operator = mobileoperator;
  String Billno = mobilebillno;
  String Billdate = billdate.toString();
  String Paymentmode = payment;
  String Claimedamount = mobileclaimedamount;
  String Uploadeddate = uploadeddate.toString();

  MobileReim mobilereim = new MobileReim(
      Empid,
      Month,
      Year,
      Mobileno,
      Operator,
      Billno,
      Billdate,
      Paymentmode,
      Claimedamount,
      Uploadeddate);

  _database.reference().child("Reimbursement").child("Mobile").set(
      mobilereim.toJson());

  Fluttertoast.showToast(
      msg: "Project added Successfully",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIos: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0);
 }

 check1() {
  final form = _key.currentState;
  if (form.validate()) {
   form.save();
   _general();
  }
 }

 _general() async {
  String Empid = widget.empid;
  String Month = mobilemonth;
  String Year = mobileyear;
  String ReimType = general;
  String Billno = billno1;
  String Billdate = billdate.toString();
  String Paymentmode = payment;
  String Claimedamount = generalclaimedamount;
  String Uploadeddate = uploadeddate.toString();

  GeneralReim generalreim = new GeneralReim(
      Empid,
      Month,
      Year,
      ReimType,
      Billno,
      Billdate,
      Paymentmode,
      Claimedamount,
      Uploadeddate);

  _database.reference().child("Reimbursement").child("General Expenses").set(
      generalreim.toJson());

  Fluttertoast.showToast(
      msg: "Reimbursement added Successfully",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIos: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0);
 }

 check2() {
  final form = _key.currentState;
  if (form.validate()) {
   form.save();
   _conveyances();
  }
 }

 _conveyances() async {
  String Empid = widget.empid;
  String Month = mobilemonth;
  String Year = mobileyear;
  String Startdate = startdate.toString();
  String Enddate = enddate.toString();
  String Billdate = billdate.toString();
  String Source = source;
  String Destination = destination;
  String Totalkms = totalkms;
  String Rate = rate;
  String Paymentmode = payment;
  String Claimedamount = generalclaimedamount;
  String Uploadeddate = uploadeddate.toString();

  ConveyancesReim conveyancesreim = new ConveyancesReim(
      Empid,
      Month,
      Year,
      Startdate,
      Enddate,
      Billdate,
      Source,
      Destination,
      Totalkms,
      Rate,
      Paymentmode,
      Claimedamount,
      Uploadeddate);

  _database.reference().child("Reimbursement").child("Conveyances").set(
      conveyancesreim.toJson());

  Fluttertoast.showToast(
      msg: "Reimbursement added Successfully",
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

      Form(
       key: _key,

       child: new Column(
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
                      visibilityMobile ? null : _changed(true, "mobile");
                      _changed(false, "general");
                      _changed(false, "con");
                     }),

                 new RaisedButton(
                     child: new Text('General Expenses'),
                     onPressed:(){
                      visibilityGeneral ? null : _changed(true, "general");
                      _changed(false, "mobile");
                      _changed(false, "con");
                     }),

                 new RaisedButton(
                     child: new Text('Conveyances'),
                     onPressed:(){
                      visibilityCon? null : _changed(true, "con");
                      _changed(false, "mobile");
                      _changed(false, "general");
                     }),
                ],
               ),


               visibilityMobile ? new Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                 Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                   new Text('Select Month: ',
                    style: new TextStyle(color: Colors.black, fontSize: 15.0),),
                   SizedBox(
                    width: 50.0,
                   ),
                   new DropdownButton<String>(
                    value: mobilemonth,
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
                      mobilemonth = data;
                     });
                    },
                    items: spinnermobilemonth.map<DropdownMenuItem<String>>((
                        String value) {
                     return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                     );
                    }).toList(),
                   ),
                  ],
                 ),

                 Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                   new Text('Select Year: ',
                    style: new TextStyle(color: Colors.black, fontSize: 15.0),),
                   SizedBox(
                    width: 50.0,
                   ),
                   new DropdownButton<String>(
                    value: mobileyear,
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
                      mobileyear = data;
                     });
                    },
                    items: spinnermobileyear.map<DropdownMenuItem<String>>((
                        String value) {
                     return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                     );
                    }).toList(),
                   ),
                  ],
                 ),


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

                 new TextFormField(
                  validator: (e) {
                   if (e.isEmpty) {
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

                 new TextFormField(
                  validator: (e) {
                   if (e.isEmpty) {
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

                 new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                   new Text("Bill Date:"),
                   new Text("${billdate}"),
                   new IconButton(icon: Icon(Icons.calendar_today),
                    onPressed: () => _selectBillDate(context),
                    color: Colors.orangeAccent,)
                  ],
                 ),

                 Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                   new Text('Payment mode:',
                    style: new TextStyle(color: Colors.black, fontSize: 15.0),),

                   SizedBox(
                    width: 50.0,
                   ),

                   new DropdownButton<String>(
                    value: payment,
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
                      payment = data;
                     });
                    },
                    items: paymentspinner.map<DropdownMenuItem<String>>((
                        String value) {
                     return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                     );
                    }).toList(),
                   ),
                  ],
                 ),

                 new TextFormField(
                  validator: (e) {
                   if (e.isEmpty) {
                    return "Please insert Claimed Amount";
                   }
                  },
                  keyboardType: TextInputType.number,
                  onSaved: (e) => mobileclaimedamount = e,
                  style: TextStyle(
                   color: Colors.black,
                   fontSize: 16,
                   fontWeight: FontWeight.w300,
                  ),
                  decoration: InputDecoration(
                      labelText: "Claimed Amount"),
                 ),

                 new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                   new Text("Uploaded Date:"),
                   new Text("${uploadeddate}"),
                   new IconButton(icon: Icon(Icons.calendar_today),
                    onPressed: () => _selectuploadeddate(context),
                    color: Colors.orangeAccent,)
                  ],
                 ),

                 new Center(
                  child: new FlatButton(onPressed: () {
                   check();
                  },
                   color: Colors.amber,
                   child:
                   new Text("Submit"),),
                 ),

                ],
               ) : new Container(),


               visibilityGeneral ? new Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                 Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                   new Text('Select Month: ',
                    style: new TextStyle(color: Colors.black, fontSize: 15.0),),
                   SizedBox(
                    width: 50.0,
                   ),
                   new DropdownButton<String>(
                    value: mobilemonth,
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
                      mobilemonth = data;
                     });
                    },
                    items: spinnermobilemonth.map<DropdownMenuItem<String>>((
                        String value) {
                     return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                     );
                    }).toList(),
                   ),
                  ],
                 ),

                 Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                   new Text('Select Year: ',
                    style: new TextStyle(color: Colors.black, fontSize: 15.0),),
                   SizedBox(
                    width: 50.0,
                   ),
                   new DropdownButton<String>(
                    value: mobileyear,
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
                      mobileyear = data;
                     });
                    },
                    items: spinnermobileyear.map<DropdownMenuItem<String>>((
                        String value) {
                     return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                     );
                    }).toList(),
                   ),
                  ],
                 ),

                 Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                   new Text('Reim Type:',
                    style: new TextStyle(color: Colors.black, fontSize: 15.0),),

                   SizedBox(
                    width: 50.0,
                   ),

                   new DropdownButton<String>(
                    value: general,
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
                      general = data;
                     });
                    },
                    items: generalspinner.map<DropdownMenuItem<String>>((
                        String value) {
                     return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                     );
                    }).toList(),
                   ),
                  ],
                 ),

                 new TextFormField(
                  validator: (e) {
                   if (e.isEmpty) {
                    return "Please insert Bill Number";
                   }
                  },
                  onSaved: (e) => billno1 = e,
                  style: TextStyle(
                   color: Colors.black,
                   fontSize: 16,
                   fontWeight: FontWeight.w300,
                  ),
                  decoration: InputDecoration(
                      labelText: "Bill Number"),
                 ),

                 new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                   new Text("Bill Date:"),
                   new Text("${billdate}"),
                   new IconButton(icon: Icon(Icons.calendar_today),
                    onPressed: () => _selectBillDate(context),
                    color: Colors.orangeAccent,)
                  ],
                 ),

                 Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                   new Text('Payment mode:',
                    style: new TextStyle(color: Colors.black, fontSize: 15.0),),

                   SizedBox(
                    width: 50.0,
                   ),

                   new DropdownButton<String>(
                    value: payment,
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
                      payment = data;
                     });
                    },
                    items: paymentspinner.map<DropdownMenuItem<String>>((
                        String value) {
                     return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                     );
                    }).toList(),
                   ),
                  ],
                 ),

                 new TextFormField(
                  validator: (e) {
                   if (e.isEmpty) {
                    return "Please insert Claimed Amount";
                   }
                  },
                  keyboardType: TextInputType.number,
                  onSaved: (e) => generalclaimedamount = e,
                  style: TextStyle(
                   color: Colors.black,
                   fontSize: 16,
                   fontWeight: FontWeight.w300,
                  ),
                  decoration: InputDecoration(
                      labelText: "Claimed Amount"),
                 ),

                 new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                   new Text("Uploaded Date:"),
                   new Text("${uploadeddate}"),
                   new IconButton(icon: Icon(Icons.calendar_today),
                    onPressed: () => _selectuploadeddate(context),
                    color: Colors.orangeAccent,)
                  ],
                 ),

                 new Center(
                  child: new FlatButton(onPressed: () {
                   check1();
                  },
                   color: Colors.amber,
                   child:
                   new Text("Submit"),),
                 ),
                ],
               ) : new Container(),


               visibilityCon ? new Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                 Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                   new Text('Select Month: ',
                    style: new TextStyle(color: Colors.black, fontSize: 15.0),),
                   SizedBox(
                    width: 50.0,
                   ),
                   new DropdownButton<String>(
                    value: mobilemonth,
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
                      mobilemonth = data;
                     });
                    },
                    items: spinnermobilemonth.map<DropdownMenuItem<String>>((
                        String value) {
                     return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                     );
                    }).toList(),
                   ),
                  ],
                 ),

                 Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                   new Text('Select Year: ',
                    style: new TextStyle(color: Colors.black, fontSize: 15.0),),
                   SizedBox(
                    width: 50.0,
                   ),
                   new DropdownButton<String>(
                    value: mobileyear,
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
                      mobileyear = data;
                     });
                    },
                    items: spinnermobileyear.map<DropdownMenuItem<String>>((
                        String value) {
                     return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                     );
                    }).toList(),
                   ),
                  ],
                 ),

                 new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                   new Text("Start Date:"),
                   new Text("${startdate}"),
                   new IconButton(icon: Icon(Icons.calendar_today),
                    onPressed: () => _selectStartDate(context),
                    color: Colors.orangeAccent,)
                  ],
                 ),

                 new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                   new Text("End Date:"),
                   new Text("${enddate}"),
                   new IconButton(icon: Icon(Icons.calendar_today),
                    onPressed: () => _selectenddate(context),
                    color: Colors.orangeAccent,)
                  ],
                 ),

                 new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                   new Text("Bill Date:"),
                   new Text("${billdate}"),
                   new IconButton(icon: Icon(Icons.calendar_today),
                    onPressed: () => _selectBillDate(context),
                    color: Colors.orangeAccent,)
                  ],
                 ),

                 new TextFormField(
                  validator: (e) {
                   if (e.isEmpty) {
                    return "Please enter Source";
                   }
                  },
                  onSaved: (e) => source = e,
                  style: TextStyle(
                   color: Colors.black,
                   fontSize: 16,
                   fontWeight: FontWeight.w300,
                  ),
                  decoration: InputDecoration(
                      labelText: "Source"),
                 ),

                 new TextFormField(
                  validator: (e) {
                   if (e.isEmpty) {
                    return "Please enter Destination";
                   }
                  },
                  onSaved: (e) => destination = e,
                  style: TextStyle(
                   color: Colors.black,
                   fontSize: 16,
                   fontWeight: FontWeight.w300,
                  ),
                  decoration: InputDecoration(
                      labelText: "Destination"),
                 ),

                 new TextFormField(
                  keyboardType: TextInputType.number,
                  validator: (e) {
                   if (e.isEmpty) {
                    return "Please enter Total Kms";
                   }
                  },
                  onSaved: (e) => totalkms = e,
                  style: TextStyle(
                   color: Colors.black,
                   fontSize: 16,
                   fontWeight: FontWeight.w300,
                  ),
                  decoration: InputDecoration(
                      labelText: "Total kms"),
                 ),

                 new TextFormField(
                  keyboardType: TextInputType.number,
                  validator: (e) {
                   if (e.isEmpty) {
                    return "Please enter Rate/km";
                   }
                  },
                  onSaved: (e) => rate = e,
                  style: TextStyle(
                   color: Colors.black,
                   fontSize: 16,
                   fontWeight: FontWeight.w300,
                  ),
                  decoration: InputDecoration(
                      labelText: "Rate/Km"),
                 ),

                 Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                   new Text('Payment mode:',
                    style: new TextStyle(color: Colors.black, fontSize: 15.0),),

                   SizedBox(
                    width: 50.0,
                   ),

                   new DropdownButton<String>(
                    value: payment,
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
                      payment = data;
                     });
                    },
                    items: paymentspinner.map<DropdownMenuItem<String>>((
                        String value) {
                     return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                     );
                    }).toList(),
                   ),
                  ],
                 ),

                 new TextFormField(
                  validator: (e) {
                   if (e.isEmpty) {
                    return "Please insert Claimed Amount";
                   }
                  },
                  keyboardType: TextInputType.number,
                  onSaved: (e) => mobileclaimedamount = e,
                  style: TextStyle(
                   color: Colors.black,
                   fontSize: 16,
                   fontWeight: FontWeight.w300,
                  ),
                  decoration: InputDecoration(
                      labelText: "Claimed Amount"),
                 ),

                 new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                   new Text("Uploaded Date:"),
                   new Text("${uploadeddate}"),
                   new IconButton(icon: Icon(Icons.calendar_today),
                    onPressed: () => _selectuploadeddate(context),
                    color: Colors.orangeAccent,)
                  ],
                 ),

                 new Center(
                  child: new FlatButton(onPressed: () {
                   check2();
                  },
                   color: Colors.amber,
                   child:
                   new Text("Submit"),),
                 ),


                ],
               ) : new Container(),

              ],
             )
         ),
        ],
       ),
      ),
     ],
   ),
   );

  }
}