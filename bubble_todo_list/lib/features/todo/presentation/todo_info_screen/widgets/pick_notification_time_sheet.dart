import 'package:bubble_todo_list/core/themes/config/app_sizes.dart';
import 'package:bubble_todo_list/core/utils/handle_conversion_tz_and_date_time.dart';
import 'package:bubble_todo_list/core/utils/required_uid.dart';
import 'package:bubble_todo_list/core/utils/show_toast.dart';
import 'package:bubble_todo_list/features/todo/presentation/todo_info_screen/widgets/date_time_picker_sheet.dart';
import 'package:bubble_todo_list/features/todo/presentation/todo_info_screen/widgets/update_date_button.dart';
import 'package:bubble_todo_list/shared/application/notification_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class PickNotificationTimeSheet extends ConsumerWidget {
  final String tid;
  final String title;
  const PickNotificationTimeSheet({super.key, required this.tid, required this.title});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uid = requiredUid(context, ref);
    if(uid == null) return SizedBox();
    
    final notificationServiceNotifier = ref.watch(notificationServiceProvider(uid));

    return Container(
      width: AppSizes.screenWidth,
      height: AppSizes.screenHeight * 0.4,
      alignment: Alignment.center,
      padding: EdgeInsets.all(AppSizes.paddingRegular),
      child: Column(
        children: [
          UpdateDateButton(
            onTap: () async{
              await notificationServiceNotifier.showScheduleNotification(
                utc: HandleConversionTzAndDateTime.dateTimeToTzUtc(
                  DateTime.now()).add(const Duration(seconds: 5)
                ), 
                title: title
              );
              if(context.mounted){
                context.pop();
                await ShowToast.show(context: context, status: true);
              }
            },
            title: '测试：五秒后通知',
            icon: Icon(Icons.watch, size: AppSizes.iconRegular, color: Colors.red),
          ),

          Divider(),

          UpdateDateButton(
            onTap: () async{
              await notificationServiceNotifier.showScheduleNotification(
                utc: HandleConversionTzAndDateTime.dateTimeToTzUtc(
                  DateTime.now()).add(const Duration(hours: 2)), 
                title: title
              );
              if(context.mounted){
                context.pop();
                await ShowToast.show(context: context, status: true);
              }
            },
            title: '两个小时后通知',
            icon: Icon(Icons.today, size: AppSizes.iconRegular, color: Colors.blue,),
          ),

          Divider(),

          UpdateDateButton(
            onTap: () async {
              final tzUtcSelectDate = await showModalBottomSheet<DateTime>(
                context: context, 
                builder: (context) => DateTimePickerSheet(tid: tid, cmd: false)
              );
              if(tzUtcSelectDate != null){
                notificationServiceNotifier.showScheduleNotification(
                  utc: HandleConversionTzAndDateTime.dateTimeToTzUtc(tzUtcSelectDate), 
                  title: title
                );
                if(context.mounted){
                  context.pop();
                  await ShowToast.show(context: context, status: true);
                }
              }
            },
            title: '自定义通知时间',
            icon: Icon(
              Icons.my_library_add, size: AppSizes.iconRegular, color: Colors.amber),
          ),
        ],
      ),
    );
  }
}