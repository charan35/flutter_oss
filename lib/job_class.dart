

import 'package:firebase_database/firebase_database.dart';

class Job{
  String key;
  String jobid,jempid,jobtitle,vacancies,experience,bondperiod,salary,joblocation,interviewlocation,skillrequirements;

  Job(this.jobid, this.jempid, this.jobtitle, this.vacancies,
      this.experience, this.bondperiod, this.salary, this.joblocation,
      this.interviewlocation, this.skillrequirements);

  Job.fromSnapshot(DataSnapshot snapshot):

        key = snapshot.key,

        jobid=snapshot.value["jobid"],
        jempid=snapshot.value["jempid"],
        jobtitle = snapshot.value["jobtitle"],
        vacancies=snapshot.value["vacancies"],
        experience=snapshot.value["experience"],
        bondperiod=snapshot.value["bondperiod"],
        salary=snapshot.value["salary"],
        joblocation=snapshot.value["joblocation"],
        interviewlocation=snapshot.value["interviewlocation"],
        skillrequirements=snapshot.value["skillrequirments"];

  toJson(){
    return{
      "jobid":jobid,
      "jempid":jempid,
      "jobtitle":jobtitle,
      "vacancies":vacancies,
      "experience":experience,
      "bondperiod":bondperiod,
      "salary":salary,
      "joblocation":joblocation,
      "interviewlocation":interviewlocation,
      "skillrequirments":skillrequirements
    };
  }


}