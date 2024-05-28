import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:reminder_app/features/calendar/data/repository_imp/repository_imp.dart';

import 'package:reminder_app/features/calendar/domain/usecases/get_%20completed_tasks_repository.dart';

import 'package:reminder_app/features/calendar/presentation/cubits/complete_task_cubit/complete_tasks_cubit.dart';
import 'package:reminder_app/features/calendar/presentation/cubits/complete_task_cubit/complete_tasks_state.dart';

import 'package:reminder_app/features/calendar/presentation/widgets/tasks_body.dart';
import 'package:reminder_app/injection.dart';

class CompletedPage extends StatelessWidget {
  const CompletedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CompleteTasksCubit>(
        create: (context) => CompleteTasksCubit(
            getCompletedTasksUsecase:
                GetCompletedTasksUsecase(repository: sl.get<TaskRepoImp>()))
          ..getCompletedTasks(),
        child: const CompletedScreen());
  }
}

class CompletedScreen extends StatefulWidget {
  const CompletedScreen({super.key});

  @override
  State<CompletedScreen> createState() => _CompletedScreenState();
}

class _CompletedScreenState extends State<CompletedScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CompleteTasksCubit, CompleteTaskStates>(
      listener: (context, state) {
        if (state is Sucdel) {
          Navigator.pop(context);
          BlocProvider.of<CompleteTasksCubit>(context).getCompletedTasks();
        }
      },
      builder: (context, state) {
        return Scaffold(
            backgroundColor: Colors.white,
            body: state is LoadingCompleteTasks
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : state is SucCompleteTasks && state.tasks.isNotEmpty
                    ? ListView.separated(
                        scrollDirection: Axis.vertical,
                        physics: const BouncingScrollPhysics(),
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 10),
                        itemCount: state.tasks.length,
                        itemBuilder: (context, index) {
                          return TaskBody(
                            yesOnPressed: () {
                              BlocProvider.of<CompleteTasksCubit>(context)
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
