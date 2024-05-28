import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:reminder_app/features/calendar/data/repository_imp/repository_imp.dart';

import 'package:reminder_app/features/calendar/domain/usecases/get_urgent_tasks_repository.dart';

import 'package:reminder_app/features/calendar/presentation/cubits/urgent_task_cubit/urgent_tasks_cubit.dart';
import 'package:reminder_app/features/calendar/presentation/cubits/urgent_task_cubit/urgent_tasks_state.dart';

import 'package:reminder_app/features/calendar/presentation/widgets/tasks_body.dart';
import 'package:reminder_app/injection.dart';

class UrgentPage extends StatelessWidget {
  const UrgentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UrgentTasksCubit>(
        create: (context) => UrgentTasksCubit(
            getUrgentTasksUsecase:
                GetUrgentTasksUsecase(repository: sl.get<TaskRepoImp>()))
          ..getAllTask(),
        child: const UrgentScreen());
  }
}

class UrgentScreen extends StatefulWidget {
  const UrgentScreen({super.key});

  @override
  State<UrgentScreen> createState() => _UrgentScreenState();
}

class _UrgentScreenState extends State<UrgentScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UrgentTasksCubit, UrgentTaskStates>(
      listener: (context, state) {
        if (state is Sucdel) {
          BlocProvider.of<UrgentTasksCubit>(context).getAllTask();
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        return Scaffold(
            backgroundColor: Colors.white,
            body: state is LoadingUrgentTasks
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : state is SucUrgentTasks && state.tasks.isNotEmpty
                    ? ListView.separated(
                        scrollDirection: Axis.vertical,
                        physics: const BouncingScrollPhysics(),
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 10),
                        itemCount: state.tasks.length,
                        itemBuilder: (context, index) {
                          return TaskBody(
                            yesOnPressed: () {
                              BlocProvider.of<UrgentTasksCubit>(context)
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
