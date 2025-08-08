import 'package:bubble_todo_list/core/themes/config/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddTodoWidget extends ConsumerWidget {
  const AddTodoWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Expanded(
      child: Container(
        decoration:BoxDecoration(
        borderRadius: BorderRadius.circular(AppSizes.radiusRegular),
          color: Colors.blueGrey
        ),
        margin: EdgeInsets.only(top: AppSizes.paddingSmall),
        padding: EdgeInsets.symmetric(horizontal: AppSizes.paddingSmall),
        child: Row(
          children: [
            Expanded(
              flex: 7,
              child: Text('添加待办', style: Theme.of(context).textTheme.bodyMedium)
            ),
            Expanded(
              child: Icon(Icons.add)
            ),
          ],
        ),
      )
    );
  }
}