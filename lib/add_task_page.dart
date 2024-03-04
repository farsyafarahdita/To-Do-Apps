import 'package:flutter/material.dart';
import 'task_list_widget.dart';

class AddTaskPage extends StatefulWidget {
  @override 
  _AddTaskPageState createState() => _AddTaskPageState(); 
}
class _AddTaskPageState extends State<AddTaskPage> {
  TextEditingController _taskController = TextEditingController();
  List<Task> toDoList = []; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To Do'),
        backgroundColor: Color.fromARGB(255, 47, 129, 166),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TaskListWidget(toDoList: toDoList),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
         _showAddTaskBottomSheet(context);
        },
        child: Icon(Icons.add),
        backgroundColor: Color.fromARGB(255, 47, 129, 166),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat, 
    );
  }
  
void _showAddTaskBottomSheet(BuildContext context) {
  showModalBottomSheet(
    isScrollControlled: true, 
    context: context,
    builder: (BuildContext context) {
      return SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only( 
            bottom: MediaQuery.of(context).viewInsets.bottom, 
          ),
          child: Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Tambah Aktivitas Baru',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                TextField(
                  controller: _taskController,
                  decoration: InputDecoration(
                    hintText: 'Masukkan aktivitas',
                  ),
                ),
                SizedBox(height: 16.0),
                Row( 
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        String newTask = _taskController.text; 
                         if (newTask.isNotEmpty) { 
                          toDoList.add(Task(name: newTask)); 
                          setState(() {}); 
                          _taskController.clear(); 
                        }
                        Navigator.pop(context); 
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Color.fromARGB(255, 187, 180, 136),
                      ),
                      child: Text('Tambah', style: TextStyle( color: Color.fromARGB(255, 0, 0, 0), ),
                ),
                ),
                    ElevatedButton(
                      onPressed: () {
                        _taskController.clear();
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Color.fromARGB(255, 187, 180, 136),
                      ),
                      child: Text('Batal', style: TextStyle( color: Color.fromARGB(255, 0, 0, 0),),
                    ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
}