import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctorcare/data/models/Chat/ChatFirestore.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class ChatFirestoreController extends GetxController {
  FirebaseFirestore? firebaseFirestore;

  Rx<List<ChatFirestore>> chatFirestoreList = Rx<List<ChatFirestore>>([]);

  var allList = <ChatFirestore>[].obs;
  var historyByPatientList = <ChatFirestore>[].obs;
  var historyByDoctorList = <ChatFirestore>[].obs;

  List<ChatFirestore> get chatFirestore => chatFirestoreList.value;

  var logger = Logger();

  var loggedInPatientID = ''.obs;
  var loggedInDoctorID = ''.obs;

  @override
  void onReady() {
    firebaseFirestore = FirebaseFirestore.instance;
    chatFirestoreList.bindStream(chatStream());
  }

  void filterHistoryByPatient() {
    for (int i = 0; i < chatFirestoreList.value.length; i++) {}
  }

  void addRecord(ChatFirestore model) async {
    await firebaseFirestore!.collection('doctor-care').add({
      'doctorID': model.doctorID,
      'patientID': model.patientID,
      'amount': model.amount,
      'diagnose': model.diagnose,
      'medicine': model.medicine,
      'doctorName': model.doctorName,
      'patientName': model.patientName,
      'image': model.image,
      'date': model.date
    });
  }

  Stream<List<ChatFirestore>> chatStream() {
    historyByPatientList.clear();
    historyByDoctorList.clear();

    var list = firebaseFirestore!
        .collection('doctor-care')
        .snapshots()
        .map((QuerySnapshot query) {
      List<ChatFirestore> listItem = [];
      for (var todo in query.docs) {
        final itemModel =
            ChatFirestore.fromDocumentSnapshot(documentSnapshot: todo);
        listItem.add(itemModel);
        allList.add(itemModel);

        if (itemModel.patientID! == loggedInPatientID.value) {
          historyByPatientList.add(itemModel);
        }

        if (itemModel.doctorID! == loggedInDoctorID.value) {
          historyByDoctorList.add(itemModel);
        }
      }
      return listItem;
    });

    return list;
  }

  void filterForDoctor() {
    historyByDoctorList.clear();

    for (int i = 0; i < allList.value.length; i++) {
      if (allList.value[i].doctorID == loggedInDoctorID.value) {
        historyByDoctorList.add(allList.value[i]);
      }
    }
  }

  void filterForPatient() {
    historyByPatientList.clear();

    for (int i = 0; i < allList.value.length; i++) {
      if (allList.value[i].patientID == loggedInPatientID.value) {
        historyByPatientList.add(allList.value[i]);
      }
    }
  }

  void onUpdateRecipe(ChatFirestore item) {
    firebaseFirestore!.collection('doctor-care').doc(item.documentId!).set(item.toJson()).then(
        (value) => logger.i("Appointment updated Successfully!"),
        onError: (e) => logger.e("Error updating Doc: $e"));
  }
}
