import 'package:firebase_database/firebase_database.dart';

class OurUpDatesForm{

  String key;
  String projectname,date,empid,notes,taskstatus,updatedby,updateid,uype;


  OurUpDatesForm(this.projectname, this.date, this.empid, this.notes,
       this.taskstatus, this.updatedby, this.updateid,
      this.uype);

  OurUpDatesForm.fromSnapshot(DataSnapshot snapshot):

        key = snapshot.key,


        empid = snapshot.value["empid"],
        projectname=snapshot.value["projectname"],

        date=snapshot.value["date"],
        notes=snapshot.value["notes"],
        taskstatus=snapshot.value["taskstatus"],
        updatedby=snapshot.value["updatedby"],
        updateid=snapshot.value["updateid"],
        uype=snapshot.value["uype"];




  toJson(){
    return{
      "empid":empid,
      "projectname":projectname,
      "date":date,
      "notes":notes,
      "taskstatus":taskstatus,
      "updatedby":updatedby,
      "updateid":updateid,
      "uype":uype,

    };
  }

}