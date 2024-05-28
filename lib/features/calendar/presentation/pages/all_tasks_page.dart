import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:reminder_app/features/calendar/data/repository_imp/repository_imp.dart';

import 'package:reminder_app/features/calendar/domain/usecases/get_all_tasks_repository.dart.dart';
import 'package:reminder_app/features/calendar/presentation/cubits/all_task_cubit/task_cubit.dart';
import 'package:reminder_app/features/calendar/presentation/cubits/all_task_cubit/task_states.dart';

import 'package:reminder_app/features/calendar/presentation/widgets/tasks_body.dart';
import 'package:reminder_app/injection.dart';

class AlltasksPage extends StatelessWidget {
  const AlltasksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AllTaskCubit>(
        create: (context) => AllTaskCubit(
            getAllTasks: GetAllTasksUsecase(repository: sl.get<TaskRepoImp>()))
          ..getAllTask(),
        child: const AlltasksScreen());
  }
}

class AlltasksScreen extends StatefulWidget {
  const AlltasksScreen({super.key});

  @override
  State<AlltasksScreen> createState() => _AlltasksScreenState();
}

class _AlltasksScreenState extends State<AlltasksScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AllTaskCubit, AllTaskStates>(
      listener: (context, state) {
        if (state is SucsessDelete) {
          Navigator.of(context).pop();
          BlocProvider.of<AllTaskCubit>(context).getAllTask();
        }
      },
      builder: (context, state) {
        return Scaffold(
            backgroundColor: Colors.white,
            body: state is LoadingAllTasks
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : state is SucsessAllTasks && state.tasks.isNotEmpty
                    ? ListView.separated(
                        scrollDirection: Axis.vertical,
                        physics: const BouncingScrollPhysics(),
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 10),
                        itemCount: state.tasks.length,
                        itemBuilder: (context, index) {
                          return TaskBody(
                            yesOnPressed: () {
                              BlocProvider.of<AllTaskCubit>(context)
                                  .deltask(state.tasks[index].id);
                            },
                            descreption: state.tasks[index].descreption,
                            title: state.tasks[index].title,
                            taskType: state.tasks[index].taskType,
                            date: state.tasks[index].time,
                          );
                        },
                      )
                    : Container(
                        alignment: Alignment.topCenter,
                        child: const Text("There is no tasks")));
      },
    );
  }
}
