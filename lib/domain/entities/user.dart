import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  User({
    required this.id,
    required this.name,
    required this.email,
    required this.surname,
    required this.pictureUrl
  }) : purchaseRef = FirebaseFirestore.instance
           .collection('users')
           .doc(id)
           .collection('purchase');

  final String surname;
  final String email;
  final String name;
  final String id;
  final String pictureUrl;
  final CollectionReference purchaseRef;

  Map<String, dynamic> toMap() {
    return {
        'id': id,
        'name': name,
        'surname': surname,
        'email': email,
        'purchase': purchaseRef,
        'pictureUrl': pictureUrl
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
        id: map['id'],
        name: map['nome'],
        surname: map['surname'],
        email: map['email'],
        pictureUrl: map['pictureUrl']
    );
  }
}
