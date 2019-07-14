class Summary {
  int pointHusband;
  int pointWife;
  int pointOther;
  int money;
  num weightHusband;
  num weightWife;

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
    return (pointWife * weightWife).round();
  }

  int weightedHusbandPoint() {
    return (pointHusband * weightHusband).round();
  }

  int moneyWife() {
    if (weightedWifePoint()+weightedHusbandPoint() == 0) {
      return 0;
    }
    return ((actualMoney()*weightedWifePoint())/(weightedWifePoint()+weightedHusbandPoint())).round();
  }

  int moneyHusband() {
    if (weightedWifePoint()+weightedHusbandPoint() == 0) {
      return 0;
    }
    return ((actualMoney()*weightedHusbandPoint())/(weightedWifePoint()+weightedHusbandPoint())).round();
  }

  int moneyOther() {
    return ((money*pointOther)/(weightedHusbandPoint()+weightedWifePoint()+pointOther)).ceil();
  }

  int actualMoney() {
    return money - moneyOther();
  }
}