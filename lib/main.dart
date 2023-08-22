import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:todo_app/controller/tasks_controller.dart';
import 'package:todo_app/screens/add_task.dart';
import 'package:todo_app/widgets/custom_ebutton.dart';

import 'Extra/Utils.dart';
import 'firebase_options.dart';
import 'firestore/firestore.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'ToDo App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const MyHomePage(
        title: 'ToDo App',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TaskController controller = Get.put(TaskController(),tag: 'cc');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Obx(<TaskController>(){
          if (controller.tasks.value.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }else{
            return ListView.builder(
              itemCount: controller.tasks.value.length,
              itemBuilder: (context, index) {
                return Card(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(width: 2),
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.6,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                controller.tasks.value[index].title,
                                style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.blueAccent),
                              ),
                              Utils.vGap(15),
                              Text(
                                controller.tasks.value[index].description,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Utils.vGap(10),
                              Text(
                                  DateTime.fromMillisecondsSinceEpoch(
                                      controller.tasks.value[index].date)
                                      .toString(),
                                  style: const TextStyle(
                                      fontSize: 16, color: Colors.red)),
                            ],
                          ),
                        ),
                        Utils.hGap(10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomEButton(
                                onTap: () async {
                                  Utils.openDialog(
                                      context,
                                      await AddTask(
                                          isEdit: true,
                                          task: controller.tasks.value[index],
                                          index: index,
                                      ),

                                  );

                                         // controller.fetchTasks();
                                },
                                icon: Icons.edit,
                                text: "Edit"),
                            CustomEButton(
                                onTap: () {
                                  FireStore.deleteTask(controller.tasks.value[index].id);
                                  controller.tasks.removeAt(index);
                                },
                                icon: Icons.delete,
                                text: "Delete"),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }


      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Utils.openDialog(
              context,
              const AddTask(
                isEdit: false,
              ));
        },
        tooltip: 'Add Task',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
