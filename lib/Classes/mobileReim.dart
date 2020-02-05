class MobileReim {
  String empid,
      month,
      year,
      mobileno,
      operator,
      billno,
      billdate,
      paymentmode,
      claimedamount,
      uploadeddate;

  MobileReim(
      this.empid,
      this.month,
      this.year,
      this.mobileno,
      this.operator,
      this.billno,
      this.billdate,
      this.paymentmode,
      this.claimedamount,
      this.uploadeddate);

  toJson() {
    return {
      "empid": empid,
      "month": month,
      "year": year,
      "mobileno": mobileno,
      "operator": operator,
      "billno": billno,
      "billdate": billdate,
      "paymentmode": paymentmode,
      "claimedamount": claimedamount,
      "uploadeddate": uploadeddate,
    };
  }
}
