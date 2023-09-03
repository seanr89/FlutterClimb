class Location {
  String? id;
  String? name;
  bool active = true;
  String? url;

  //default Constructor
  Location({required this.name, required this.active, this.url, this.id});

  factory Location.fromMap(Map map, String id) {
    //print(map);
    return Location(
        name: map['name'], active: map['active'], url: map['url'], id: id);
    //,
    // tiers: map["tiers"].map((m) {
    //   print(m);
    //   return Tier.fromMap(m);
    // }).toList());
  }
}
