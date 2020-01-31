

import 'package:firebase_database/firebase_database.dart';

class EventClass{
  String key;
  String eventid,eventname,godate,todate,eventdes;

  EventClass(this.eventid, this.eventname, this.godate, this.todate, this.eventdes);

  EventClass.fromSnapshot(DataSnapshot snapshot):

        key = snapshot.key,


        eventname = snapshot.value["eventname"],
        eventid=snapshot.value["eventid"],

        eventdes=snapshot.value["eventdes"],
        godate=snapshot.value["godate"],
        todate=snapshot.value["todate"];



  toJson(){

    return{
      "eventdes":eventdes,
      "eventid":eventid,
      "eventname":eventname,
      "godate":godate,
      "todate":todate

    };
  }


}