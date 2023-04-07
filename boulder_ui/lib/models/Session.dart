class Session {
  String? user;
  DateTime? startDate;
  DateTime? finishDate;

  //default Constructor
  Session({user, startDate, finishDate});

  toJson() {
    // return {
    //   "name": name,
    //   "colour": colour,
    // };
  }
}
