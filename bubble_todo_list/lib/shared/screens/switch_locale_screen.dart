import 'package:bubble_todo_list/core/themes/config/app_sizes.dart';
import 'package:bubble_todo_list/core/utils/required_uid.dart';
import 'package:bubble_todo_list/shared/application/setting_provider.dart';
import 'package:bubble_todo_list/shared/widgets/profile_screen/operation_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SwitchLocaleScreen extends ConsumerWidget {
  const SwitchLocaleScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uid = requiredUid(context, ref);
    if(uid == null) return SizedBox();

    final theLocale = ref.watch(localeStateProvider(uid));

    final localeSwitch = ref.read(localeStateProvider(uid).notifier);
    
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '语言', 
          style: Theme.of(context).textTheme.headlineLarge
        )
      ),
      body: SizedBox(
        height: AppSizes.screenHeight,
        width: AppSizes.screenWidth,
        child: FractionallySizedBox(
          heightFactor: 0.3,
          widthFactor: 0.9,
          alignment: Alignment.topCenter,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              OperationTile(
                title: '跟随系统', 
                result: theLocale, 
                tap: () async => await localeSwitch.followSystem(),
                index: 0,
              ),

              Divider(),

              OperationTile(
                title: '中文', 
                result: theLocale, 
                tap: () async => await localeSwitch.toZh(),
                index: 1,
              ),
              Divider(),

              OperationTile(
                title: '英文', 
                result: theLocale,
                tap: () async => await localeSwitch.toEn(),
                index: 2,
              ),

              Divider()
            ],
          ),
        )
      ),
    );
  }
}
