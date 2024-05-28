import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reminder_app/features/calendar/domain/entities/entity.dart';

class Task extends TaskEntity {
  Task({
    required super.title,
    required super.descreption,
    required super.taskType,
    required super.id,
    required super.time,
  });

  factory Task.fromSnapshot(DocumentSnapshot map) {
    return Task(
      id: map.id,
      title: map.get('title'),
      descreption: map.get('descreption'),
      taskType: map.get('taskType'),
      time: map.get('time'),
    );
  }
}
