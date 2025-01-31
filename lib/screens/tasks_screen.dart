import 'package:flutter/material.dart';
import 'dart:async';
import 'package:uuid/uuid.dart';
import '../models/task.dart';
import '../services/local_storage.dart';
import '../screens/home_screen.dart';

class TasksScreen extends StatefulWidget {
  final String projectId;
  final String projectName;

  TasksScreen({
    required this.projectId,
    required this.projectName,
  });

  @override
  _TasksScreenState createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  final List<Task> _tasks = [];
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _estimatedTimeController = TextEditingController();
  String? _selectedPriority = 'Moyenne';

  Timer? _timer;
  Task? _activeTask;

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  void _loadTasks() async {
    final loadedTasks = await LocalStorage.loadTasks();
    setState(() {
      _tasks.addAll(
        loadedTasks.where((task) => task.projectId == widget.projectId),
      );
    });
  }

  void _addTask(String name, int estimatedTime, String priority) {
    if (name.isEmpty) return;

    final newTask = Task(
      id: Uuid().v4(),
      name: name,
      projectId: widget.projectId,
      completed: false,
      estimatedTime: estimatedTime,
      elapsedTime: 0,
      priority: priority,
    );

    setState(() {
      _tasks.add(newTask);
      _tasks.sort((a, b) => a.priority.compareTo(b.priority));
    });

    LocalStorage.saveTasks(_tasks);
    _nameController.clear();
    _estimatedTimeController.clear();
    _selectedPriority = 'Moyenne'; // Réinitialise la priorité
  }

  void _markTaskAsCompleted(Task task) {
    setState(() {
      task.completed = true;
      _tasks.sort((a, b) => a.completed ? 1 : -1);
    });

    LocalStorage.saveTasks(_tasks);
  }

  void _startTimer(Task task) {
    setState(() {
      _activeTask = task;
    });

    _timer = Timer.periodic(Duration(seconds: 1), (_) {
      setState(() {
        _activeTask?.elapsedTime++;
      });
    });
  }

  void _pauseTimer() {
    _timer?.cancel();
    setState(() {
      _activeTask = null;
    });
  }

  void _stopTimer(Task task) {
    _timer?.cancel();
    setState(() {
      _activeTask = null;
      task.elapsedTime = 0;
    });
  }

  String _formatTime(int seconds) {
    final hours = seconds ~/ 3600;
    final minutes = (seconds % 3600) ~/ 60;
    final secs = seconds % 60;
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Panneau latéral de navigation
          Container(
            color: Colors.grey[900],
            width: 250,
            child: Column(
              children: [
                Container(
                  color: Colors.black,
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: Center(
                    child: Text(
                      'Navigation',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView(
                    children: [
                      ListTile(
                        leading: Icon(Icons.category, color: Colors.white),
                        title: Text(
                          'Catégories',
                          style: TextStyle(color: Colors.white),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomeScreen(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Section principale des tâches
          Expanded(
            child: Scaffold(
              backgroundColor: Colors.black,
              appBar: AppBar(
                title: Text('Tâches - ${widget.projectName}'),
                backgroundColor: Colors.black,
              ),
              body: Column(
                children: [
                  Expanded(
                    child: _tasks.isEmpty
                        ? Center(
                            child: Text(
                              'Aucune tâche disponible.',
                              style: TextStyle(color: Colors.white70),
                            ),
                          )
                        : ListView.builder(
                            itemCount: _tasks.length,
                            itemBuilder: (context, index) {
                              final task = _tasks[index];
                              return Card(
                                color: task.completed
                                    ? Colors.green[900]
                                    : Colors.grey[900],
                                margin: EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 16),
                                child: ListTile(
                                  title: Text(
                                    task.name,
                                    style: TextStyle(
                                      color: task.completed
                                          ? Colors.green
                                          : Colors.white,
                                      decoration: task.completed
                                          ? TextDecoration.lineThrough
                                          : null,
                                    ),
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Priorité : ${task.priority}',
                                        style:
                                            TextStyle(color: Colors.white70),
                                      ),
                                      Text(
                                        'Temps estimé : ${_formatTime(task.estimatedTime)}',
                                        style:
                                            TextStyle(color: Colors.white70),
                                      ),
                                      Text(
                                        'Temps écoulé : ${_formatTime(task.elapsedTime)}',
                                        style:
                                            TextStyle(color: Colors.white70),
                                      ),
                                    ],
                                  ),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      if (!task.completed) ...[
                                        if (_activeTask == task)
                                          IconButton(
                                            icon: Icon(Icons.pause,
                                                color: Colors.teal),
                                            onPressed: _pauseTimer,
                                          )
                                        else
                                          IconButton(
                                            icon: Icon(Icons.play_arrow,
                                                color: Colors.teal),
                                            onPressed: () =>
                                                _startTimer(task),
                                          ),
                                        IconButton(
                                          icon: Icon(Icons.stop,
                                              color: Colors.redAccent),
                                          onPressed: () => _stopTimer(task),
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.check,
                                              color: Colors.green),
                                          onPressed: () =>
                                              _markTaskAsCompleted(task),
                                        ),
                                      ],
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: ElevatedButton(
                      onPressed: _showAddTaskDialog,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        padding: EdgeInsets.symmetric(
                            horizontal: 32, vertical: 16),
                      ),
                      child: Text(
                        'Ajouter une tâche',
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showAddTaskDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.grey[900],
          title: Text(
            'Ajouter une tâche',
            style: TextStyle(color: Colors.white),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _nameController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Nom de la tâche',
                  hintStyle: TextStyle(color: Colors.white70),
                  filled: true,
                  fillColor: Colors.grey[800],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 8),
              TextField(
                controller: _estimatedTimeController,
                keyboardType: TextInputType.number,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Temps estimé (secondes)',
                  hintStyle: TextStyle(color: Colors.white70),
                  filled: true,
                  fillColor: Colors.grey[800],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: _selectedPriority,
                items: ['Haute', 'Moyenne', 'Faible']
                    .map((priority) => DropdownMenuItem(
                          value: priority,
                          child: Text(priority),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedPriority = value;
                  });
                },
                dropdownColor: Colors.grey[800],
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[800],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Annuler',
                style: TextStyle(color: Colors.teal),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                final name = _nameController.text;
                final estimatedTime =
                    int.tryParse(_estimatedTimeController.text) ?? 0;
                final priority = _selectedPriority ?? 'Moyenne';
                _addTask(name, estimatedTime, priority);
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
              child: Text('Ajouter'),
            ),
          ],
        );
      },
    );
  }
}
