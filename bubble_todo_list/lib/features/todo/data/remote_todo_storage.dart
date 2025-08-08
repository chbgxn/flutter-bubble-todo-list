import 'package:bubble_todo_list/features/todo/models/todo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RemoteTodoStorage {
  final FirebaseFirestore firestore;

  RemoteTodoStorage({required this.firestore});

  Future<List<Todo>> fetchTodosFromRemote({required String uid}) async {
    final snapshot = await firestore
      .collection('todos')
      .where('uid', isEqualTo: uid)
      .get();
    return snapshot.docs.map((doc) => Todo.fromJson(doc.data())).toList();
  }

  Future<void> uploadTodoToRemote({required Todo todo}) async {
    await firestore.collection('todos').doc(todo.tid).set(todo.toJson());
  } 
}