import 'package:bubble_todo_list/core/themes/config/app_sizes.dart';
import 'package:bubble_todo_list/core/utils/check_permission.dart';
import 'package:bubble_todo_list/core/utils/required_uid.dart';
import 'package:bubble_todo_list/core/utils/show_toast.dart';
import 'package:bubble_todo_list/features/todo/application/todo_providers.dart';
import 'package:bubble_todo_list/features/todo/presentation/shared/empty_widget.dart';
import 'package:bubble_todo_list/features/todo/presentation/todo_info_screen/widgets/pick_notification_time_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class RemindTile extends ConsumerWidget {
  final String tid;
  const RemindTile({super.key, required this.tid});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uid = requiredUid(context, ref);
    if(uid == null) return SizedBox();
  
    final repo = ref.watch(todoRepositoryProvider(uid));
    final todo = repo.local.box.get(tid);
    if(todo == null) return EmptyWidget();

    return Expanded(
      child: InkWell(
        onTap:() async {
          if(await checkPermission()){
            if(context.mounted){
              showMaterialModalBottomSheet(
                context: context,
                builder: (context) => PickNotificationTimeSheet(tid: tid, title: todo.title,),
              );
            }
            else{
              if(context.mounted){
                ShowToast.show(
                  context: context, 
                  status: false, 
                  msg: '请授予通知权限'
                );
              }
            }

          }
        },
        child: Row(
          spacing: AppSizes.paddingSmall,
          children: [
            Icon(
              Icons.notification_add, 
              size: AppSizes.iconRegular,
              color: Colors.purple,
            ),
            Text('设置提醒', style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      )
    );
  }
}