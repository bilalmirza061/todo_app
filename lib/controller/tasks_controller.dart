import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../model/Task.dart';

class TaskController extends GetxController {
  RxList<Task> tasks = <Task>[].obs;

  @override
  void onInit() {
    fetchTasks();
    super.onInit();
  }

  StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? taskStream;

  void fetchTasks() async {
    taskStream = FirebaseFirestore.instance
        .collection('tasks')
        .snapshots()
        .listen((event) {
      List<Task> list = event.docs.map((e) => Task.fromJson(e.data())).toList();
      tasks.value = list;
    });
  }

  void updateTask(Task t, int index) {
    tasks.value[index].title = t.title;
    tasks.value[index].description = t.description;
    tasks.value[index].date = t.date;
  }

  @override
  void dispose() {
    super.dispose();
    taskStream?.cancel();
  }
}
