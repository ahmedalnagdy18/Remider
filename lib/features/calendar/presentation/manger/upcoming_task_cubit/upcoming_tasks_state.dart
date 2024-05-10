import 'package:reminder_app/features/calendar/domain/entities/entity.dart';

abstract class UpComingTaskStates {}

class IntialUpComingTasks extends UpComingTaskStates {}

class LoadingUpComingTasks extends UpComingTaskStates {}

class SucUpComingTasks extends UpComingTaskStates {
  List<TaskEntity> tasks;

  SucUpComingTasks({required this.tasks});
}

class FailUpComingTasks extends UpComingTaskStates {}

class Faildel extends UpComingTaskStates {}

class Sucdel extends UpComingTaskStates {}
