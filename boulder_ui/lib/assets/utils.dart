import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class Utils {
  static final messengerKey = GlobalKey<ScaffoldMessengerState>();

  static showSnackBar(String? text, {Color color = Colors.red}) {
    if (text == null) return;

    final snackBar = SnackBar(content: Text(text), backgroundColor: color);

    messengerKey.currentState!
      ..removeCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  static String generateId() {
    return Uuid().v4();
  }
}
