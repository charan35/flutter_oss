class Addwalkin {
  String key;
  String projectid,
      name,
      qualification,
      experience,
      email,
      mobile,
      designation,
      project;

  Addwalkin(this.projectid, this.name, this.qualification, this.experience,
      this.email, this.mobile, this.designation, this.project);

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
    };
  }
}
