import 'package:bubble_todo_list/core/utils/required_todo_list_state.dart';
import 'package:bubble_todo_list/core/utils/required_uid.dart';
import 'package:bubble_todo_list/core/utils/show_toast.dart';
import 'package:bubble_todo_list/features/todo/application/todo_list_state_async_notifier.dart';
import 'package:bubble_todo_list/features/todo/application/todo_providers.dart';
import 'package:bubble_todo_list/features/todo/models/todo.dart';
import 'package:bubble_todo_list/features/todo/presentation/shared/complete_button.dart';
import 'package:bubble_todo_list/features/todo/presentation/shared/empty_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EditTitle extends ConsumerWidget {
  final Todo todo;

  const EditTitle({super.key, required this.todo});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uid = requiredUid(context, ref);
    if(uid == null) return SizedBox();

    final todoListState = requiredTodoListState(context, ref, uid);
    if(todoListState == null) return EmptyWidget();

    final todoListStateNotifier = ref.read(todoListStateAsyncNotifierProvider(uid).notifier);

    return Expanded(
      child: ListTile(
        title: TextField(
          style: Theme.of(context).textTheme.headlineLarge,
          decoration: InputDecoration(
            hintText: todo.title,
            hintStyle: Theme.of(context).textTheme.headlineLarge,
            border: InputBorder.none,
          ),
          textInputAction: TextInputAction.done,
          onSubmitted: (value) async {
            if(value.trim().isEmpty){
              await ShowToast.show(context: context, status: false, msg: '标题不能为空');
              return;
            }
            await todoListStateNotifier.updateTodo(
              tid: todo.tid, 
              action: UpdateAction.title, 
              data: value.trim()
            );
            if(context.mounted){
              if(todoListState.isSuccessful){
                await ShowToast.show(context: context, status: true);
              }
            }
          },
        ),
        trailing: CompleteButton(tid: todo.tid),
      )
    );
  }
}