import 'package:bubble_todo_list/features/todo/models/todo.dart';
import 'package:hive/hive.dart';

class LocalTodoStorage {
  final Box<Todo> box;
  LocalTodoStorage({required this.box});

  List<Todo> getUserTodosFromLocal({required String uid}){
    return box.values.where((todo) => todo.uid == uid).toList();
  }

  List<Todo> getUserUnsyncTodosFromLocal({required String uid}){
    return box.values.where((todo) => !todo.isSynced).toList();
  }

  Future<void> saveTodoIntoLocal({required Todo todo}) async { //增加+更新
    await box.put(todo.tid, todo);
  }
}