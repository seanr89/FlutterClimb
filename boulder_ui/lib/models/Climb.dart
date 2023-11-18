import 'package:firebase_storage/firebase_storage.dart';

class Climb {
  // String? id;
  String? name;
  bool active = true;
  late String colour;
  late String grade;
  DateTime? activeDate;
  DateTime? deactiveDate;
  String? imgRef;

  Climb();

  //default Constructor
  Climb.mapped(
      {required this.name,
      required this.active,
      // required this.activeDate,
      // required this.deactiveDate,
      required this.imgRef,
      required this.colour,
      required this.grade});

  // factory Boulder.fromMap(Map map) {
  //   //print(map);
  //   return Boulder.mapped(
  //       name: map['name'],
  //       active: map['active'],
  //       // activeDate: map['activeDate'],
  //       // deactiveDate: map['deactiveDate'],
  //       imgRef: map['imgRef'],
  //       colour: map['colour'],
  //       grade: map['grade']);
  // }

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
