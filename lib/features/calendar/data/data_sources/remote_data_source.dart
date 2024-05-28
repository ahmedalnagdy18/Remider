import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:reminder_app/features/calendar/data/data_sources/data_source.dart';

abstract class RemoteDataSource {
  Stream<QuerySnapshot> getAllTasks();
  Stream<QuerySnapshot> getUrgentTasks();
  Stream<QuerySnapshot> getCompletedTasks();
  Stream<QuerySnapshot> getUpcommingTasks();
  Future<void> addTask({
    required String title,
    required String descreption,
    required String taskType,
    required String time,
  });
}

class CalendarRemoteDataSource extends RemoteDataSource {
  FirebaseDataSource dataSource;
  CalendarRemoteDataSource({required this.dataSource});

  @override
  Stream<QuerySnapshot> getAllTasks() {
    Stream<QuerySnapshot> tasks = dataSource.getAllData();

    return tasks;
  }

  @override
  Stream<QuerySnapshot> getCompletedTasks() {
    Stream<QuerySnapshot> tasks = dataSource.getData(type: 'Complete');

    return tasks;
  }

  @override
  Stream<QuerySnapshot> getUpcommingTasks() {
    Stream<QuerySnapshot> tasks = dataSource.getData(type: 'Upcoming');

    return tasks;
  }

  @override
  Stream<QuerySnapshot> getUrgentTasks() {
    Stream<QuerySnapshot> tasks = dataSource.getData(type: 'Urgent');

    return tasks;
  }

  @override
  Future<void> addTask({
    required String title,
    required String descreption,
    required String taskType,
    required String time,
  }) async {
    dataSource.addTask(
      title: title,
      descreption: descreption,
      taskType: taskType,
      time: time,
    );
  }
}
