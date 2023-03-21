class Tier {
  String? name;
  bool active = true;
  int order = 0;

  //default Constructor
  Tier({name, active, order});

  factory Tier.fromMap(Map map) {
    //print("tier:${map}");
    return Tier(name: map['name'], active: map['active'], order: map['order']);
  }
}
