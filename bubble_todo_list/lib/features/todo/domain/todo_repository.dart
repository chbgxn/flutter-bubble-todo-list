import 'package:bubble_todo_list/features/todo/models/todo.dart';
import 'package:bubble_todo_list/features/todo/data/remote_todo_storage.dart';
import 'package:bubble_todo_list/features/todo/data/local_todo_storage.dart';

class TodoRepository {
  final LocalTodoStorage local;
  final RemoteTodoStorage remote;
  final String uid;

  TodoRepository({required this.local, required this.remote, required this.uid});
  
  Future<List<Todo>> loadTodos() async{
    //offline preferred [ZH]离线优先
    final localTodos = local.getUserTodosFromLocal(uid: uid);
    if(localTodos.isNotEmpty) return localTodos;
    try{
      //若本地没数据, 从远程加载数据
      final remoteTodos = await remote.fetchTodosFromRemote(uid: uid);
      for(var remoteTodo in remoteTodos){
        local.saveTodoIntoLocal(todo: remoteTodo);
      }
      return remoteTodos;
    } catch(e){
      return [];
    }
  }
    

  Future<void> saveTodoIntoLocal({required Todo todo}) async {
    await local.saveTodoIntoLocal(todo: todo);
  }
}

