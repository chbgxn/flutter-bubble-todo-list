import 'package:bubble_todo_list/core/themes/config/app_sizes.dart';
import 'package:bubble_todo_list/core/utils/required_todo_list_state.dart';
import 'package:bubble_todo_list/core/utils/required_uid.dart';
import 'package:bubble_todo_list/features/todo/application/todo_list_state_async_notifier.dart';
import 'package:bubble_todo_list/features/todo/application/todo_providers.dart';
import 'package:bubble_todo_list/features/todo/models/todo.dart';
import 'package:bubble_todo_list/features/todo/presentation/shared/empty_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class EditDescription extends ConsumerWidget {
  final Todo todo;
  const EditDescription({super.key, required this.todo});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    late final txt;
    final uid = requiredUid(context, ref);
    if(uid == null) return SizedBox();

    final todoListState = requiredTodoListState(context, ref, uid);
    if(todoListState == null) return EmptyWidget();

    final todoListStateNotifier = ref.read(todoListStateAsyncNotifierProvider(uid).notifier);

    return Expanded(
      flex: 2,
      child: InkWell(
        onTap: () => showMaterialModalBottomSheet(
          context: context,
          builder: (context) => Material(
            child: Container(
              width: AppSizes.screenWidth,
              height: AppSizes.screenHeight * 0.8,
              padding: EdgeInsets.all(AppSizes.paddingSmall),
              child: Column(
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('添加备注', style: Theme.of(context).textTheme.bodyMedium),
                        TextButton(
                          onPressed: () => FocusScope.of(context).unfocus(),
                          child: Text('完成', style: Theme.of(context).textTheme.bodyMedium)
                        )
                      ],
                    )
                  ),
                  Expanded(
                    flex: 8,
                    child: TextField(
                      autofocus: true,
                      decoration: InputDecoration(
                        hintText: todo.description ?? '编辑',
                        hintStyle: Theme.of(context).textTheme.bodyMedium,
                        border: InputBorder.none
                      ),
                      maxLength: 90,
                      maxLines: 6,
                      textInputAction: TextInputAction.done,
                      onSubmitted: (value){
                        txt = value;
                        FocusScope.of(context).unfocus();
                      }
                    ),
                  )
                ],
              )
            ),
          )
        ).then((_) => todoListStateNotifier.updateTodo(
          tid: todo.tid, 
          action: UpdateAction.description,
          data: txt,
        )),
        child: Container(
          height: AppSizes.screenHeight * 0.1,
          alignment: Alignment.topLeft,
          child: Text(
            todo.description ?? '编辑',
            style: Theme.of(context).textTheme.bodyMedium
          ),
        ),
      ),
    ); 
  }
}
