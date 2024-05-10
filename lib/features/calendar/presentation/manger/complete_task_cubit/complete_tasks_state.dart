import 'package:reminder_app/features/calendar/domain/entities/entity.dart';

abstract class CompleteTaskStates {}

class IntialCompleteTasks extends CompleteTaskStates {}

class LoadingCompleteTasks extends CompleteTaskStates {}

class SucCompleteTasks extends CompleteTaskStates {
  List<TaskEntity> tasks;

  SucCompleteTasks({required this.tasks});
}

class FailCompleteTasks extends CompleteTaskStates {}

class Faildel extends CompleteTaskStates {}

class Sucdel extends CompleteTaskStates {}
