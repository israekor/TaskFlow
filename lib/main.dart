import 'package:flutter/material.dart';
import 'database/database_helper.dart';
import 'views/auth/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await DatabaseHelper.instance.database;

  runApp(const TaskFlowApp());
}

class TaskFlowApp extends StatelessWidget {
  const TaskFlowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "TaskFlow",
      debugShowCheckedModeBanner: false,

      theme: ThemeData(primarySwatch: Colors.indigo, useMaterial3: true),

      home: const LoginPage(),
    );
  }
}
