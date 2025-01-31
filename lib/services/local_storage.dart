import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/category.dart';
import '../models/project.dart';
import '../models/task.dart';

class LocalStorage {
  static const _categoriesKey = 'categories';
  static const _projectsKey = 'projects';
  static const _tasksKey = 'tasks';

  // Sauvegarder les catégories
  static Future<void> saveCategories(List<Category> categories) async {
    final prefs = await SharedPreferences.getInstance();
    final categoriesJson = categories.map((c) => c.toMap()).toList();
    prefs.setString(_categoriesKey, jsonEncode(categoriesJson));
  }

  // Charger les catégories
  static Future<List<Category>> loadCategories() async {
    final prefs = await SharedPreferences.getInstance();
    final categoriesString = prefs.getString(_categoriesKey);
    if (categoriesString == null) return [];
    final categoriesJson = jsonDecode(categoriesString) as List;
    return categoriesJson.map((json) => Category.fromMap(json)).toList();
  }

  // Sauvegarder les projets
  static Future<void> saveProjects(List<Project> projects) async {
    final prefs = await SharedPreferences.getInstance();
    final projectsJson = projects.map((p) => p.toMap()).toList();
    prefs.setString(_projectsKey, jsonEncode(projectsJson));
  }

  // Charger les projets
  static Future<List<Project>> loadProjects() async {
    final prefs = await SharedPreferences.getInstance();
    final projectsString = prefs.getString(_projectsKey);
    if (projectsString == null) return [];
    final projectsJson = jsonDecode(projectsString) as List;
    return projectsJson.map((json) => Project.fromMap(json)).toList();
  }

  // Sauvegarder les tâches
  static Future<void> saveTasks(List<Task> tasks) async {
    final prefs = await SharedPreferences.getInstance();
    final tasksJson = tasks.map((t) => t.toMap()).toList();
    prefs.setString(_tasksKey, jsonEncode(tasksJson));
  }

  // Charger les tâches
  static Future<List<Task>> loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final tasksString = prefs.getString(_tasksKey);
    if (tasksString == null) return [];
    final tasksJson = jsonDecode(tasksString) as List;
    return tasksJson.map((json) => Task.fromMap(json)).toList();
  }
}
