class ConveyancesReim {
  String empid,
      month,
      year,
      startdate,
      enddate,
      billdate,
      source,
      destination,
      totalkms,
      rate,
      paymentmode,
      claimedamount,
      uploadeddate;

  ConveyancesReim(
      this.empid,
      this.month,
      this.year,
      this.startdate,
      this.enddate,
      this.billdate,
      this.source,
      this.destination,
      this.totalkms,
      this.rate,
      this.paymentmode,
      this.claimedamount,
      this.uploadeddate);

  toJson() {
    return {
      "empid": empid,
      "month": month,
      "year": year,
      "startdate": startdate,
      "enddate": enddate,
      "billdate": billdate,
      "source": source,
      "destination": destination,
      "totalkms": totalkms,
      "rate": rate,
      "paymentmode": paymentmode,
      "claimedamount": claimedamount,
      "uploadeddate": uploadeddate,
    };
  }
}
