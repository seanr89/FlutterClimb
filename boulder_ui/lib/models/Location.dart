class Location{

//These are the values that this Demo model can store
String? name;

//default Constructor
Location({this.name});

  factory Location.fromMap(Map map){
    return Location(name: map['name']);
  }

}