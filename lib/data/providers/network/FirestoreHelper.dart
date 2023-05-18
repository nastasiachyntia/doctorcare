import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class FirestoreHelper {
  final Future<FirebaseApp> firebaseInitialization = Firebase.initializeApp();
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
}
