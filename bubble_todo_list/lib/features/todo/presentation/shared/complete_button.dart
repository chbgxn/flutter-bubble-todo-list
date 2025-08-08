import 'package:bubble_todo_list/core/themes/config/app_sizes.dart';
import 'package:bubble_todo_list/core/utils/required_todo_list_state.dart';
import 'package:bubble_todo_list/core/utils/required_uid.dart';
import 'package:bubble_todo_list/features/todo/application/todo_providers.dart';
import 'package:bubble_todo_list/features/todo/application/todo_list_state_async_notifier.dart';
import 'package:bubble_todo_list/features/todo/presentation/shared/empty_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CompleteButton extends ConsumerWidget {
  final String tid;

  const CompleteButton({super.key, required this.tid});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uid = requiredUid(context, ref);
    if(uid == null) return SizedBox();

    final todoListStateAsyncNotifier = ref.read(todoListStateAsyncNotifierProvider(uid).notifier);

    final todoListState = requiredTodoListState(context, ref, uid);
    if(todoListState == null) return EmptyWidget();
    
    final todo = todoListState.todoList.firstWhere((todo) => todo.tid == tid);

    return GestureDetector(
      onTap: () async {
        await todoListStateAsyncNotifier.updateTodo(tid: tid, action: UpdateAction.completeStatus);
      },
      child: AnimatedContainer(
        height: AppSizes.iconRegular,
        width: AppSizes.iconRegular,
        duration: Duration(seconds: 2),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.blue),
          color: todo.isCompleted ? Colors.green : Colors.white
        ),
      ),
    );
  }
}