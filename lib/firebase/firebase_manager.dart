// Collection -> Document -> date [set || read || delete || update task]
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:to_do_app/models/auth_user.dart';
import 'package:to_do_app/models/task.dart';

class FirebaseManager {
  /// To access the [Collection]
  static CollectionReference<AuthUser> getUsersCollection() {
    return FirebaseFirestore.instance
        .collection(AuthUser.collectionName)
        .withConverter<AuthUser>(
          fromFirestore: (snapshot, _) => AuthUser.fromJson(snapshot.data()),
          toFirestore: (userAuth, _) => userAuth.toJson(),
        );
  }

  static CollectionReference<Task> getTasksCollection(String uid) {
    return getUsersCollection()
        .doc(uid)
        .collection(Task.collectionName)
        .withConverter<Task>(
          fromFirestore: (snapshot, _) => Task.fromJson(snapshot.data()!),
          toFirestore: (task, _) => task.toJson(),
        );
  }

  /// Users Functionality
  /// When new [AuthUser] Sign Up, we need to save it to `firestore database`
  static Future<void> addAuthUserToFirestore(AuthUser authUser) {
    return getUsersCollection().doc(authUser.id).set(authUser);
  }

  /// When [AuthUser] SignIn, we need to read this user from `firestore database` to show his [Tasks]
  static Future<AuthUser?> readAuthUserFromFirestore(String uid) async {
    var docSnapshot = await getUsersCollection().doc(uid).get();
    return docSnapshot.data();
  }

  /// Tasks Functionality
  static Future<void> addTaskToFirestore(Task task, String uid) {
    CollectionReference<Task> tasksCollection = getTasksCollection(uid);
    DocumentReference<Task> taskDocument = tasksCollection.doc();

    /// to set the auto generate's [taskDocument.id] to task id, so `user` doesn't set it by himself
    task.id = taskDocument.id;

    return taskDocument.set(task);
  }

  static Future<void> deleteFromFirestore(Task task, String uid) {
    return getTasksCollection(uid).doc(task.id).delete();
  }

  static Future<void> updateTaskFromFirestore(Task task, String uid) {
    return getTasksCollection(uid)
        .doc(task.id)
        .update({'title': task.title, 'desc': task.desc});
  }

  static Future<void> doneTask(Task task, String uid) {
    return getTasksCollection(uid).doc(task.id).update({'isDone': task.isDone});
  }
}
