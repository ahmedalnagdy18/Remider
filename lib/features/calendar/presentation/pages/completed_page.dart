import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:reminder_app/features/calendar/data/repository_imp/repository_imp.dart';
import 'package:reminder_app/features/calendar/domain/entities/entity.dart';
import 'package:reminder_app/features/calendar/domain/usecases/get_%20completed_tasks_repository.dart';
import 'package:reminder_app/features/calendar/presentation/cubits/complete_task_cubit/complete_tasks_cubit.dart';
import 'package:reminder_app/features/calendar/presentation/cubits/complete_task_cubit/complete_tasks_state.dart';
import 'package:reminder_app/features/calendar/presentation/widgets/tasks_body.dart';
import 'package:reminder_app/injection.dart';

class CompletedPage extends StatefulWidget {
  const CompletedPage({super.key});

  @override
  State<CompletedPage> createState() => _CompletedPageState();
}

class _CompletedPageState extends State<CompletedPage> {
  List<TaskEntity> data = [];

  @override
  void initState() {
    super.initState();
  }

  DateTime currentTime = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return BlocProvider<CompleteTasksCubit>(
      create: (context) => CompleteTasksCubit(
          getCompletedTasksUsecase:
              GetCompletedTasksUsecase(repository: sl.get<TaskRepoImp>()))
        ..getCompletedTasks(),
      child: BlocConsumer<CompleteTasksCubit, CompleteTaskStates>(
        listener: (context, state) {
          if (state is SucsessCompleteTasks) {
            data = state.tasks;
          }
          if (state is Sucsessdel) {
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          return Scaffold(
              backgroundColor: Colors.white,
              body: state is FailCompleteTasks
                  ? Container(
                      alignment: Alignment.topCenter,
                      child: const Text("There is no tasks"))
                  : state is LoadingCompleteTasks
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
                                BlocProvider.of<CompleteTasksCubit>(context)
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
