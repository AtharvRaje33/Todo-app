import 'package:flutter/material.dart';

class TaskItem extends StatefulWidget {
  const TaskItem({super.key, required this.title, required this.taskCompleted});

  final String title;
  final bool taskCompleted;

  @override
  TaskItemState createState() => TaskItemState();
}

class TaskItemState extends State<TaskItem> {
  late bool _taskCompleted;

  @override
  void initState() {
    super.initState();
    _taskCompleted = widget.taskCompleted;
  }

  void _toggleTaskCompleted(bool? newValue) {
    setState(() {
      _taskCompleted = newValue ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(color: Colors.yellow,
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Checkbox(
                value: _taskCompleted,
                onChanged: _toggleTaskCompleted,
              ),
              Expanded(
                child: Text(
                  widget.title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: const Color.fromARGB(255, 0, 0, 0),
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    decoration: _taskCompleted ? TextDecoration.lineThrough : TextDecoration.none,
                  ),
                ),
              ),
              const SizedBox(width: 48), 
            ],
          ),
        ),
      ),
    );
  }
}
