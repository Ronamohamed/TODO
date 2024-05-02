import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/providers/auth_user_provider.dart';
import 'package:to_do_app/providers/tasks_provider.dart';
import 'package:to_do_app/screens/home_tabs/tasks/widgets/calender.dart';
import 'package:to_do_app/screens/home_tabs/tasks/widgets/taskitem_listtile.dart';

class TasksTab extends StatefulWidget {
  const TasksTab({super.key});

  @override
  State<TasksTab> createState() => _TasksTabState();
}

class _TasksTabState extends State<TasksTab> {
  ///* [ MARK ] variables
  late TasksProvider _tasksProvider;

  ///* [ MARK ] STF Life Cycle
  @override
  Widget build(BuildContext context) {
    _tasksProvider = Provider.of<TasksProvider>(context);
    var currentAuthUserId =
        Provider.of<AuthUserProvider>(context).currentAuthUser?.id ?? "122";

    if (_tasksProvider.tasks.isEmpty) {
      _tasksProvider.getAllTasks(currentAuthUserId);
    }
    return Column(
      children: [
        Calender(
          focusDate: _tasksProvider.selectedDate,
          firstDate: DateTime.now().subtract(const Duration(days: 30)),
          lastDate: DateTime.now().add(const Duration(days: 365)),
          onDateChange: (selectedDate) {
            _tasksProvider.changeDateOnCalender(
                selectedDate, currentAuthUserId);
          },
        ),
        Expanded(
          child: Container(
              height: MediaQuery.of(context).size.height * 0.612,
              margin: const EdgeInsets.symmetric(horizontal: 12),
              child: ListView.builder(
                itemCount: _tasksProvider.tasks.length,
                itemBuilder: (context, i) => TaskItemListTile(
                  task: _tasksProvider.tasks[i],
                ),
              )),
        ),
      ],
    );
  }
}
