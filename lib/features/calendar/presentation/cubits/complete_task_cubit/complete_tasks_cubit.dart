import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reminder_app/features/calendar/domain/entities/entity.dart';
import 'package:reminder_app/features/calendar/domain/usecases/get_%20completed_tasks_repository.dart';

import 'package:reminder_app/features/calendar/presentation/cubits/complete_task_cubit/complete_tasks_state.dart';
import 'package:reminder_app/features/calendar/domain/services.dart/totask.dart';

class CompleteTasksCubit extends Cubit<CompleteTaskStates> {
  CompleteTasksCubit({required this.getCompletedTasksUsecase})
      : super(IntialCompleteTasks());
  GetCompletedTasksUsecase getCompletedTasksUsecase;
  getCompletedTasks() async {
    try {
      List<TaskEntity> tasks = [];
      emit(LoadingCompleteTasks());
      var data = await getCompletedTasksUsecase.call();
      data.listen((event) {
        tasks = totask(event.docs);

        emit(SucCompleteTasks(tasks: tasks));
      });
    } on Exception {
      emit(FailCompleteTasks());
    }
  }

  deltask(String id) async {
    try {
      emit(LoadingCompleteTasks());
      await FirebaseFirestore.instance.collection("tasks").doc(id).delete();
      emit(Sucdel());
    } on Exception {
      emit(Faildel());
    }
  }
}
