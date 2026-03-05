import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/category.dart';
import '../models/project.dart';
import '../models/task.dart';

class LocalStorage {
  static const _categoriesKey = 'categories';
  static const _projectsKey = 'projects';
  static const _tasksKey = 'tasks';

  // --- CATÉGORIES ---

  static Future<void> saveCategories(List<Category> categories) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final categoriesJson = categories.map((c) => c.toMap()).toList();
      await prefs.setString(_categoriesKey, jsonEncode(categoriesJson));
    } catch (e) {
      print("Erreur lors de la sauvegarde des catégories: $e");
    }
  }

  static Future<List<Category>> loadCategories() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final categoriesString = prefs.getString(_categoriesKey);
      if (categoriesString == null) return [];
      final categoriesJson = jsonDecode(categoriesString) as List;
      return categoriesJson.map((json) => Category.fromMap(json)).toList();
    } catch (e) {
      print("Erreur lors du chargement des catégories: $e");
      return [];
    }
  }

  /// Supprime une catégorie et pourrait être étendu pour supprimer 
  /// les projets associés afin d'éviter les données orphelines.
  static Future<void> deleteCategory(String categoryId) async {
    List<Category> categories = await loadCategories();
    categories.removeWhere((c) => c.id == categoryId);
    await saveCategories(categories);
  }

  // --- PROJETS ---

  static Future<void> saveProjects(List<Project> projects) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final projectsJson = projects.map((p) => p.toMap()).toList();
      await prefs.setString(_projectsKey, jsonEncode(projectsJson));
    } catch (e) {
      print("Erreur lors de la sauvegarde des projets: $e");
    }
  }

  static Future<List<Project>> loadProjects() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final projectsString = prefs.getString(_projectsKey);
      if (projectsString == null) return [];
      final projectsJson = jsonDecode(projectsString) as List;
      return projectsJson.map((json) => Project.fromMap(json)).toList();
    } catch (e) {
      print("Erreur lors du chargement des projets: $e");
      return [];
    }
  }

  static Future<void> deleteProject(String projectId) async {
    List<Project> projects = await loadProjects();
    projects.removeWhere((p) => p.id == projectId);
    await saveProjects(projects);
  }

  // --- TÂCHES ---

  static Future<void> saveTasks(List<Task> tasks) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final tasksJson = tasks.map((t) => t.toMap()).toList();
      await prefs.setString(_tasksKey, jsonEncode(tasksJson));
    } catch (e) {
      print("Erreur lors de la sauvegarde des tâches: $e");
    }
  }

  static Future<List<Task>> loadTasks() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final tasksString = prefs.getString(_tasksKey);
      if (tasksString == null) return [];
      final tasksJson = jsonDecode(tasksString) as List;
      return tasksJson.map((json) => Task.fromMap(json)).toList();
    } catch (e) {
      print("Erreur lors du chargement des tâches: $e");
      return [];
    }
  }

  static Future<void> deleteTask(String taskId) async {
    List<Task> tasks = await loadTasks();
    tasks.removeWhere((t) => t.id == taskId);
    await saveTasks(tasks);
  }
}