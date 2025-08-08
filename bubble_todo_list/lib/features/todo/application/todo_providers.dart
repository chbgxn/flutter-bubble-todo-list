import 'package:bubble_todo_list/features/auth/application/auth_providers.dart';
import 'package:bubble_todo_list/features/todo/domain/sync_manager.dart';
import 'package:bubble_todo_list/features/todo/models/todo.dart';
import 'package:bubble_todo_list/features/todo/application/todo_list_state_async_notifier.dart';
import 'package:bubble_todo_list/features/todo/models/todo_list_state.dart';
import 'package:bubble_todo_list/features/todo/domain/todo_repository.dart';
import 'package:bubble_todo_list/features/todo/data/local_todo_storage.dart';
import 'package:bubble_todo_list/features/todo/data/remote_todo_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

//Data Source, [ZH]数据源 
final hiveBoxProvider = Provider<Box<Todo>>((ref) => Hive.box<Todo>('todos'));
final firestoreProvider = Provider<FirebaseFirestore>((ref) => FirebaseFirestore.instance);

final localTodoStorageProvider = Provider<LocalTodoStorage>((ref){
  final box = ref.watch(hiveBoxProvider);
  return LocalTodoStorage(box: box);
});

final remoteTodoStorageProvider = Provider<RemoteTodoStorage>((ref){
  final firestore = ref.watch(firestoreProvider);
  return RemoteTodoStorage(firestore: firestore);
});

// 业务逻辑
final todoRepositoryProvider = Provider.family<TodoRepository, String>((ref, uid){
  final local = ref.watch(localTodoStorageProvider);
  final remote = ref.watch(remoteTodoStorageProvider);
  return TodoRepository(local: local, remote: remote, uid: uid);
});

final syncManagerProvider = Provider<SyncManager>((ref){
  final local = ref.watch(localTodoStorageProvider);
  final remote = ref.watch(remoteTodoStorageProvider);
  final uid = ref.watch(authStateNotifierProvider).currentUser!.uid;
  final connectivity = Connectivity();

  final manager = SyncManager(local: local, remote: remote, uid: uid, connectivity: connectivity);

  manager.start();
  ref.onDispose(manager.dispose);
  return manager;
});

final todoListStateAsyncNotifierProvider =  AsyncNotifierProviderFamily<
  TodoListStateAsyncNotifier, TodoListState, String>((){
  return TodoListStateAsyncNotifier();
});

final textFieldExpandProvider = StateProvider<bool>((ref) => false);