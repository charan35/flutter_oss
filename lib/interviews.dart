import 'package:flutter/material.dart';
import 'package:flutter_altaoss/Interviews/reference.dart';
import 'package:flutter_altaoss/Interviews/walkin.dart';

class Interviews extends StatefulWidget {
  @override
  _InterviewsState createState() => _InterviewsState();
}

class _InterviewsState extends State<Interviews> {
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
          Center(
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Column(
                  // Replace with a Row for horizontal icon + text
                  children: <Widget>[
                    IconButton(
                        icon: new Image.asset('assets/images/conference.png'),
                        iconSize: 100.0,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Walkin()),
                          );
                        }),
                    Text(
                      "Walk In",
                      style: new TextStyle(color: Colors.red),
                    ),
                  ],
                ),
                SizedBox(
                  width: 10.0,
                ),
                new Column(
                  // Replace with a Row for horizontal icon + text
                  children: <Widget>[
                    IconButton(
                        icon: new Image.asset('assets/images/conference.png'),
                        iconSize: 100.0,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Reference()),
                          );
                        }),
                    Text(
                      "Reference",
                      style: new TextStyle(color: Colors.red),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
