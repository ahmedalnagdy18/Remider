import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:reminder_app/features/calendar/presentation/pages/calendar_page.dart';
import 'package:reminder_app/features/calendar/presentation/widgets/tasks_body.dart';

class CompletedPage extends StatefulWidget {
  const CompletedPage({super.key});

  @override
  State<CompletedPage> createState() => _CompletedPageState();
}

class _CompletedPageState extends State<CompletedPage> {
  List<QueryDocumentSnapshot> data = [];

  getData() async {
    CollectionReference tasks = FirebaseFirestore.instance.collection("tasks");
    QuerySnapshot taskstype =
        await tasks.where("taskType", isEqualTo: "Complete").get();
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
                  );
                },
              ));
  }
}
