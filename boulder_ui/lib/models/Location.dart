class Location {
//These are the values that this Demo model can store
  String? name;
  bool active = true;
  String? url;

  //default Constructor
  Location({name, active, url});

  factory Location.fromMap(Map map) {
    return Location(name: map['name'], active: map['active'], url: map['url']);
  }
}
