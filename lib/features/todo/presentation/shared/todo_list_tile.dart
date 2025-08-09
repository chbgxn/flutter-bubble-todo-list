import 'package:bubble_todo_list/core/themes/config/app_sizes.dart';
import 'package:bubble_todo_list/core/utils/app_router.dart';
import 'package:bubble_todo_list/core/utils/handle_conversion_tz_and_date_time.dart';
import 'package:bubble_todo_list/core/utils/required_todo_list_state.dart';
import 'package:bubble_todo_list/core/utils/required_uid.dart';
import 'package:bubble_todo_list/core/utils/show_alert_dialog.dart';
import 'package:bubble_todo_list/features/todo/application/todo_list_state_async_notifier.dart';
import 'package:bubble_todo_list/features/todo/application/todo_providers.dart';
import 'package:bubble_todo_list/features/todo/models/todo.dart';
import 'package:bubble_todo_list/features/todo/presentation/shared/complete_button.dart';
import 'package:bubble_todo_list/features/todo/presentation/shared/empty_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

class TodoListTile extends ConsumerWidget {
  final Todo todo;
  const TodoListTile({super.key, required this.todo});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uid = requiredUid(context, ref);
    if(uid == null) return SizedBox();

    final todoListState = requiredTodoListState(context, ref, uid);
    if(todoListState == null) return EmptyWidget();
    
    return Slidable(
      endActionPane: ActionPane(
        motion: const DrawerMotion(),
        extentRatio: 0.25, 
        children:  [
          SlidableAction(
            autoClose: true,
            backgroundColor: !todo.isDeleted ? Colors.redAccent : Colors.amber,
            onPressed: (context) => showAlertDialog(
              context: context, 
              title: !todo.isDeleted ? '删除' : '还原',
              onPressed: (context) async {
                await  ref.read(todoListStateAsyncNotifierProvider(uid).notifier).updateTodo(
                  tid: todo.tid,
                  action: UpdateAction.deleteStatus,
                );

                if(context.mounted){
                  context.pop();
                }
              }
            ),
            icon: !todo.isDeleted ? Icons.delete : Icons.turn_left,
          )
        ]
      ),
      child: GestureDetector(
        behavior: HitTestBehavior.deferToChild,
        onTap: () => context.push('${AppRouter.todoInfo}/${todo.tid}'),
        child: Container(
          height: AppSizes.screenHeight * 0.08,
          padding: EdgeInsets.symmetric(horizontal: AppSizes.paddingSmall),
          child: Row(
            children: [
              Expanded(
                flex: 7,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      todo.title, 
                      style: Theme.of(context).textTheme.bodyMedium,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    
                    todo.isCompleted 
                    ? Text('已完成', style: Theme.of(context).textTheme.labelLarge)
                    : todo.dueDate == null
                      ? Text(
                        '创建于: ${DateFormat('yyyy-MM-dd').format(
                          HandleConversionTzAndDateTime.utcToTzLocal(utc: todo.createdAt)
                        )}',
                        style: Theme.of(context).textTheme.labelLarge
                        )
                      : (todo.dueDate!.isAfter(DateTime.now().toUtc()) 
                        ? Text(
                          '截止日期: ${DateFormat('yyyy-MM-dd').format(
                            HandleConversionTzAndDateTime.utcToTzLocal(utc: todo.dueDate!)
                          )}',
                          style: Theme.of(context).textTheme.labelLarge
                        )
                        : Text(
                          '已过期', 
                          style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Colors.red)
                          )
                        )                                        
                  ],
                )
              ),
              Expanded(
                child: CompleteButton(tid: todo.tid),
              ),
            ],
          ) 
        ),
      ),
    );
  }
}