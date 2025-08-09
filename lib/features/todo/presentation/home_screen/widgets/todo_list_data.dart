import 'package:bubble_todo_list/core/themes/config/app_sizes.dart';
import 'package:bubble_todo_list/core/utils/required_todo_list_state.dart';
import 'package:bubble_todo_list/core/utils/required_uid.dart';
import 'package:bubble_todo_list/features/todo/application/todo_providers.dart';
import 'package:bubble_todo_list/features/todo/models/todo.dart';
import 'package:bubble_todo_list/features/todo/models/todo_list_state.dart';
import 'package:bubble_todo_list/features/todo/presentation/home_screen/widgets/add_todo_widget.dart';
import 'package:bubble_todo_list/features/todo/presentation/home_screen/widgets/add_todo_field.dart';
import 'package:bubble_todo_list/features/todo/presentation/shared/empty_widget.dart';
import 'package:bubble_todo_list/features/todo/presentation/shared/todo_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TodoListData extends ConsumerWidget {
  const TodoListData({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isExpand = ref.watch(textFieldExpandProvider);

    final uid = requiredUid(context, ref);
    if(uid == null) return SizedBox();

    final todoListState = requiredTodoListState(context, ref, uid);
    if(todoListState == null) return EmptyWidget();

    final List<Todo> todos = todoListState.filteredList;
    final thisSortMode = todoListState.sort;

    final todoListStateNotifier = ref.read(todoListStateAsyncNotifierProvider(uid).notifier);
  
    return Stack(
      children: [
        GestureDetector(
          behavior: HitTestBehavior.deferToChild,
          onTap: () => ref.read(textFieldExpandProvider.notifier).state = !isExpand,
          child: Padding(
            padding: EdgeInsets.all(AppSizes.paddingSmall),
            child: Column(
              spacing: AppSizes.paddingSmall,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DropdownButton(
                  value: thisSortMode,
                  style: Theme.of(context).textTheme.labelLarge,
                  items: [
                    DropdownMenuItem(
                      value: SortMode.newestFirst,
                      child: Text('最新创建', style: Theme.of(context).textTheme.bodyMedium)
                    ),
                    DropdownMenuItem(
                      value: SortMode.priorityHighToLow,
                      child: Text('优先处理', style: Theme.of(context).textTheme.bodyMedium)
                    )
                  ], 
                  onChanged: (mode) => todoListStateNotifier.setSortMode(mode!)
                ),
              
                TodoAnimatedList(todos: todos), 
                AddTodoWidget(),
              ],
            ),
          ),
        ),
       
        isExpand 
        ? AnimatedPositioned(
          bottom: 0,
          left: 0,
          right: 0,
          duration: Duration(milliseconds: 500),
          curve: Curves.fastOutSlowIn,
          child: AddTodoField(), 
        )
        : SizedBox.shrink()
      ],
    );
  }
}
