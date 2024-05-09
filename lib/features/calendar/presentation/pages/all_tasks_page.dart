import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:reminder_app/features/calendar/presentation/widgets/tasks_body.dart';

class AlltasksPage extends StatefulWidget {
  const AlltasksPage({super.key});

  @override
  State<AlltasksPage> createState() => _AlltasksPageState();
}

class _AlltasksPageState extends State<AlltasksPage> {
  List<QueryDocumentSnapshot> data = [];

  final Stream<QuerySnapshot> _taskStream =
      FirebaseFirestore.instance.collection('tasks').snapshots();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _taskStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Something went wrong'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: Text("Loading"));
          }

          return Scaffold(
              backgroundColor: Colors.white,
              body: snapshot.data!.docs.isEmpty
                  ? Container(
                      alignment: Alignment.topCenter,
                      child: const Text("There is no tasks"))
                  : ListView.separated(
                      scrollDirection: Axis.vertical,
                      physics: const BouncingScrollPhysics(),
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 10),
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        return TaskBody(
                          yesOnPressed: () async {
                            await FirebaseFirestore.instance
                                .collection("tasks")
                                .doc(snapshot.data!.docs[index].id)
                                .delete();
                            Navigator.of(context).pop();
                          },
                          descreption:
                              '${snapshot.data!.docs[index]['descreption']}',
                          title: '${snapshot.data!.docs[index]['title']}',
                          taskType: '${snapshot.data!.docs[index]['taskType']}',
                        );
                      },
                    ));
        });
  }
}
