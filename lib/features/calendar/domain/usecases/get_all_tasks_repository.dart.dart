import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:reminder_app/features/calendar/domain/repository/repository.dart';

class GetAllTasksUsecase {
  TasksRepository repository;

  GetAllTasksUsecase({required this.repository});
  Future<Stream<QuerySnapshot<Object?>>> call() async {
    return repository.getAllTasks();
  }
}
