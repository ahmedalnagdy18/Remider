import 'package:reminder_app/features/calendar/domain/entities/entity.dart';

abstract class AllTaskStates {}

class IntialAllTasks extends AllTaskStates {}

class LoadingAllTasks extends AllTaskStates {}

class SucAllTasks extends AllTaskStates {
  List<TaskEntity> tasks;

  SucAllTasks({required this.tasks});
}

class FailAllTasks extends AllTaskStates {}

class Faildel extends AllTaskStates {}

class Sucdel extends AllTaskStates {}
