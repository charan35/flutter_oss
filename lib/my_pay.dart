import 'package:flutter/material.dart';
import 'package:flutter_altaoss/reim.dart';
import 'package:flutter_altaoss/reimbursement_activity.dart';

class MyPay extends StatefulWidget{
  MyPay({Key key, this.fullname, this.empid})
      : super(key: key);


  final String fullname;
  final String empid;

  @override
  _MyPayState createState() => _MyPayState();
}
class _MyPayState extends State<MyPay>{


  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
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

      body: new Center(
        child:new Column(
            children: <Widget>[
              new Text("Welcome to MyPay Console",style: TextStyle(fontWeight: FontWeight.normal,fontSize: _width/15, color: Colors.black,),textAlign: TextAlign.center,),
              new Text(widget.fullname,style: TextStyle(fontWeight: FontWeight.normal,fontSize: _width/20, color: Colors.black54,),textAlign: TextAlign.center,),
              new Text(widget.empid,style: TextStyle(fontWeight: FontWeight.normal,fontSize: _width/20, color: Colors.black54,),textAlign: TextAlign.center,),



              new RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(15.0)),
                  child: Text(
                    "Re-imbursement",
                    style: TextStyle(fontSize: 18.0),
                  ),
                  textColor: Colors.black,
                  color: Colors.amberAccent,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Reim(empid: widget.empid,fullname: widget.fullname,),
                      ),
                    );

                  }),

            ],
        ),
      ),
    );
  }


}