import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reminder_app/features/calendar/domain/repository/repository.dart';

class GetupcommingTasksUsecase {
  TasksRepository repository;

  GetupcommingTasksUsecase({required this.repository});
  Future<Stream<QuerySnapshot<Object?>>> call() async {
    return await repository.getUpcommingTasks();
  }
}
