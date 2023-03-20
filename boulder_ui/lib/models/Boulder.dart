class Boulder {
//These are the values that this Demo model can store
  String? name;
  bool active = true;
  DateTime? activeDate;
  DateTime? deactiveDate;

  //default Constructor
  Boulder({name, active});

  factory Boulder.fromMap(Map map) {
    return Boulder(name: map['name'], active: map['active']);
  }
}
