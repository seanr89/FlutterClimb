class Location {
  String? name;
  bool active = true;
  String? url;

  //default Constructor
  Location({required this.name, required this.active, this.url});

  factory Location.fromMap(Map map) {
    //print(map);
    return Location(name: map['name'], active: map['active'], url: map['url']);
    //,
    // tiers: map["tiers"].map((m) {
    //   print(m);
    //   return Tier.fromMap(m);
    // }).toList());
  }
}
