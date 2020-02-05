class AddRewards {
  String key;
  String projectid, empid, name, department, category, type, description;

  AddRewards(this.projectid, this.empid, this.name,
      this.department, this.category, this.type, this.description,);

  toJson() {
    return {
      "id": projectid,
      "empid": empid,
      "name": name,
      "department": department,
      "category": category,
      "type": type,
      "description": description,
    };
  }
}




