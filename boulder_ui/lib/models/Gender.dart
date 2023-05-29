// ignore: file_names
class Gender {
  String? name;
  bool active = true;

  //default Constructor
  Gender({required this.name, required this.active});

  factory Gender.fromMap(Map map) {
    return Gender(name: map['name'], active: map['active']);
  }
}
