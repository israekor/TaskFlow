import 'package:sqflite/sqflite.dart';

import '../database/database_helper.dart';
import '../models/task.dart';

class TaskController {
  // Ajouter une tâche
  Future<int> addTask(Task task) async {
    final Database db = await DatabaseHelper.instance.database;

    return await db.insert('tasks', task.toMap());
  }

  // Afficher les tâches d'un utilisateur
  Future<List<Task>> getTasksByUser(int userId) async {
    final Database db = await DatabaseHelper.instance.database;

    final result = await db.query(
      'tasks',
      where: 'user_id = ?',
      whereArgs: [userId],
      orderBy: 'id DESC',
    );

    return result.map((task) => Task.fromMap(task)).toList();
  }

  // Modifier une tâche
  Future<int> updateTask(Task task) async {
    final Database db = await DatabaseHelper.instance.database;

    return await db.update(
      'tasks',
      task.toMap(),
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }

  // Supprimer une tâche
  Future<int> deleteTask(int id) async {
    final Database db = await DatabaseHelper.instance.database;

    return await db.delete('tasks', where: 'id = ?', whereArgs: [id]);
  }

  // Changer le statut
  Future<int> updateStatus(int id, int status) async {
    final Database db = await DatabaseHelper.instance.database;

    return await db.update(
      'tasks',
      {'status': status},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Nombre total des tâches d'un utilisateur
  Future<int> getTotalTasks(int userId) async {
    final db = await DatabaseHelper.instance.database;

    final result = await db.rawQuery(
      "SELECT COUNT(*) as total FROM tasks WHERE user_id = ?",
      [userId],
    );

    return result.first["total"] as int;
  }

  // Nombre des tâches terminées
  Future<int> getCompletedTasks(int userId) async {
    final db = await DatabaseHelper.instance.database;

    final result = await db.rawQuery(
      """
    SELECT COUNT(*) as total 
    FROM tasks 
    WHERE user_id = ? AND status = 1
    """,
      [userId],
    );

    return result.first["total"] as int;
  }

  // Nombre des tâches non terminées
  Future<int> getPendingTasks(int userId) async {
    final db = await DatabaseHelper.instance.database;

    final result = await db.rawQuery(
      """
    SELECT COUNT(*) as total 
    FROM tasks 
    WHERE user_id = ? AND status = 0
    """,
      [userId],
    );

    return result.first["total"] as int;
  }
}
