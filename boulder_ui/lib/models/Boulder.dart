import 'package:firebase_storage/firebase_storage.dart';

class Boulder {
  // String? id;
  String? name;
  bool active = true;
  String? colour;
  String? grade;
  DateTime? activeDate;
  DateTime? deactiveDate;
  String imgRef;

  //default Constructor
  Boulder(
      {required this.name,
      required this.active,
      // required this.activeDate,
      // required this.deactiveDate,
      required this.imgRef,
      required this.colour,
      required this.grade});

  factory Boulder.fromMap(Map map) {
    //print(map);
    return Boulder(
        name: map['name'],
        active: map['active'],
        // activeDate: map['activeDate'],
        // deactiveDate: map['deactiveDate'],
        imgRef: map['imgRef'],
        colour: map['colour'],
        grade: map['grade']);
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
