import 'package:reminder_app/features/calendar/domain/entities/entity.dart';

abstract class CompleteTaskStates {}

class IntialCompleteTasks extends CompleteTaskStates {}

class LoadingCompleteTasks extends CompleteTaskStates {}

class SucsessCompleteTasks extends CompleteTaskStates {
  List<TaskEntity> tasks;

  SucsessCompleteTasks({required this.tasks});
}

class FailCompleteTasks extends CompleteTaskStates {}

class Faildel extends CompleteTaskStates {}

class Sucsessdel extends CompleteTaskStates {}
