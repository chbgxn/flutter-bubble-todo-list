import 'package:bubble_todo_list/core/utils/app_router.dart';
import 'package:bubble_todo_list/core/themes/config/app_sizes.dart';
import 'package:bubble_todo_list/core/utils/show_alert_dialog.dart';
import 'package:bubble_todo_list/features/auth/application/auth_providers.dart';
import 'package:bubble_todo_list/shared/widgets/profile_screen/setting_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SettingsList extends ConsumerWidget{
  const SettingsList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authStateNotifier = ref.read(authStateNotifierProvider.notifier);

    Future<void> signOut(BuildContext context) async{
      await showAlertDialog(
        context: context,
        title: '退出登录', 
        onPressed: (context) async{
          Navigator.pop(context);
          await authStateNotifier.signOut();
        } 
      );  
    }

    return Container(
      height: AppSizes.screenHeight * 0.4,
      width: AppSizes.screenWidth,
      margin: EdgeInsets.symmetric(horizontal: AppSizes.paddingSmall),
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(AppSizes.radiusRegular),
      ),
      alignment: Alignment.center,
      child: FractionallySizedBox(
        heightFactor: 0.9,
        widthFactor: 0.9,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            SettingTile(title: '同步', tap: (){}),
            Divider(),
            SettingTile(title: '外观', tap: () => context.push(AppRouter.switchMode)),
            Divider(),
            SettingTile(title: '语言选择', tap: () => context.push(AppRouter.switchLocale)),
            Divider(),
            SettingTile(title: '退出登录', tap: () async => await signOut(context)),
            Divider()
          ],
        ),
      )
    );
  }
}