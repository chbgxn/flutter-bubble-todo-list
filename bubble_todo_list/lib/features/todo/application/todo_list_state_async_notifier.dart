import 'dart:async';
import 'package:bubble_todo_list/core/utils/handle_conversion_tz_and_date_time.dart';
import 'package:bubble_todo_list/features/auth/application/auth_providers.dart';
import 'package:bubble_todo_list/features/todo/models/todo.dart';
import 'package:bubble_todo_list/features/todo/models/todo_list_state.dart';
import 'package:bubble_todo_list/features/todo/application/todo_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum UpdateAction {completeStatus, dueDate, title, description, priority, deleteStatus}

class TodoListStateAsyncNotifier extends FamilyAsyncNotifier<TodoListState, String> {
  @override
  Future<TodoListState> build(String uid) async {
    final uid = ref.watch(authStateNotifierProvider).currentUser!.uid;
    final todoRepository =  ref.watch(todoRepositoryProvider(uid));
    try{
      final initialTodos = await todoRepository.loadTodos(); //数据从仓库来
      return TodoListState(
        todoList: initialTodos, 
        isSuccessful: false,
        isLoading: false, 
        hasError: false, 
        errorMsg: null
      );
    }catch(e){
      return TodoListState(
        todoList: [], 
        isLoading: false, 
        hasError: true, 
        errorMsg: e.toString()
      );
    }
  }


  void setSortMode(SortMode mode){
    state = AsyncValue.data(state.valueOrNull!.copyWith(sort: mode));
  }

  Future<void> addTodo({required String title}) async {
    final uid = ref.watch(authStateNotifierProvider).currentUser!.uid;
    final todoRepository = ref.watch(todoRepositoryProvider(uid));

    state = AsyncValue.data(state.valueOrNull!.copyWith(isLoading: true));
    try{
      final newTodo = Todo(
        uid: uid, 
        tid: '${uid}_${HandleConversionTzAndDateTime.dateTimeToTzUtc(DateTime.now()).toString()}', 
        title: title, 
        createdAt: HandleConversionTzAndDateTime.dateTimeToTzUtc(DateTime.now()),
      );

      await todoRepository.saveTodoIntoLocal(todo: newTodo);
      final newTodoList = todoRepository.local.getUserTodosFromLocal(uid: uid); //todo.uid == uid

      state = AsyncValue.data(state.valueOrNull!.copyWith(
        todoList: newTodoList,
        isSuccessful: true,
        isLoading: false,
        hasError: false,
        errorMsg: null,
      ));
    }catch(e){
      state = AsyncValue.data(state.valueOrNull!.copyWith(
        isSuccessful: false,
        isLoading: false,
        hasError: true,
        errorMsg: e.toString()
      ));
    }
  }

  Future<void> updateTodo({
    required String tid,
    required UpdateAction action,
    dynamic data,
  }) async {
    final uid = ref.watch(authStateNotifierProvider).currentUser?.uid;
    if(uid == null) return;
    
    final todoRepository = ref.watch(todoRepositoryProvider(uid));

    final oldTodo = todoRepository.local.box.get(tid);
    if(oldTodo == null) return;

    state = AsyncValue.data(state.valueOrNull!.copyWith(isLoading: true));
    try{
      late final Todo newTodo;
      switch(action){
        case UpdateAction.completeStatus:
          newTodo = oldTodo.copyWith(
            isCompleted: !oldTodo.isCompleted,
            updatedAt: HandleConversionTzAndDateTime.dateTimeToTzUtc(DateTime.now())
          );
          break;
        case UpdateAction.deleteStatus:
          newTodo = oldTodo.copyWith(
            isDeleted: !oldTodo.isDeleted,
            updatedAt: HandleConversionTzAndDateTime.dateTimeToTzUtc(DateTime.now())
          );
          break;
        case UpdateAction.title:
          newTodo = oldTodo.copyWith(
            title: data! as String, 
            updatedAt: HandleConversionTzAndDateTime.dateTimeToTzUtc(DateTime.now())
          );
          break;
        case UpdateAction.description:
          newTodo = oldTodo.copyWith(
            description: data! as String, 
            updatedAt: HandleConversionTzAndDateTime.dateTimeToTzUtc(DateTime.now())
          );
          break;
        case UpdateAction.priority:
          newTodo = oldTodo.copyWith(
            priority: data! as int, 
            updatedAt: HandleConversionTzAndDateTime.dateTimeToTzUtc(DateTime.now())
          );
          break;
        case UpdateAction.dueDate:
          newTodo = oldTodo.copyWith(
            dueDate: data! as DateTime, 
            updatedAt: HandleConversionTzAndDateTime.dateTimeToTzUtc(DateTime.now())
          );
          break;
      }

      await todoRepository.saveTodoIntoLocal(todo: newTodo);
      final newTodoList = todoRepository.local.getUserTodosFromLocal(uid: uid);
      
      state = AsyncValue.data(state.valueOrNull!.copyWith(
        todoList: newTodoList,
        isSuccessful: true,
        isLoading: false,
        hasError: false,
        errorMsg: null
      ));
    }catch(e){
      state = AsyncValue.data(state.valueOrNull!.copyWith(
        isSuccessful: false,
        isLoading: false,
        hasError: true,
        errorMsg: e.toString()
      ));
    }
  }

  Future<void> reorderTodos({required List<Todo> newTodoList}) async {
    state = AsyncValue.data(state.value!.copyWith(
      todoList: newTodoList,
      isLoading: false,
      hasError: false,
      errorMsg: null
    ));
  }
}