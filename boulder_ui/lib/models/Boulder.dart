import 'package:firebase_storage/firebase_storage.dart';

class Boulder {
  String? id;
  String? name;
  bool active = true;
  String? colour;
  String? grade;
  DateTime? activeDate;
  DateTime? deactiveDate;
  String? imgRef;

  //default Constructor
  Boulder({id, name, active, activeDate, deactiveDate});

  factory Boulder.fromMap(Map map) {
    return Boulder(
        id: map['id'],
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
      "activeDate": activeDate,
      "deactiveDate": deactiveDate,
      "imgRef": imgRef
    };
  }
}
