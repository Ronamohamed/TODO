import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/firebase/firebase_manager.dart';
import 'package:to_do_app/models/task.dart';
import 'package:to_do_app/providers/app_config_provider.dart';
import 'package:to_do_app/providers/auth_user_provider.dart';
import 'package:to_do_app/providers/tasks_provider.dart';
import 'package:to_do_app/screens/edit_task/edit_task_screen.dart';
import 'package:to_do_app/screens/home_tabs/tasks/widgets/task_check.dart';
import 'package:to_do_app/utilities/my_theme.dart';

///localization_import
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TaskItemListTile extends StatefulWidget {
  final Task task;
  const TaskItemListTile({required this.task, super.key});

  @override
  State<TaskItemListTile> createState() => _TaskItemListTileState();
}

class _TaskItemListTileState extends State<TaskItemListTile> {
  @override
  Widget build(BuildContext context) {
    var appConfigProvider = Provider.of<AppConfiguresProvider>(context);
    var tasksProvider = Provider.of<TasksProvider>(context);
    var currentAuthUserId =
        Provider.of<AuthUserProvider>(context).currentAuthUser?.id ?? "12";

    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(
            12,
          ),
        ),
        color: (appConfigProvider.currentMode == ThemeMode.light)
            ? MyTheme.whiteColor
            : MyTheme.petrolColor,
      ),
      margin: const EdgeInsets.all(10),

      ///* Slidable Widget
      child: Slidable(
        key: const ValueKey(0),
        startActionPane: ActionPane(
          extentRatio: 100 / MediaQuery.sizeOf(context).width,
          motion: const BehindMotion(),
          // dismissible: DismissiblePane(onDismissed: () {
          ///! Throw Error
          // }),
          children: [
            SlidableAction(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(12),
                topLeft: Radius.circular(12),
              ),
              onPressed: (context) {
                FirebaseManager.deleteFromFirestore(
                        widget.task, currentAuthUserId)

                    /// When application is `offline`
                    .timeout(const Duration(milliseconds: 500), onTimeout: () {
                  tasksProvider.getAllTasks(currentAuthUserId);

                  /// When the application is `online`
                }).then((_) {
                  tasksProvider.getAllTasks(currentAuthUserId);
                });
              },
              backgroundColor: MyTheme.redColor,
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: AppLocalizations.of(context)!.delete,
            ),
          ],
        ),
        child: Card(
          color: (appConfigProvider.currentMode == ThemeMode.light)
              ? MyTheme.whiteColor
              : MyTheme.petrolColor,
          semanticContainer: false,
          elevation: 0,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              contentPadding: const EdgeInsets.all(10),
              leading: Container(
                margin: const EdgeInsets.only(left: 5),
                width: 4,
                color: (widget.task.isDone!)
                    ? MyTheme.greenColor
                    : MyTheme.primaryColor,
              ),
              title: InkWell(
                overlayColor:
                    // To remove the `clicking mark ==` after pop
                    const MaterialStatePropertyAll(Colors.transparent),
                onTap: () {
                  Navigator.of(context).pushNamed(EditTaskScreen.routeName,
                      arguments: widget.task);
                },
                child: Text(
                  widget.task.title ?? "",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: (widget.task.isDone!)
                          ? MyTheme.greenColor
                          : MyTheme.primaryColor),
                ),
              ),
              subtitle: Container(
                  margin: const EdgeInsets.only(top: 5),
                  child: Text(
                    widget.task.desc ?? "",
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall
                        ?.copyWith(fontSize: 12),
                  )),
              trailing: InkWell(
                overlayColor:
                    const MaterialStatePropertyAll(Colors.transparent),
                onTap: () {
                  setState(() {
                    widget.task.isDone = !widget.task.isDone!;
                    FirebaseManager.doneTask(widget.task, currentAuthUserId)
                        .timeout(Durations.medium4, onTimeout: () {});
                  });
                },
                child: (widget.task.isDone!)
                    ? Text(
                        AppLocalizations.of(context)!.done,
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(color: MyTheme.greenColor),
                      )
                    : const TaskCheck(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
