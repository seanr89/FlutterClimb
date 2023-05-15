class AppUser {
  String? userId;
  String? firstName;
  String? lastName;
  DateTime? regDate;

  //default Constructor
  AppUser();

  //common Constructor
  AppUser.mapped({userId, regDate});

  factory AppUser.fromMap(Map map) {
    return AppUser.mapped(
      userId: map['userId'],
    );
  }

  toJson() {
    return {
      "userId": firstName,
      "firstName": firstName,
      "lastName": lastName,
    };
  }
}
