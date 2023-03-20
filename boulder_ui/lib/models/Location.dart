import 'Tier.dart';

class Location {
//These are the values that this Demo model can store
  String? name;
  bool active = true;
  String? url;
  Map<int, Tier>? tiers;

  //default Constructor
  Location({required this.name, required this.active, this.url, this.tiers});

  factory Location.fromMap(Map map) {
    print(map);
    return Location(
        name: map['name'], active: map['active'], url: map['url'], tiers: null);
    //,
    // tiers: map["tiers"].map((m) {
    //   print(m);
    //   return Tier.fromMap(m);
    // }).toList());
  }
}
