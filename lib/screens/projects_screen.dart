import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uuid/uuid.dart';
import '../models/project.dart';
import '../services/local_storage.dart';
import 'tasks_screen.dart';
import 'dashboard_screen.dart';

class ProjectsScreen extends StatefulWidget {
  final String categoryId;
  final String categoryName;

  ProjectsScreen({
    required this.categoryId,
    required this.categoryName,
  });

  @override
  _ProjectsScreenState createState() => _ProjectsScreenState();
}

class _ProjectsScreenState extends State<ProjectsScreen> {
  final List<Project> _projects = [];
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _technologiesController = TextEditingController();
  final TextEditingController _githubLinksController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadProjects();
  }

  void _loadProjects() async {
    final loadedProjects = await LocalStorage.loadProjects();
    setState(() {
      _projects.addAll(
        loadedProjects.where((project) => project.categoryId == widget.categoryId),
      );
    });
  }

  void _addProject() {
    final name = _nameController.text.trim();
    final technologies = _technologiesController.text.trim().split(',');
    final githubLinks = _githubLinksController.text.trim().split(',');

    if (name.isEmpty) return;

    final newProject = Project(
      id: Uuid().v4(),
      name: name,
      categoryId: widget.categoryId,
      technologies: technologies.where((tech) => tech.isNotEmpty).toList(),
      devLinks: githubLinks.where((link) => link.isNotEmpty).toList(),
      status: "En cours",
    );

    setState(() {
      _projects.add(newProject);
    });

    LocalStorage.saveProjects(_projects);
    _nameController.clear();
    _technologiesController.clear();
    _githubLinksController.clear();
  }

  void _deleteProject(Project project) {
    setState(() {
      _projects.remove(project);
    });

    LocalStorage.saveProjects(_projects);
  }

  Future<void> _openGitHubLink(String url) async {
  final Uri uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Impossible d\'ouvrir le lien : $url'),
      ),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Projets - ${widget.categoryName}'),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Expanded(
            child: _projects.isEmpty
                ? Center(
                    child: Text(
                      'Aucun projet disponible.',
                      style: TextStyle(color: Colors.white70),
                    ),
                  )
                : ListView.builder(
                    itemCount: _projects.length,
                    itemBuilder: (context, index) {
                      final project = _projects[index];
                      return Card(
                        color: Colors.grey[900],
                        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        child: Column(
                          children: [
                            ListTile(
                              title: Text(
                                project.name,
                                style: TextStyle(color: Colors.white),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (project.technologies.isNotEmpty)
                                    Text(
                                      'Technologies : ${project.technologies.join(', ')}',
                                      style: TextStyle(color: Colors.white70),
                                    ),
                                 if (project.devLinks.isNotEmpty) ...[
                                  Text(
                                    'Liens GitHub :',
                                    style: TextStyle(color: Colors.teal),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: project.devLinks.map((link) {
                                      return GestureDetector(
                                        onTap: () => _openGitHubLink(link),
                                        child: Text(
                                          link,
                                          style: TextStyle(
                                            color: Colors.blue,
                                            decoration: TextDecoration.underline,
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ],
                                ],
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.dashboard, color: Colors.blue),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => DashboardScreen(
                                            projectId: project.id,
                                            projectName: project.name,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.delete, color: Colors.red),
                                    onPressed: () {
                                       _showDeleteConfirmationDialog(project);
                                    },
                                  ),
                                ],
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => TasksScreen(
                                      projectId: project.id,
                                      projectName: project.name,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () {
                _showAddProjectDialog();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              ),
              child: Text(
                'Ajouter un projet',
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showAddProjectDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.grey[900],
          title: Text(
            'Ajouter un projet',
            style: TextStyle(color: Colors.white),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _nameController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Nom du projet',
                  hintStyle: TextStyle(color: Colors.white70),
                  filled: true,
                  fillColor: Colors.grey[800],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _technologiesController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Technologies (séparées par des virgules)',
                  hintStyle: TextStyle(color: Colors.white70),
                  filled: true,
                  fillColor: Colors.grey[800],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _githubLinksController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Liens GitHub (séparés par des virgules)',
                  hintStyle: TextStyle(color: Colors.white70),
                  filled: true,
                  fillColor: Colors.grey[800],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'Annuler',
                style: TextStyle(color: Colors.teal),
              ),
            ),
            TextButton(
              onPressed: () {
                _addProject();
                Navigator.pop(context);
              },
              child: Text(
                'Ajouter',
                style: TextStyle(color: Colors.teal),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showDeleteConfirmationDialog(Project project) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.grey[900],
          title: Text(
            'Supprimer le projet',
            style: TextStyle(color: Colors.white),
          ),
          content: Text(
            'Êtes-vous sûr de vouloir supprimer ce projet ?',
            style: TextStyle(color: Colors.white70),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'Annuler',
                style: TextStyle(color: Colors.teal),
              ),
            ),
            TextButton(
              onPressed: () {
                _deleteProject(project);
                Navigator.pop(context);
              },
              child: Text(
                'Supprimer',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }
}
