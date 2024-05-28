import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reminder_app/features/calendar/data/repository_imp/repository_imp.dart';
import 'package:reminder_app/features/calendar/domain/usecases/get_upcoming_tasks_repository.dart';
import 'package:reminder_app/features/calendar/presentation/cubits/upcoming_task_cubit/upcoming_tasks_cubit.dart';
import 'package:reminder_app/features/calendar/presentation/cubits/upcoming_task_cubit/upcoming_tasks_state.dart';

import 'package:reminder_app/features/calendar/presentation/widgets/tasks_body.dart';
import 'package:reminder_app/injection.dart';

class UpcommingPage extends StatelessWidget {
  const UpcommingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UpComingTasksCubit>(
        create: (context) => UpComingTasksCubit(
            getUpComingTasksUsecase:
                GetupcommingTasksUsecase(repository: sl.get<TaskRepoImp>()))
          ..getUpcomingTask(),
        child: const UpcommingScreen());
  }
}

class UpcommingScreen extends StatefulWidget {
  const UpcommingScreen({super.key});

  @override
  State<UpcommingScreen> createState() => _UpcommingScreenState();
}

class _UpcommingScreenState extends State<UpcommingScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UpComingTasksCubit, UpComingTaskStates>(
      listener: (context, state) {
        if (state is Sucdel) {
          BlocProvider.of<UpComingTasksCubit>(context).getUpcomingTask();
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        return Scaffold(
            backgroundColor: Colors.white,
            body: state is LoadingUpComingTasks
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : state is SucUpComingTasks && state.tasks.isNotEmpty
                    ? ListView.separated(
                        scrollDirection: Axis.vertical,
                        physics: const BouncingScrollPhysics(),
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 10),
                        itemCount: state.tasks.length,
                        itemBuilder: (context, index) {
                          return TaskBody(
                            yesOnPressed: () async {
                              BlocProvider.of<UpComingTasksCubit>(context)
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
