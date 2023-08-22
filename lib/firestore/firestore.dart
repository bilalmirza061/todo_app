import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/Task.dart';

class FireStore {
  static Task? addNewTask(String title, String desc, int date) {
    try {
      CollectionReference tasksCollection =
          FirebaseFirestore.instance.collection('tasks');

      var doc = tasksCollection.doc();

      doc.set({
        'title': title,
        'description': desc,
        'date': date,
        'id': doc.id,
      });
      Task t = Task(id: doc.id, title: title, description: desc, date: date);
      return t;
    } catch (ex) {
      return null;
    }
  }

  static void deleteTask(String id) async {
    await FirebaseFirestore.instance.collection('tasks').doc(id).delete();

  }

  static bool updateTask(Task task) {
    try {
      DocumentReference docRef =
          FirebaseFirestore.instance.collection('tasks').doc(task.id);
      docRef.update({
        'title': task.title,
        'description': task.description,
        'date': task.date,
      });
      return true;
    } catch (ex) {
      return false;
    }
  }
}
