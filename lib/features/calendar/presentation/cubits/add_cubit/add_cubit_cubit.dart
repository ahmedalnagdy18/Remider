import 'package:bloc/bloc.dart';

import 'package:reminder_app/features/calendar/domain/usecases/add_task_usecase.dart';

part 'add_cubit_state.dart';

class AddCubit extends Cubit<AddCubitState> {
  AddCubit({required this.addTasksUsecase}) : super(AddCubitInitial());
  AddTasksUsecase addTasksUsecase;
  Future<void> addTask(title, descreption, taskType, time) async {
    try {
      emit(AddCubitLoading());
      addTasksUsecase.call(title, descreption, taskType, time);
      emit(AddCubitSucsess());
    } on Exception {
      emit(AddCubitFail());
    }
  }
}
