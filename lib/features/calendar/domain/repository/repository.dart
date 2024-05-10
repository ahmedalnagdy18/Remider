import 'package:cloud_firestore/cloud_firestore.dart';

abstract class TasksRepository {
  Stream<QuerySnapshot> getAllTasks();
  Stream<QuerySnapshot> getUrgentTasks();
  Stream<QuerySnapshot> getCompletedTasks();
  Stream<QuerySnapshot> getUpcommingTasks();
}
