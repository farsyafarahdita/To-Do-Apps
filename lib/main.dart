import 'package:flutter/material.dart';
import 'add_task_page.dart';  

void main() { 
  runApp(MyApp());
}

class MyApp extends StatelessWidget { 
@override
  Widget build(BuildContext context) { 
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ToDoHomePage(),
      theme: ThemeData(
        scaffoldBackgroundColor: Color.fromARGB(255, 241, 234, 192),
      ),
    );
  }
}

class ToDoHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      body: Center( 
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'To-Do App',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color:Color.fromARGB(255, 0, 0, 0) ),
        ),
ElevatedButton(
  onPressed: () { 
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddTaskPage()),
    );
  },
  style: ElevatedButton.styleFrom(
    primary: Color.fromARGB(255, 47, 129, 166), 
  ),
  child: Text('+',
  style: TextStyle(
    color: Color.fromARGB(255, 0, 0, 0), 
  ),
),
),
          ],
        ),
      ),
    );
  }
}