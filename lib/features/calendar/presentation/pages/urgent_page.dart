import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:reminder_app/features/calendar/data/repository_imp/repository_imp.dart';
import 'package:reminder_app/features/calendar/domain/entities/entity.dart';

import 'package:reminder_app/features/calendar/domain/usecases/get_urgent_tasks_repository.dart';

import 'package:reminder_app/features/calendar/presentation/cubits/urgent_task_cubit/urgent_tasks_cubit.dart';
import 'package:reminder_app/features/calendar/presentation/cubits/urgent_task_cubit/urgent_tasks_state.dart';
import 'package:reminder_app/features/calendar/presentation/widgets/tasks_body.dart';
import 'package:reminder_app/injection.dart';

class UrgentPage extends StatefulWidget {
  const UrgentPage({super.key});

  @override
  State<UrgentPage> createState() => _UrgentPageState();
}

class _UrgentPageState extends State<UrgentPage> {
  List<TaskEntity> data = [];

  @override
  void initState() {
    super.initState();
  }

  DateTime currentTime = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return BlocProvider<UrgentTasksCubit>(
      create: (context) => UrgentTasksCubit(
          getUrgentTasksUsecase:
              GetUrgentTasksUsecase(repository: sl.get<TaskRepoImp>()))
        ..getAllTask(),
      child: BlocConsumer<UrgentTasksCubit, UrgentTaskStates>(
        listener: (context, state) {
          if (state is SucsessUrgentTasks) {
            data = state.tasks;
          }
          if (state is Sucsessdel) {
            BlocProvider.of<UrgentTasksCubit>(context).getAllTask();
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          return Scaffold(
              backgroundColor: Colors.white,
              body: state is FailUrgentTasks
                  ? Container(
                      alignment: Alignment.topCenter,
                      child: const Text("There is no tasks"))
                  : state is LoadingUrgentTasks
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
                                BlocProvider.of<UrgentTasksCubit>(context)
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
