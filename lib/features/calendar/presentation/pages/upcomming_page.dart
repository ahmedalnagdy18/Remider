import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:reminder_app/features/calendar/data/repository_imp/repository_imp.dart';
import 'package:reminder_app/features/calendar/domain/entities/entity.dart';
import 'package:reminder_app/features/calendar/domain/usecases/get_upcoming_tasks_repository.dart';
import 'package:reminder_app/features/calendar/presentation/cubits/upcoming_task_cubit/upcoming_tasks_cubit.dart';
import 'package:reminder_app/features/calendar/presentation/cubits/upcoming_task_cubit/upcoming_tasks_state.dart';
import 'package:reminder_app/features/calendar/presentation/widgets/tasks_body.dart';
import 'package:reminder_app/injection.dart';

class UpcommingPage extends StatefulWidget {
  const UpcommingPage({super.key});

  @override
  State<UpcommingPage> createState() => _UpcommingPageState();
}

class _UpcommingPageState extends State<UpcommingPage> {
  List<TaskEntity> data = [];

  @override
  void initState() {
    super.initState();
  }

  DateTime currentTime = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return BlocProvider<UpComingTasksCubit>(
      create: (context) => UpComingTasksCubit(
          getUpComingTasksUsecase:
              GetupcommingTasksUsecase(repository: sl.get<TaskRepoImp>()))
        ..getUpcomingTask(),
      child: BlocConsumer<UpComingTasksCubit, UpComingTaskStates>(
        listener: (context, state) {
          if (state is SucsessUpComingTasks) {
            data = state.tasks;
          }
          if (state is Sucsessdel) {
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          return Scaffold(
              backgroundColor: Colors.white,
              body: state is FailUpComingTasks
                  ? Container(
                      alignment: Alignment.topCenter,
                      child: const Text("There is no tasks"))
                  : state is LoadingUpComingTasks
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
                              yesOnPressed: () async {
                                BlocProvider.of<UpComingTasksCubit>(context)
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
