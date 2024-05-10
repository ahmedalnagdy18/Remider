import 'package:reminder_app/features/calendar/domain/entities/entity.dart';

abstract class UrgentTaskStates {}

class IntialUrgentTasks extends UrgentTaskStates {}

class LoadingUrgentTasks extends UrgentTaskStates {}

class SucsessUrgentTasks extends UrgentTaskStates {
  List<TaskEntity> tasks;

  SucsessUrgentTasks({required this.tasks});
}

class FailUrgentTasks extends UrgentTaskStates {}

class Faildel extends UrgentTaskStates {}

class Sucsessdel extends UrgentTaskStates {}
