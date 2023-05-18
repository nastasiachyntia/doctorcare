import 'package:cloud_firestore/cloud_firestore.dart';

class ChatFirestore {
  String? documentId;
  late String? patientID;
  late String? patientName;
  late String? doctorID;
  late String? doctorName;
  late String? amount;
  late String? diagnose;
  late String? medicine;
  late String? image;
  late String? date;

  ChatFirestore(
      {this.patientID,
      this.doctorID,
      this.doctorName,
      this.patientName,
      this.amount,
      this.diagnose,
      this.medicine,
      this.date,
      this.image});

  ChatFirestore.fromDocumentSnapshot(
      {required DocumentSnapshot documentSnapshot}) {
    documentId = documentSnapshot.id;
    patientID = documentSnapshot["patientID"];
    patientName = documentSnapshot["patientName"];
    doctorID = documentSnapshot["doctorID"];
    doctorName = documentSnapshot["doctorName"];
    amount = documentSnapshot["amount"];
    diagnose = documentSnapshot["diagnose"];
    medicine = documentSnapshot["medicine"];
    image = documentSnapshot["image"];
    date = documentSnapshot["date"];
  }

  @override
  String toString() {
    return 'ChatFirestore{documentId: $documentId, patientID: $patientID, patientName: $patientName, doctorID: $doctorID, doctorName: $doctorName, amount: $amount, diagnose: $diagnose, medicine: $medicine, image: $image, date: $date}';
  }
}
