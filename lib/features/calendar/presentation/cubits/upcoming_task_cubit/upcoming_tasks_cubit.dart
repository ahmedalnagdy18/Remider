import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reminder_app/features/calendar/domain/entities/entity.dart';

import 'package:reminder_app/features/calendar/domain/usecases/get_upcoming_tasks_repository.dart';
import 'package:reminder_app/features/calendar/presentation/cubits/upcoming_task_cubit/upcoming_tasks_state.dart';
import 'package:reminder_app/features/calendar/domain/services.dart/totask.dart';

class UpComingTasksCubit extends Cubit<UpComingTaskStates> {
  UpComingTasksCubit({required this.getUpComingTasksUsecase})
      : super(IntialUpComingTasks());
  GetupcommingTasksUsecase getUpComingTasksUsecase;
  getUpcomingTask() async {
    try {
      emit(LoadingUpComingTasks());
      List<TaskEntity> tasks = [];
      var data = await getUpComingTasksUsecase.call();
      data.listen((event) {
        tasks = totask(event.docs);

        emit(SucUpComingTasks(tasks: tasks));
      });
    } on Exception {
      emit(FailUpComingTasks());
    }
  }

  deltask(String id) async {
    try {
      emit(LoadingUpComingTasks());
      await FirebaseFirestore.instance.collection("tasks").doc(id).delete();

      emit(Sucdel());
    } on Exception {
      emit(Faildel());
    }
  }
}
