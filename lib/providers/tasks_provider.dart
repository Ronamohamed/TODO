import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app/firebase/firebase_manager.dart';
import 'package:to_do_app/models/task.dart';

class TasksProvider extends ChangeNotifier {
  List<Task> tasks = [];
  DateTime selectedDate = DateTime.now();

  /// Fetching All Tasks from Firestore.
  /// Every time make CRUD using it to reload date
  void getAllTasks(String uid) async {
    /// Get all [tasks]
    QuerySnapshot<Task> querySnapshot =
        await FirebaseManager.getTasksCollection(uid).get();
    tasks = querySnapshot.docs.map((document) => document.data()).toList();

    /// Filtering [tasks] by every `task date`
    tasks = tasks.where((task) {
      if (selectedDate.day == task.date?.day &&
          selectedDate.month == task.date?.month &&
          selectedDate.year == task.date?.year) {
        return true;
      }
      return false;
    }).toList();

    /// Sorting [tasks] by date created
    tasks.sort((task1, task2) {
      return task1.date!.compareTo(task2.date!);
    });
    notifyListeners();
  }

  /// Making the `CurrentDate` on the calender to the day chosen by the `User`
  void changeDateOnCalender(DateTime newDate, String uid) {
    selectedDate = newDate;
    getAllTasks(uid);
  }
}
