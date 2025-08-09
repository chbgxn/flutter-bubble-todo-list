import 'package:bubble_todo_list/core/themes/config/app_sizes.dart';
import 'package:bubble_todo_list/core/utils/required_todo_list_state.dart';
import 'package:bubble_todo_list/core/utils/required_uid.dart';
import 'package:bubble_todo_list/features/todo/presentation/shared/empty_widget.dart';
import 'package:bubble_todo_list/features/todo/presentation/shared/todo_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DeletedScreen extends ConsumerWidget {
  const DeletedScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uid = requiredUid(context, ref);
    if(uid == null) return SizedBox();

    final todoListState = requiredTodoListState(context, ref, uid);
    if(todoListState == null) return EmptyWidget();

    return Scaffold(
      appBar: AppBar(title: Text('回收站', style: Theme.of(context).textTheme.headlineLarge)),
      body: todoListState.deletedTodos.isEmpty
        ? Center(
            child: Text('空空如也', style: Theme.of(context).textTheme.headlineLarge)
          )
        : Column(
          children: [
            SizedBox(height: AppSizes.paddingSmall),
            TodoAnimatedList(todos: todoListState.deletedTodos)
          ],
        )
         
    );
  }
}