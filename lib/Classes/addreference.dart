class Addreference {
  String key;
  String projectid, name, qualification, experience, email, mobile, designation,
      project, referencename, referenceid;

  Addreference(this.projectid, this.name, this.qualification,
      this.experience, this.email
      , this.mobile, this.designation, this.project, this.referencename,
      this.referenceid);

  toJson() {
    return {
      "id": projectid,
      "name": name,
      "qualification": qualification,
      "experience": experience,
      "email": email,
      "mobile": mobile,
      "designation": designation,
      "project": project,
      "referencename": referencename,
      "referenceid": referenceid,
    };
  }
}
