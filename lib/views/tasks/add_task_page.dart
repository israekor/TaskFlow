import 'package:flutter/material.dart';

import '../../controllers/task_controller.dart';
import '../../models/task.dart';

class AddTaskPage extends StatefulWidget {
  final int userId;

  const AddTaskPage({super.key, required this.userId});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final _formKey = GlobalKey<FormState>();

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  final TaskController taskController = TaskController();

  String category = "Étude";
  String priority = "Moyenne";
  String date = "";

  bool isLoading = false;

  // Choisir une date
  Future<void> pickDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
      initialDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        date = "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }

  // Ajouter la tâche
  Future<void> saveTask() async {
    if (_formKey.currentState!.validate()) {
      if (date.isEmpty) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("Choisissez une date")));

        return;
      }

      setState(() {
        isLoading = true;
      });

      Task task = Task(
        title: titleController.text,
        description: descriptionController.text,
        category: category,
        priority: priority,
        date: date,
        userId: widget.userId,
      );

      await taskController.addTask(task);

      setState(() {
        isLoading = false;
      });

      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ajouter une tâche")),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Form(
          key: _formKey,

          child: ListView(
            children: [
              // Titre
              TextFormField(
                controller: titleController,

                decoration: const InputDecoration(
                  labelText: "Titre",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.title),
                ),

                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Entrez un titre";
                  }

                  return null;
                },
              ),

              const SizedBox(height: 15),

              // Description
              TextFormField(
                controller: descriptionController,

                maxLines: 3,

                decoration: const InputDecoration(
                  labelText: "Description",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.description),
                ),
              ),

              const SizedBox(height: 15),

              // Catégorie
              DropdownButtonFormField(
                value: category,

                decoration: const InputDecoration(
                  labelText: "Catégorie",
                  border: OutlineInputBorder(),
                ),

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

              // Priorité
              DropdownButtonFormField(
                value: priority,

                decoration: const InputDecoration(
                  labelText: "Priorité",
                  border: OutlineInputBorder(),
                ),

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

              // Date
              ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                  side: const BorderSide(),
                ),

                title: Text(date.isEmpty ? "Choisir une date" : date),

                trailing: const Icon(Icons.calendar_today),

                onTap: pickDate,
              ),

              const SizedBox(height: 25),

              // Bouton Ajouter
              SizedBox(
                height: 50,
                width: double.infinity,

                child: ElevatedButton(
                  onPressed: isLoading ? null : saveTask,

                  child: isLoading
                      ? const CircularProgressIndicator()
                      : const Text("Ajouter la tâche"),
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
