import 'package:flutter/material.dart';
import '../models/task.dart';
import '../services/local_storage.dart';

class DashboardScreen extends StatefulWidget {
  final String projectId;
  final String projectName;

  DashboardScreen({
    required this.projectId,
    required this.projectName,
  });

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<Task> _tasks = [];
  int _completedTasks = 0;
  int _totalTasks = 0;
  int _totalTimeSpent = 0; // En secondes

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    final allTasks = await LocalStorage.loadTasks();
    final projectTasks =
        allTasks.where((task) => task.projectId == widget.projectId).toList();

    setState(() {
      _tasks = projectTasks;
      _calculateStatistics();
    });
  }

  void _calculateStatistics() {
    _completedTasks = _tasks.where((task) => task.completed).length;
    _totalTasks = _tasks.length;
    _totalTimeSpent = _tasks.fold(0, (sum, task) => sum + task.elapsedTime);
  }

  String _formatDuration(int seconds) {
    final hours = seconds ~/ 3600;
    final minutes = (seconds % 3600) ~/ 60;
    return '${hours}h ${minutes}m';
  }

  double _calculateCompletionRate() {
    return _totalTasks == 0 ? 0 : (_completedTasks / _totalTasks) * 100;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard - ${widget.projectName}'),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Statistiques globales
            Text(
              'Statistiques générales',
              style: TextStyle(color: Colors.teal, fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            _buildStatisticTile(
              title: 'Tâches terminées',
              value: '$_completedTasks / $_totalTasks',
              progress: _totalTasks == 0 ? 0 : _completedTasks / _totalTasks,
              color: Colors.green,
            ),
            _buildStatisticTile(
              title: 'Temps total passé',
              value: _formatDuration(_totalTimeSpent),
              progress: 1.0, // Pas de barre pour le temps total
              color: Colors.blue,
            ),
            SizedBox(height: 20),
            // Liste des tâches
            Text(
              'Détails des tâches',
              style: TextStyle(color: Colors.teal, fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Expanded(
              child: _tasks.isEmpty
                  ? Center(
                      child: Text(
                        'Aucune tâche pour ce projet.',
                        style: TextStyle(color: Colors.white70),
                      ),
                    )
                  : ListView.builder(
                      itemCount: _tasks.length,
                      itemBuilder: (context, index) {
                        final task = _tasks[index];
                        return Card(
                          color: Colors.grey[900],
                          margin: EdgeInsets.symmetric(vertical: 8),
                          child: ListTile(
                            title: Text(
                              task.name,
                              style: TextStyle(color: Colors.white),
                            ),
                            subtitle: Text(
                              'Priorité : ${task.priority} | Temps écoulé : ${_formatDuration(task.elapsedTime)}',
                              style: TextStyle(color: Colors.white70),
                            ),
                            trailing: Icon(
                              task.completed ? Icons.check_circle : Icons.radio_button_unchecked,
                              color: task.completed ? Colors.green : Colors.orange,
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatisticTile({
    required String title,
    required String value,
    required double progress,
    required Color color,
  }) {
    return Card(
      color: Colors.grey[900],
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            SizedBox(height: 8),
            if (progress < 1.0)
              LinearProgressIndicator(
                value: progress,
                backgroundColor: Colors.grey,
                color: color,
                minHeight: 8,
              ),
            SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(color: Colors.teal, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
