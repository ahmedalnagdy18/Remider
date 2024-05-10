import 'package:reminder_app/features/calendar/domain/entities/entity.dart';

abstract class UrgentTaskStates {}

class IntialUrgentTasks extends UrgentTaskStates {}

class LoadingUrgentTasks extends UrgentTaskStates {}

class SucUrgentTasks extends UrgentTaskStates {
  List<TaskEntity> tasks;

  SucUrgentTasks({required this.tasks});
}

class FailUrgentTasks extends UrgentTaskStates {}

class Faildel extends UrgentTaskStates {}

class Sucdel extends UrgentTaskStates {}
