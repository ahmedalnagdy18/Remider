import 'package:reminder_app/features/calendar/domain/entities/entity.dart';

abstract class UpComingTaskStates {}

class IntialUpComingTasks extends UpComingTaskStates {}

class LoadingUpComingTasks extends UpComingTaskStates {}

class SucsessUpComingTasks extends UpComingTaskStates {
  List<TaskEntity> tasks;

  SucsessUpComingTasks({required this.tasks});
}

class FailUpComingTasks extends UpComingTaskStates {}

class Faildel extends UpComingTaskStates {}

class Sucsessdel extends UpComingTaskStates {}
