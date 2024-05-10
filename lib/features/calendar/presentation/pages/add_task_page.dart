import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:reminder_app/features/calendar/presentation/pages/calendar_page.dart';
import 'package:reminder_app/features/calendar/presentation/widgets/floating_button.dart';
import 'package:reminder_app/features/calendar/presentation/widgets/textfield_widget.dart';


class AddtaskPage extends StatefulWidget {
  const AddtaskPage({super.key});

  @override
  State<AddtaskPage> createState() => _AddtaskPageState();
}

class _AddtaskPageState extends State<AddtaskPage> {
  var items = [
    'Upcoming',
    'Complete',
    'Urgent',
  ];

  final TextEditingController title = TextEditingController();

  final TextEditingController descreption = TextEditingController();
  final TextEditingController taskType = TextEditingController();

  CollectionReference tasks = FirebaseFirestore.instance.collection('tasks');

  Future<void> addTask() {
    return tasks
        .add({
          'title': title.text, 
          'descreption': descreption.text, 
          'taskType': taskType.text 
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 30, right: 10),
        child: FloatingWidget(
          onPressed: () {
            addTask();
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const CalendarPage(),
            ));
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
        child: Column(
          children: [
            TextfieldWidget(hintText: "Enter task title", controller: title),
            const SizedBox(height: 20),
            TextfieldWidget(
                hintText: "Enter task descreption", controller: descreption),
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
                    return items.map<PopupMenuItem<String>>((String value) {
                      return PopupMenuItem(value: value, child: Text(value));
                    }).toList();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
