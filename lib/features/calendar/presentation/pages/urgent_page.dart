import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:reminder_app/features/calendar/presentation/pages/calendar_page.dart';
import 'package:reminder_app/features/calendar/presentation/widgets/tasks_body.dart';

class UrgentPage extends StatefulWidget {
  const UrgentPage({super.key});

  @override
  State<UrgentPage> createState() => _UrgentPageState();
}

class _UrgentPageState extends State<UrgentPage> {
  List<QueryDocumentSnapshot> data = [];

  getData() async {
    CollectionReference tasks = FirebaseFirestore.instance.collection("tasks");
    QuerySnapshot taskstype =
        await tasks.where("taskType", isEqualTo: "Urgent").get();
    for (var element in taskstype.docs) {
      data.add(element);
    }
    setState(() {});
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  DateTime currentTime = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: data.isEmpty
            ? Container(
                alignment: Alignment.topCenter,
                child: const Text("There is no tasks"))
            : ListView.separated(
                scrollDirection: Axis.vertical,
                physics: const BouncingScrollPhysics(),
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 10),
                itemCount: data.length,
                itemBuilder: (context, index) {
                  DateFormat dateFormat = DateFormat('d MMMM, hh:mm a');
                  String formattedDate = dateFormat.format(currentTime);
                  return TaskBody(
                    yesOnPressed: () async {
                      await FirebaseFirestore.instance
                          .collection("tasks")
                          .doc(data[index].id)
                          .delete();
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const CalendarPage(),
                      ));
                    },
                    descreption: '${data[index]['descreption']}',
                    title: '${data[index]['title']}',
                    taskType: '${data[index]['taskType']}',
                    date: formattedDate,
                  );
                },
              ));
  }
}
