

class AddProject{
  String key;
  String projectid,pempid,projectname,teamleadername,clientname,startdate,enddate,projectstatus;

  AddProject(this.projectid, this.pempid, this.projectname,
      this.teamleadername, this.clientname, this.startdate, this.enddate,
      this.projectstatus);

  toJson(){
    return{
      "rojectid":projectid,
      "pempid":pempid,
      "projectname":projectname,
      "teamleadername":teamleadername,
      "clientname":clientname,
      "startdate":startdate,
      "enddate":enddate,
      "projectstatus":projectstatus,


    };
  }


}