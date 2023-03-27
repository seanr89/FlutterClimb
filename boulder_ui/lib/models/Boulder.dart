class Boulder {
  String? name;
  bool active = true;
  String? Colour;
  String? Grade;
  DateTime? activeDate;
  DateTime? deactiveDate;

  //default Constructor
  Boulder({name, active, activeDate, deactiveDate});

  factory Boulder.fromMap(Map map) {
    return Boulder(
        name: map['name'],
        active: map['active'],
        activeDate: map['activeDate'],
        deactiveDate: map['deactiveDate']);
  }
}
