import 'package:firebase_storage/firebase_storage.dart';

class Boulder {
  String? name;
  bool active = true;
  String? colour;
  String? grade;
  DateTime? activeDate;
  DateTime? deactiveDate;
  Reference? imgRef;

  //default Constructor
  Boulder({name, active, activeDate, deactiveDate});

  factory Boulder.fromMap(Map map) {
    return Boulder(
        name: map['name'],
        active: map['active'],
        activeDate: map['activeDate'],
        deactiveDate: map['deactiveDate']);
  }

  toJson() {
    return {
      "name": name,
      "colour": colour,
      "grade": grade,
      "active": active,
      "activeDate": activeDate
    };
  }
}
