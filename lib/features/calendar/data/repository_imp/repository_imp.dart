import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reminder_app/features/calendar/data/data_sources/remote_data_source.dart';

import 'package:reminder_app/features/calendar/domain/repository/repository.dart';

class TaskRepoImp extends TasksRepository {
  CalendarRemoteDataSource dataSource;

  TaskRepoImp({required this.dataSource});

  @override
  Stream<QuerySnapshot> getAllTasks() {
    try {
      Stream<QuerySnapshot> data = dataSource.getAllTasks();
      return data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Stream<QuerySnapshot> getCompletedTasks() {
    try {
      Stream<QuerySnapshot> data = dataSource.getCompletedTasks();
      return data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Stream<QuerySnapshot> getUpcommingTasks() {
    try {
      Stream<QuerySnapshot> data = dataSource.getUpcommingTasks();
      return data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Stream<QuerySnapshot> getUrgentTasks() {
    try {
      Stream<QuerySnapshot> data = dataSource.getUrgentTasks();
      return data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> addTask({
    required String title,
    required String descreption,
    required String taskType,
    required String time,
  }) async {
    try {
      dataSource.addTask(
          title: title,
          descreption: descreption,
          taskType: taskType,
          time: time);
    } catch (e) {
      rethrow;
    }
  }
}
