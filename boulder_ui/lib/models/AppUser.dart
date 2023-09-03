import 'package:namer_app/assets/utils.dart';

class AppUser {
  String? userId;
  String? firstName;
  String? lastName;
  //DateTime? regDate;
  String? locationId;
  String? email;

  //default Constructor
  AppUser();

  //common Constructor
  AppUser.mapped({userId, firstName, lastName, locationId, email})
      : this.userId = userId,
        this.firstName = firstName,
        this.lastName = lastName,
        //this.regDate = regDate,
        this.locationId = locationId,
        this.email = email;

  factory AppUser.fromMap(Map map) {
    return AppUser.mapped(
      userId: map['userId'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      locationId: map['locationId'],
      email: map['email'],
    );
  }

  toJson() {
    return {
      "userId": Utils.generateId().toString(),
      "firstName": firstName,
      "lastName": lastName,
      "locationId": locationId,
      "email": email,
    };
  }
}
