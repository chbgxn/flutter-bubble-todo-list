import 'package:bubble_todo_list/core/constants/priority.dart';
import 'package:bubble_todo_list/core/themes/config/app_sizes.dart';
import 'package:bubble_todo_list/features/todo/models/todo.dart';
import 'package:bubble_todo_list/features/todo/presentation/todo_info_screen/widgets/pick_priority.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class PriorityTile extends ConsumerWidget {
  final Todo todo;
  const PriorityTile({super.key, required this.todo});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Expanded(
      child: InkWell(
        onTap: () => showMaterialModalBottomSheet(
          context: context, 
          builder: (context) => PickPriority(tid: todo.tid)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              spacing: AppSizes.paddingSmall,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.priority_high, 
                  size: AppSizes.iconRegular, 
                  color: Colors.amber,
                ),
                Text('设置优先级', style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),

            Text(
              '当前优先级: ${priority[todo.priority]}',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: todo.priority == 0 
                  ? Colors.blue
                  : (todo.priority == 1 ? Colors.purple : Colors.red)
              )
            )
          ],
        ),
      ),
    );
  }
}