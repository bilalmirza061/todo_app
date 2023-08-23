import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../model/Task.dart';

class DataProvider extends ChangeNotifier {
  DataProvider() {
    fetchTasks();
  }

  List<Task> tasks = <Task>[];

  StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? taskStream;

  void fetchTasks() async {
    taskStream = FirebaseFirestore.instance
        .collection('tasks')
        .snapshots()
        .listen((event) {
      tasks = [];
      List<Task> list = event.docs.map((e) => Task.fromJson(e.data())).toList();
      tasks = list;
      notifyListeners();
    });
  }
}
