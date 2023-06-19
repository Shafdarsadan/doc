import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseUser {
  final String email;
  final String name;
  final String phone;

  FirebaseUser({
    required this.email,
    required this.name,
    required this.phone,
  });

  factory FirebaseUser.fromDoc(DocumentSnapshot snapshot) {
    Map<String, dynamic> data =
        (snapshot.data() as Map<String, dynamic>?) ?? {};
    return FirebaseUser(
      email: data['email'] ?? '',
      name: data['name'] ?? '',
      phone: data['phone'] ?? '',
    );
  }
}
