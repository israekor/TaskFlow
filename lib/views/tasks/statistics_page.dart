import 'package:flutter/material.dart';

import '../../controllers/task_controller.dart';

class StatisticsPage extends StatefulWidget {
  final int userId;

  const StatisticsPage({super.key, required this.userId});

  @override
  State<StatisticsPage> createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  final TaskController taskController = TaskController();

  int total = 0;
  int completed = 0;
  int pending = 0;

  bool loading = true;

  @override
  void initState() {
    super.initState();

    loadStatistics();
  }

  Future<void> loadStatistics() async {
    total = await taskController.getTotalTasks(widget.userId);

    completed = await taskController.getCompletedTasks(widget.userId);

    pending = await taskController.getPendingTasks(widget.userId);

    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    double percentage = total == 0 ? 0 : (completed / total) * 100;

    return Scaffold(
      appBar: AppBar(title: const Text("Statistiques")),

      body: loading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(20),

              child: Column(
                children: [
                  Card(
                    child: ListTile(
                      leading: const Icon(Icons.list, color: Colors.blue),

                      title: const Text("Nombre total des tâches"),

                      trailing: Text(
                        "$total",
                        style: const TextStyle(fontSize: 22),
                      ),
                    ),
                  ),

                  Card(
                    child: ListTile(
                      leading: const Icon(
                        Icons.check_circle,
                        color: Colors.green,
                      ),

                      title: const Text("Tâches terminées"),

                      trailing: Text(
                        "$completed",
                        style: const TextStyle(fontSize: 22),
                      ),
                    ),
                  ),

                  Card(
                    child: ListTile(
                      leading: const Icon(Icons.schedule, color: Colors.orange),

                      title: const Text("Tâches en cours"),

                      trailing: Text(
                        "$pending",
                        style: const TextStyle(fontSize: 22),
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  Text(
                    "Progression : ${percentage.toStringAsFixed(1)} %",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 20),

                  LinearProgressIndicator(
                    value: percentage / 100,
                    minHeight: 15,
                  ),
                ],
              ),
            ),
    );
  }
}
