import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reminder_app/features/calendar/data/models/model.dart';
import 'package:reminder_app/features/calendar/domain/entities/entity.dart';
import 'package:reminder_app/features/calendar/domain/usecases/get_all_tasks_repository.dart.dart';

import 'package:reminder_app/features/calendar/presentation/cubits/all_task_cubit/task_states.dart';

class AllTaskCubit extends Cubit<AllTaskStates> {
  AllTaskCubit({required this.getAllTasks}) : super(IntialAllTasks());
  final GetAllTasksUsecase getAllTasks;
  getAllTask() async {
    try {
      List<TaskEntity> tasks = [];
      emit(LoadingAllTasks());
      var data = await getAllTasks.call();
      data.listen((event) {
        for (var element in event.docs) {
          tasks.add(Task.fromSnapshot(element));
        }

        emit(SucAllTasks(tasks: tasks));
      });
    } on Exception {
      emit(FailAllTasks());
    }
  }

  deltask(String id) async {
    try {
      emit(LoadingAllTasks());
      await FirebaseFirestore.instance.collection("tasks").doc(id).delete();

      emit(Sucdel());
      await getAllTask();
    } on Exception {
      emit(Faildel());
    }
  }
}
