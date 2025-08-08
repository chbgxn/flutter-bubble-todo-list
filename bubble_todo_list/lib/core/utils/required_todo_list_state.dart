import 'package:bubble_todo_list/features/todo/application/todo_providers.dart';
import 'package:bubble_todo_list/features/todo/models/todo_list_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

TodoListState? requiredTodoListState(BuildContext context, WidgetRef ref, String uid) {
  final todoListStata = ref.watch(todoListStateAsyncNotifierProvider(uid)).valueOrNull;
  return todoListStata;
}