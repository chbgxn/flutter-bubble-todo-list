import 'package:bubble_todo_list/core/themes/config/app_sizes.dart';
import 'package:bubble_todo_list/core/utils/required_uid.dart';
import 'package:bubble_todo_list/features/todo/application/todo_providers.dart';
import 'package:bubble_todo_list/features/todo/presentation/shared/empty_widget.dart';
import 'package:bubble_todo_list/features/todo/presentation/todo_info_screen/widgets/pick_due_date_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class DueTile extends ConsumerWidget {
  final String tid;
  const DueTile({super.key, required this.tid});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uid = requiredUid(context, ref);
    if(uid == null) return SizedBox();
  
    final repo = ref.watch(todoRepositoryProvider(uid));
    final todo = repo.local.box.get(tid);
    if(todo == null) return EmptyWidget();

    return Expanded(
      child: InkWell(
        onTap:() => showMaterialModalBottomSheet(
          context: context,
          builder: (context) => PickDueDateSheet(tid: tid),
        ),
        child: Row(
            spacing: AppSizes.paddingSmall,
            children: [
              Icon(
                Icons.calendar_today, 
                size: AppSizes.iconRegular,
                color: Colors.red,
              ),
              Text('设置截止时间', style: Theme.of(context).textTheme.bodyMedium),
            ],
        ),  
      )
    );
  }
}

