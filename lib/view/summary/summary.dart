class Summary {
  int pointHusband;
  int pointWife;
  int pointOther;
  int money;
  int weightHusband;
  int weightWife;

  Summary(dynamic value) {
    Map<dynamic, dynamic> _value = value;
    Map<dynamic, dynamic> _point = _value["point"];
    Map<dynamic, dynamic> _weight = _value["weight"];
    this.pointHusband = _point["husband"];
    this.pointWife = _point["wife"];
    this.pointOther = _point["other"];
    this.weightHusband = _weight["husband"];
    this.weightWife = _weight["wife"];
    this.money = _value["okozukai"];
  }

  int weightedWifePoint() {
    return pointWife * weightWife;
  }

  int weightedHusbandPoint() {
    return pointHusband * weightHusband;
  }

  int moneyWife() {
    return ((actualMoney()*weightedWifePoint())/(weightedWifePoint()+weightedHusbandPoint())).round();
  }

  int moneyHusband() {
    return ((actualMoney()*weightedHusbandPoint())/(weightedWifePoint()+weightedHusbandPoint())).round();
  }

  int moneyOther() {
    return ((money*pointOther)/(pointHusband+pointWife+pointOther)).ceil();
  }

  int actualMoney() {
    return money - moneyOther();
  }
}