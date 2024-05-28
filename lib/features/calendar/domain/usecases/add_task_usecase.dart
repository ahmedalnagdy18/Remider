import 'package:reminder_app/features/calendar/domain/repository/repository.dart';

class AddTasksUsecase {
  TasksRepository repository;

  AddTasksUsecase({required this.repository});
  Future<void> call(
      String title, String descreption, String taskType, String time) async {
    return repository.addTask(
        title: title, descreption: descreption, taskType: taskType, time: time);
  }
}
