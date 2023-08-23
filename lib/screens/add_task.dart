import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/Extra/Utils.dart';
import 'package:todo_app/widgets/custom_textfield.dart';

import '../controller/tasks_controller.dart';
import '../firestore/firestore.dart';
import '../model/Task.dart';

class AddTask extends StatefulWidget {
  const AddTask({Key? key, required this.isEdit, this.task, this.index}) : super(key: key);
  final bool isEdit;
  final Task? task;
  final int? index;

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  @override
  final TextEditingController _title = TextEditingController();
  final TextEditingController _desc = TextEditingController();
  final TextEditingController _dateC = TextEditingController();
  DateTime? _selectedDate;

  Widget build(BuildContext context) {
    if (widget.isEdit) {
      _selectedDate = DateTime.fromMillisecondsSinceEpoch(widget.task!.date);
      _title.text = widget.task!.title;
      _desc.text = widget.task!.description;
      _dateC.text =
          "${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}";
    }
    return AlertDialog(
      content: Container(
        height: 500,
        width: 350,
        padding: const EdgeInsets.only(top: 30),
        child: Column(
          children: [
            widget.isEdit
                ? const Text(
                    "Edit Task",
                    style: TextStyle(color: Colors.red, fontSize: 25),
                  )
                : const Text(
                    "Add New Task",
                    style: TextStyle(color: Colors.red, fontSize: 25),
                  ),
            Utils.vGap(30),
            CustomTextfield(height: 50, txt: "Enter Title", controller: _title),
            Utils.vGap(30),
            CustomTextfield(
                height: 100, txt: "Enter Description", controller: _desc),
            Utils.vGap(30),
            InkWell(
              child: Container(
                height: 60,
                decoration: BoxDecoration(
                  border: Border.all(width: 2),
                ),
                child: TextField(
                  controller: _dateC,
                  enabled: false,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.calendar_month),
                    hintText: "dd/mm/yyyy",
                    border: InputBorder.none,
                  ),
                ),
              ),
              onTap: () async {
                final DateTime? picked = await showDialog(
                    context: context,
                    builder: (ctx) => DatePickerDialog(
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(DateTime.now().year + 50)));
                if (picked != null) {
                  _selectedDate = picked;
                  _dateC.text = "${picked.day}/${picked.month}/${picked.year}";
                }
              },
            ),
            Utils.vGap(30),
            Row(
              children: [
                TextButton(
                  onPressed: () {
                    if (_title.text.isEmpty) {
                      Utils.showError(context, "Please enter title!");
                    } else if (_desc.text.isEmpty) {
                      Utils.showError(context, "Please enter description!");
                    } else if (_selectedDate == null) {
                      Utils.showError(context, "Please select date!");
                    } else {


                      if (widget.isEdit) {
                        widget.task!.title = _title.text;
                        widget.task!.description = _desc.text;
                        widget.task!.date =
                            _selectedDate!.millisecondsSinceEpoch;
                        if (FireStore.updateTask(widget.task!)) {

                          Utils.showError(context, "Successfully Updated!");

                        } else {
                          Utils.showError(
                              context, "ERROR!!!\nData not updated!");
                        }
                      } else {
                        Task? t = FireStore.addNewTask(_title.text, _desc.text,
                            _selectedDate!.millisecondsSinceEpoch);
                        if (t!=null) {
                          Utils.showError(context, "Successfully Added!");

                        } else {
                          Utils.showError(context, "ERROR!!!\nData not added!");
                        }
                      }
                      Navigator.of(context).pop();
                    }
                  },
                  child:
                      widget.isEdit ? const Text('Update') : const Text('Add'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _title.dispose();
    _desc.dispose();
    super.dispose();
  }

  @override
  void initialize() {}
}
