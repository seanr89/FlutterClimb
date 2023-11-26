import 'package:flutter/material.dart';

class UserDetails extends StatefulWidget {
  final String firstName;
  final String lastName;
  final String email;
  final String location;
  final String profilePic;

  UserDetails(
      {required this.firstName,
      required this.lastName,
      required this.email,
      required this.location,
      required this.profilePic});

  @override
  State<UserDetails> createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
