import 'package:flutter/material.dart';
import 'package:todo/todo_item.dart';

class Todo extends StatefulWidget {
  const Todo({super.key});

  @override
  State<Todo> createState() {
    return _TodoState();
  }
}

class _TodoState extends State<Todo> {
  final _newtaskController = TextEditingController();
  List toDoList = [];

  void _addTask() {
    setState(() {
      final addtask = _newtaskController.text;
      if (addtask == '') {
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('Invalid Input'),
            content: const Text(
              'Please enter task name!',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(ctx);
                },
                child: const Text('Okay'),
              ),
            ],
          ),
        );
        return;
      }
      toDoList.add([addtask, false]);
      _newtaskController.clear();
    });
  }

  void _removeTask(int index) {
    final removed = toDoList[index];
    setState(() {
      toDoList.removeAt(index);
    });



    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Task removed'),
        action: SnackBarAction(
          label: 'UNDO',
          onPressed: () {
            setState(() {
              toDoList.insert(index, removed);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ToDo',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        backgroundColor: Colors.amber,
        foregroundColor: Colors.white,
      ),
      body: toDoList.isEmpty
          ? const Center(
              child: Text('Add some tasks!',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400)))
          : ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(
                height: 5,
              ),
              itemCount: toDoList.length,
              itemBuilder: (context, index) => Dismissible(
                key: ValueKey(toDoList[index]),
                onDismissed: (direction) {
                  _removeTask(index);
                },
                child: TaskItem(
                    title: toDoList[index][0],
                    taskCompleted: toDoList[index][1]),
              ),
            ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.text,
                  controller: _newtaskController,
                  decoration: const InputDecoration(
                    hintText: 'Add new task',
                  ),
                ),
              ),
            ),
            Container(
                width: 50,
                height: 50,
                decoration: const ShapeDecoration(
                    shape: CircleBorder(), color: Colors.amber),
                child: IconButton(
                    onPressed: _addTask, icon: const Icon(Icons.add)))
          ],
        ),
      ),
    );
  }
}
