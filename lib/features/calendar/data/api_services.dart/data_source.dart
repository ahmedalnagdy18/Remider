import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseDataSource {
  Stream<QuerySnapshot> getData({required String type}) {
    CollectionReference tasks = FirebaseFirestore.instance.collection("tasks");
    Stream<QuerySnapshot> taskstype =
        tasks.where("taskType", isEqualTo: type).snapshots();
    return taskstype;
  }

  Stream<QuerySnapshot> getAllData() {
    CollectionReference tasks = FirebaseFirestore.instance.collection("tasks");
    Stream<QuerySnapshot> taskstype = tasks.snapshots();
    return taskstype;
  }
}
