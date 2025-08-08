import 'package:bubble_todo_list/core/constants/priority.dart';
import 'package:bubble_todo_list/core/themes/config/app_sizes.dart';
import 'package:bubble_todo_list/core/utils/required_todo_list_state.dart';
import 'package:bubble_todo_list/core/utils/required_uid.dart';
import 'package:bubble_todo_list/core/utils/show_toast.dart';
import 'package:bubble_todo_list/features/todo/application/todo_list_state_async_notifier.dart';
import 'package:bubble_todo_list/features/todo/application/todo_providers.dart';
import 'package:bubble_todo_list/features/todo/presentation/shared/empty_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class PickPriority extends ConsumerStatefulWidget {
  final String tid;
  const PickPriority({super.key, required this.tid});

  @override
  ConsumerState<PickPriority> createState() => _PickPriorityState();
}

class _PickPriorityState extends ConsumerState<PickPriority> {
  int selectNum = 1;
  @override
  Widget build(BuildContext context) {
    final uid = requiredUid(context, ref);
    if(uid == null) return SizedBox();

    final todoListState = requiredTodoListState(context, ref, uid);
    if(todoListState == null) return EmptyWidget();

    final todoListStateNotifier = ref.read(todoListStateAsyncNotifierProvider(uid).notifier);

    return Container(
      height: AppSizes.screenHeight * 0.3,
      width: AppSizes.screenWidth,
      padding: EdgeInsets.all(AppSizes.paddingSmall),
      child: Column(
        children: [
          Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '当前选择: ${priority[selectNum]}', 
                  style: Theme.of(context).textTheme.bodyMedium
                ),

                InkWell(
                  onTap: () async {
                    await todoListStateNotifier.updateTodo(
                      tid: widget.tid, 
                      action: UpdateAction.priority,
                      data: selectNum
                    );
                    if(context.mounted){
                      context.pop();
                      await ShowToast.show(context: context, status: todoListState.isSuccessful);
                    }
                  }, 
                  child: Text('确定', style: Theme.of(context).textTheme.bodyMedium)
                )
              ],
            )
          ),
          Expanded(
            flex: 8,
            child: ListWheelScrollView(
              itemExtent: AppSizes.screenHeight * 0.1, 
              useMagnifier: true,
              onSelectedItemChanged: (value) => setState(() => selectNum = value),
              children: [
                ...priority.map((e) =>
                  Text(
                    e, 
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: selectNum == priority.indexOf(e) 
                        ? Colors.red : Colors.black
                    ),
                  )                  
                )
              ]
            ),
          )
        ],
      )
    );
  }
}