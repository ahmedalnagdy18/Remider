import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:reminder_app/features/calendar/data/repository_imp/repository_imp.dart';
import 'package:reminder_app/features/calendar/domain/usecases/add_task_usecase.dart';
import 'package:reminder_app/features/calendar/presentation/cubits/add_cubit/add_cubit_cubit.dart';
import 'package:reminder_app/features/calendar/presentation/pages/calendar_page.dart';
import 'package:reminder_app/features/calendar/presentation/widgets/floating_button.dart';
import 'package:reminder_app/features/calendar/presentation/widgets/textfield_widget.dart';
import 'package:reminder_app/injection.dart';

class AddtaskPge extends StatelessWidget {
  const AddtaskPge({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AddCubit>(
        create: (context) => AddCubit(
            addTasksUsecase:
                AddTasksUsecase(repository: sl.get<TaskRepoImp>())),
        child: const AddtaskScreen());
  }
}

class AddtaskScreen extends StatefulWidget {
  const AddtaskScreen({super.key});

  @override
  State<AddtaskScreen> createState() => _AddtaskScreenState();
}

class _AddtaskScreenState extends State<AddtaskScreen> {
  var items = [
    'Upcoming',
    'Complete',
    'Urgent',
  ];

  final TextEditingController title = TextEditingController();

  final TextEditingController descreption = TextEditingController();
  final TextEditingController taskType = TextEditingController();

  DateTime currentTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddCubit, AddCubitState>(
      listener: (context, state) {
        if (state is AddCubitSucsess) {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const CalendarPage(),
          ));
        }
      },
      builder: (context, state) {
        DateFormat dateFormat = DateFormat('d MMMM, hh:mm a');
        String formattedDate = dateFormat.format(currentTime);

        return Scaffold(
          floatingActionButton: Padding(
            padding: const EdgeInsets.only(bottom: 30, right: 10),
            child: FloatingWidget(
              onPressed: () {
                if (title.text.isEmpty ||
                    descreption.text.isEmpty ||
                    taskType.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    backgroundColor: Colors.red,
                    content: const Text('Error ! you must write all field'),
                    action: SnackBarAction(
                      label: 'Undo',
                      textColor: Colors.white,
                      onPressed: () {},
                    ),
                  ));
                } else {
                  BlocProvider.of<AddCubit>(context).addTask(
                    title.text,
                    descreption.text,
                    taskType.text,
                    formattedDate,
                  );
                }
              },
              icon: Icons.save,
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
          backgroundColor: Colors.white,
          appBar: AppBar(
              centerTitle: true,
              title: const Text(
                'Add Task',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              )),
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  TextfieldWidget(
                      hintText: "Enter task title", controller: title),
                  const SizedBox(height: 20),
                  TextfieldWidget(
                      hintText: "Enter task descreption",
                      controller: descreption),
                  const SizedBox(height: 20),
                  TextField(
                    controller: taskType,
                    readOnly: true,
                    decoration: InputDecoration(
                      hintText: 'Select task type',
                      hintStyle: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                      suffixIcon: PopupMenuButton<String>(
                        icon: const Icon(Icons.arrow_drop_down),
                        onSelected: (String value) {
                          taskType.text = value;
                        },
                        itemBuilder: (BuildContext context) {
                          return items
                              .map<PopupMenuItem<String>>((String value) {
                            return PopupMenuItem(
                                value: value, child: Text(value));
                          }).toList();
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
