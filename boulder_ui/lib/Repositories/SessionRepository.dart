import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/Session.dart';

class SessionRepository {
  final _db = FirebaseFirestore.instance;
}
