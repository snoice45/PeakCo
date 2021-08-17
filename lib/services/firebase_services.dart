import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
/*
class FirebaseServices {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  get productsRef => null;

  get usersRef => null;
  String getUserId() {
    return _firebaseAuth.currentUser!.uid;
  }

  final CollectionReference _productsRef =
      FirebaseFirestore.instance.collection("Products");

  final CollectionReference _usersRef =
      FirebaseFirestore.instance.collection("Users");
}
*/

class FirebaseServices {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  String getUserId() {
    return _firebaseAuth.currentUser!.uid;
  }

  final CollectionReference productsRef =
      FirebaseFirestore.instance.collection("Products");

  final CollectionReference usersRef =
      FirebaseFirestore.instance.collection("Users");
}
