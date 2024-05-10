import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:reminder_app/features/calendar/data/repository_imp/repository_imp.dart';
import 'package:reminder_app/features/calendar/domain/entities/entity.dart';
import 'package:reminder_app/features/calendar/domain/usecases/get_all_tasks_repository.dart.dart';
import 'package:reminder_app/features/calendar/presentation/cubits/all_task_cubit/task_cubit.dart';
import 'package:reminder_app/features/calendar/presentation/cubits/all_task_cubit/task_states.dart';
import 'package:reminder_app/features/calendar/presentation/widgets/tasks_body.dart';
import 'package:reminder_app/injection.dart';

class AlltasksPage extends StatefulWidget {
  const AlltasksPage({super.key});

  @override
  State<AlltasksPage> createState() => _AlltasksPageState();
}

class _AlltasksPageState extends State<AlltasksPage> {
  @override
  void initState() {
    super.initState();
  }

  List<TaskEntity> data = [];
  DateTime currentTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AllTaskCubit>(
      create: (context) => AllTaskCubit(
          getAllTasks: GetAllTasksUsecase(repository: sl.get<TaskRepoImp>()))
        ..getAllTask(),
      child: BlocConsumer<AllTaskCubit, AllTaskStates>(
        listener: (context, state) {
          if (state is SucAllTasks) {
            data = state.tasks;
          }
          if (state is Sucdel) {
            Navigator.of(context).pop();
          }
        },
        builder: (context, state) {
          return Scaffold(
              backgroundColor: Colors.white,
              body: state is FailAllTasks
                  ? Container(
                      alignment: Alignment.topCenter,
                      child: const Text("There is no tasks"))
                  : state is LoadingAllTasks
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : ListView.separated(
                          scrollDirection: Axis.vertical,
                          physics: const BouncingScrollPhysics(),
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 10),
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            DateFormat dateFormat =
                                DateFormat('d MMMM, hh:mm a');
                            String formattedDate =
                                dateFormat.format(currentTime);

                            return TaskBody(
                              yesOnPressed: () {
                                BlocProvider.of<AllTaskCubit>(context)
                                    .deltask(data[index].id);
                              },
                              descreption: data[index].descreption,
                              title: data[index].title,
                              taskType: data[index].taskType,
                              date: formattedDate,
                            );
                          },
                        ));
        },
      ),
    );
  }
}
