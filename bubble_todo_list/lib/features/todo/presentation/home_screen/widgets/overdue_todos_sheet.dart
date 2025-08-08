import 'package:bubble_todo_list/core/themes/config/app_sizes.dart';
import 'package:bubble_todo_list/core/utils/required_todo_list_state.dart';
import 'package:bubble_todo_list/core/utils/required_uid.dart';
import 'package:bubble_todo_list/features/todo/presentation/shared/empty_widget.dart';
import 'package:bubble_todo_list/features/todo/presentation/shared/todo_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void overdueTodosSheet(BuildContext context){
  showModalBottomSheet(
    context: context, 
    isScrollControlled: true,
    builder:(context) => Consumer(
      builder:(context, ref, _) {
        final uid = requiredUid(context, ref);
        if(uid == null) return SizedBox();

        final todoListState = requiredTodoListState(context, ref, uid);
        if(todoListState == null) return EmptyWidget();

        return Container(
          width: AppSizes.screenWidth,
          height: AppSizes.screenHeight / 2 ,
          padding: EdgeInsets.all(AppSizes.paddingSmall),
          alignment: Alignment.center,
          child: Column(
            spacing: AppSizes.paddingSmall,
            children: [
              Text('已过期', style: Theme.of(context).textTheme.headlineLarge),
              TodoAnimatedList(todos: todoListState.overdueTodos)
            ],
          ),
        );
      }
    )      
  );
}