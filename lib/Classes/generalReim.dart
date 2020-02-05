class GeneralReim {
  String empid,
      month,
      year,
      type,
      billno,
      billdate,
      paymentmode,
      claimedamount,
      uploadeddate;

  GeneralReim(this.empid, this.month, this.year, this.type, this.billno,
      this.billdate, this.paymentmode, this.claimedamount, this.uploadeddate);

  toJson() {
    return {
      "empid": empid,
      "month": month,
      "year": year,
      "type": type,
      "billno": billno,
      "billdate": billdate,
      "paymentmode": paymentmode,
      "claimedamount": claimedamount,
      "uploadeddate": uploadeddate,
    };
  }
}
