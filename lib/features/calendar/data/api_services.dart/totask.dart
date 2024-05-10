import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reminder_app/features/calendar/data/models/model.dart';

List<Task> totask(List<QueryDocumentSnapshot<Object?>> docs) {
  List<Task> tasks = [];
  for (var element in docs) {
    tasks.add(Task.fromSnapshot(element));
  }
  return tasks;
}
