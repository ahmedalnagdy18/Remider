import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:reminder_app/features/calendar/presentation/pages/calendar_page.dart';
import 'package:reminder_app/features/calendar/presentation/widgets/tasks_body.dart';

class AlltasksPage extends StatefulWidget {
  const AlltasksPage({super.key});

  @override
  State<AlltasksPage> createState() => _AlltasksPageState();
}

class _AlltasksPageState extends State<AlltasksPage> {
  List<QueryDocumentSnapshot> data = [];

  getData() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection("tasks").get();
    data.addAll(querySnapshot.docs);
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
