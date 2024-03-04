import 'package:flutter/material.dart';

class TaskListWidget extends StatefulWidget { 
  final List<Task> toDoList; 

  TaskListWidget({
required this.toDoList});

  @override
  _TaskListWidgetState createState() => _TaskListWidgetState();
}

class Task { 
  String name;  
  bool isCompleted; 

  Task({required this.name, this.isCompleted = false});
}

class _TaskListWidgetState extends State<TaskListWidget> { 
  TextEditingController _editingController = TextEditingController();
  late String _editedTask; 
  late int _editedTaskIndex; 


  @override
  Widget build(BuildContext context) { 
    return widget.toDoList.isEmpty 
        ? Center(child: Text('Belum ada Aktivitas baru'))
        : Expanded(
            child: ListView.builder( 
              itemCount: widget.toDoList.length,
              itemBuilder: (context, index) {
                return _buildTaskTile(index, context);
              },
            ),
          );
  }
  
Widget _buildTaskTile(int index, BuildContext context) { 
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    child: Card(
      elevation: 3,
      color: widget.toDoList[index].isCompleted 
         ? Colors.grey
          : Color.fromARGB(255, 47, 129, 166),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ListTile(
            title: Text(
              widget.toDoList[index].name,
              style: TextStyle(
                color: widget.toDoList[index].isCompleted 
                    ? Colors.white70
                    : Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [ 
              _buildActionButton( 
                onPressed: () { 
                  _showEditTaskBottomSheet(context, widget.toDoList[index].name, index); 
                },
                label: 'Edit', textColor:Color.fromRGBO(236, 224, 155, 1)),
              _buildActionButton(
                onPressed: () {
                  _showFinishTaskDialog(context, index);
                },
                label: 'Selesai', textColor: Color.fromRGBO(236, 224, 155, 1)),
              _buildActionButton(
                onPressed: () {
                  _showDeleteTaskDialog(context, index);
                },
                label: 'Hapus', textColor: Color.fromRGBO(236, 224, 155, 1)),
            ],
          ),
        ],
      ),
    ),
  );
}
Widget _buildActionButton({required Function onPressed, required String label, Color? textColor}) {
  return TextButton( 
    onPressed: () { 
      onPressed(); 
    },
    child: Text(label, style: TextStyle(color: textColor)),
  );
}

  Widget _buildEditingTile(BuildContext context) {
    return Container( 
      margin: EdgeInsets.only(bottom: 8.0),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.black)),
      ),
      child: ListTile(
        title: TextField( 
          controller: _editingController,
          style: TextStyle(fontSize: 18.0),
          onChanged: (value) {
            setState(() {
              _editedTask = value;
            });
          },
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,

        ),
      ),
    );
  }

  void _showEditTaskBottomSheet(BuildContext context, String currentTask, int index) { 
  _editedTask = currentTask;
  _editedTaskIndex = index;
  _editingController.text = _editedTask;

  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Container(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Edit Aktivitas', style: TextStyle(fontSize: 18)),
            SizedBox(height: 16),
            TextField(
              controller: _editingController,
              style: TextStyle(fontSize: 18.0),
              onChanged: (value) {
                setState(() {
                  _editedTask = value;
                });
              },
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      widget.toDoList[_editedTaskIndex].name = _editedTask;
                    });
                    Navigator.pop(context); 
                  },
                  child: Text('Simpan'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                     
                    });
                    Navigator.pop(context);
                  },
                  child: Text('Batal'),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}

  void _showFinishTaskDialog(BuildContext context, int index) {
    showDialog( 
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Selesaikan Aktivitas'),
          content: Text('Apakah Anda yakin ingin menyelesaikan aktivitas ini?'),
          actions: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  widget.toDoList[index].isCompleted = true; 
                  
                });
                Navigator.pop(context);
              },
              child: Text('Ya'),
            ),
            ElevatedButton(
            onPressed: () {
              setState(() {
                widget.toDoList[index].isCompleted = false; 
            
              });
              Navigator.pop(context);
            },
            child: Text('Tidak'),
            ),
          ],
        );
      },
    );
  }

  void _showDeleteTaskDialog(BuildContext context, int index) {
    showDialog( 
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Hapus Aktivitas'),
          content: Text('Apakah Anda yakin ingin menghapus aktivitas ini?'),
          actions: [
            ElevatedButton(
              onPressed: () {
                _deleteTask(index);
                Navigator.pop(context);
              },
              child: Text('Ya'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Tidak'),
            ),
          ],
        );
      },
    );
  }

  void _deleteTask(int index) {
    String deletedTaskName = widget.toDoList[index].name;
    widget.toDoList.removeAt(index);
    setState(() {
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('To-Do "$deletedTaskName" telah dihapus.'),
        action: SnackBarAction(
          label: 'Batalkan',
          onPressed: () { 
            setState(() {
              widget.toDoList.insert(index, Task(name: deletedTaskName));
            });
          },
        ),
      ),
    );
  }
}