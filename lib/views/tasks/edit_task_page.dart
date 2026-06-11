import 'package:flutter/material.dart';

import '../../controllers/task_controller.dart';
import '../../models/task.dart';

class EditTaskPage extends StatefulWidget {
  final Task task;

  const EditTaskPage({super.key, required this.task});

  @override
  State<EditTaskPage> createState() => _EditTaskPageState();
}

class _EditTaskPageState extends State<EditTaskPage> {
  final _formKey = GlobalKey<FormState>();

  final TaskController taskController = TaskController();

  late TextEditingController titleController;
  late TextEditingController descriptionController;

  late String category;
  late String priority;
  late String date;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    titleController = TextEditingController(text: widget.task.title);

    descriptionController = TextEditingController(
      text: widget.task.description,
    );

    category = widget.task.category;
    priority = widget.task.priority;
    date = widget.task.date;
  }

  Future<void> pickDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2024),
      lastDate: DateTime(2030),
    );

    if (picked != null) {
      setState(() {
        date = "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }

  Future<void> updateTask() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });

      Task updatedTask = Task(
        id: widget.task.id,
        title: titleController.text,
        description: descriptionController.text,
        category: category,
        priority: priority,
        date: date,
        status: widget.task.status,
        userId: widget.task.userId,
      );

      await taskController.updateTask(updatedTask);

      setState(() {
        isLoading = false;
      });

      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Modifier la tâche")),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Form(
          key: _formKey,

          child: ListView(
            children: [
              TextFormField(
                controller: titleController,

                decoration: const InputDecoration(
                  labelText: "Titre",
                  border: OutlineInputBorder(),
                ),

                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Entrez un titre";
                  }

                  return null;
                },
              ),

              const SizedBox(height: 15),

              TextFormField(
                controller: descriptionController,
                maxLines: 3,

                decoration: const InputDecoration(
                  labelText: "Description",
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 15),

              DropdownButtonFormField(
                value: category,

                items: const [
                  DropdownMenuItem(value: "Étude", child: Text("Étude")),

                  DropdownMenuItem(value: "Travail", child: Text("Travail")),

                  DropdownMenuItem(
                    value: "Personnel",
                    child: Text("Personnel"),
                  ),

                  DropdownMenuItem(value: "Sport", child: Text("Sport")),
                ],

                onChanged: (value) {
                  setState(() {
                    category = value!;
                  });
                },
              ),

              const SizedBox(height: 15),

              DropdownButtonFormField(
                value: priority,

                items: const [
                  DropdownMenuItem(value: "Faible", child: Text("Faible")),

                  DropdownMenuItem(value: "Moyenne", child: Text("Moyenne")),

                  DropdownMenuItem(value: "Haute", child: Text("Haute")),
                ],

                onChanged: (value) {
                  setState(() {
                    priority = value!;
                  });
                },
              ),

              const SizedBox(height: 15),

              ListTile(
                title: Text(date),

                trailing: const Icon(Icons.calendar_month),

                onTap: pickDate,
              ),

              const SizedBox(height: 25),

              SizedBox(
                width: double.infinity,
                height: 50,

                child: ElevatedButton(
                  onPressed: isLoading ? null : updateTask,

                  child: isLoading
                      ? const CircularProgressIndicator()
                      : const Text("Modifier"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();

    super.dispose();
  }
}
