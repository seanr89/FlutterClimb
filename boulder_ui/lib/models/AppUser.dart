class AppUser {
  String? userId;
  DateTime? regDate;

  //default Constructor
  AppUser({userId, regDate});

  toJson() {
    // return {
    //   "name": name,
    //   "colour": colour,
    // };
  }
}
