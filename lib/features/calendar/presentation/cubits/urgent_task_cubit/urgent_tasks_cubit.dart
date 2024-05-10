import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reminder_app/features/calendar/data/models/model.dart';
import 'package:reminder_app/features/calendar/domain/entities/entity.dart';

import 'package:reminder_app/features/calendar/domain/usecases/get_urgent_tasks_repository.dart';
import 'package:reminder_app/features/calendar/presentation/cubits/urgent_task_cubit/urgent_tasks_state.dart';

class UrgentTasksCubit extends Cubit<UrgentTaskStates> {
  UrgentTasksCubit({required this.getUrgentTasksUsecase})
      : super(IntialUrgentTasks());
  GetUrgentTasksUsecase getUrgentTasksUsecase;
  getAllTask() async {
    try {
      List<TaskEntity> tasks = [];
      emit(LoadingUrgentTasks());
      var data = await getUrgentTasksUsecase.call();
      data.listen((event) {
        for (var element in event.docs) {
          tasks.add(Task.fromSnapshot(element));
        }

        emit(SucsessUrgentTasks(tasks: tasks));
      });
    } on Exception {
      emit(FailUrgentTasks());
    }
  }

  deltask(String id) async {
    try {
      emit(LoadingUrgentTasks());
      await FirebaseFirestore.instance.collection("tasks").doc(id).delete();

      emit(Sucsessdel());
      getAllTask();
    } on Exception {
      emit(Faildel());
    }
  }
}
