import 'dart:async';
import 'package:bubble_todo_list/features/todo/data/local_todo_storage.dart';
import 'package:bubble_todo_list/features/todo/data/remote_todo_storage.dart';
import 'package:bubble_todo_list/features/todo/models/todo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:retry/retry.dart';

class SyncManager {
  final LocalTodoStorage local;
  final RemoteTodoStorage remote;
  String uid;
  final Connectivity connectivity;

  SyncManager({
    required this.local,
    required this.remote,
    required this.uid,
    required this.connectivity
  });

  late final StreamSubscription _subscription;

  void start(){
    _subscription = connectivity.onConnectivityChanged.listen((result){
      if(!result.contains(ConnectivityResult.none)){
        _syncTodos();
      }
    });
    _syncTodos();
  }

  Future<void> _syncTodos() async {
    final unsyncTodos = local.getUserUnsyncTodosFromLocal(uid: uid);
    for(Todo unsyncTodo in unsyncTodos){
      await _trySyncTodos(unsyncTodo: unsyncTodo);
    }
  }

  Future<void> _trySyncTodos({required Todo unsyncTodo}) async{
    try{
      final syncedTodo = unsyncTodo.copyWith(isSynced: true, syncError: null);
      await retry(
        () => remote.uploadTodoToRemote(todo: syncedTodo),
        retryIf: (e) => e is FirebaseException,
        maxAttempts: 3,
      );
      await local.saveTodoIntoLocal(todo: syncedTodo);
    }catch(e){
      final failedTodo = unsyncTodo.copyWith(syncError: e.toString());
      await local.saveTodoIntoLocal(todo: failedTodo);
    }
  }

  void dispose(){
    _subscription.cancel();
  }
}