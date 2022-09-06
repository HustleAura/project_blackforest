import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AppUser {
  final String name;
  final String email;

  AppUser({
    required this.name,
    required this.email,
  });
}
