import 'package:flutter/material.dart';

import '../../controllers/task_controller.dart';
import '../../models/task.dart';
import '../../models/user.dart';
import '../auth/login_page.dart';
import 'add_task_page.dart';
import 'edit_task_page.dart';
import 'statistics_page.dart';

class HomePage extends StatefulWidget {
  final User user;

  const HomePage({super.key, required this.user});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TaskController taskController = TaskController();

  List<Task> tasks = [];

  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    loadTasks();
  }

  Future<void> loadTasks() async {
    final data = await taskController.getTasksByUser(widget.user.id!);

    setState(() {
      tasks = data;
      isLoading = false;
    });
  }

  Future<void> deleteTask(int id) async {
    await taskController.deleteTask(id);

    loadTasks();

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Tâche supprimée")));
  }

  Future<void> changeStatus(Task task) async {
    int newStatus = task.status == 0 ? 1 : 0;

    await taskController.updateStatus(task.id!, newStatus);

    loadTasks();
  }

  void logout() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bonjour ${widget.user.name}"),

        actions: [
          IconButton(
            icon: const Icon(Icons.bar_chart),

            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => StatisticsPage(userId: widget.user.id!),
                ),
              );
            },
          ),

          IconButton(onPressed: logout, icon: const Icon(Icons.logout)),
        ],
      ),

      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : tasks.isEmpty
          ? const Center(
              child: Text(
                "Aucune tâche disponible",
                style: TextStyle(fontSize: 18),
              ),
            )
          : ListView.builder(
              itemCount: tasks.length,

              itemBuilder: (context, index) {
                Task task = tasks[index];

                return Card(
                  margin: const EdgeInsets.all(10),

                  child: ListTile(
                    leading: Checkbox(
                      value: task.status == 1,

                      onChanged: (value) {
                        changeStatus(task);
                      },
                    ),

                    title: Text(
                      task.title,

                      style: TextStyle(
                        decoration: task.status == 1
                            ? TextDecoration.lineThrough
                            : null,
                      ),
                    ),

                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        Text(task.category),

                        Text("Priorité : ${task.priority}"),

                        Text("Date : ${task.date}"),
                      ],
                    ),

                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,

                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.blue),

                          onPressed: () async {
                            final result = await Navigator.push(
                              context,

                              MaterialPageRoute(
                                builder: (_) => EditTaskPage(task: task),
                              ),
                            );

                            if (result == true) {
                              loadTasks();
                            }
                          },
                        ),

                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),

                          onPressed: () {
                            deleteTask(task.id!);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),

      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          print("Bouton + cliqué");

          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => AddTaskPage(userId: widget.user.id!),
            ),
          );

          if (result == true) {
            loadTasks();
          }
        },

        child: const Icon(Icons.add),
      ),
    );
  }
}
