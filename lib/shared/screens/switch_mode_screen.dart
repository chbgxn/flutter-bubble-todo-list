import 'package:bubble_todo_list/core/themes/config/app_sizes.dart';
import 'package:bubble_todo_list/core/utils/required_uid.dart';
import 'package:bubble_todo_list/shared/application/setting_provider.dart';
import 'package:bubble_todo_list/shared/widgets/profile_screen/operation_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SwitchModeScreen extends ConsumerWidget {
  const SwitchModeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uid = requiredUid(context, ref);
    if(uid == null) return SizedBox();

    final mode = ref.watch(modeStateProvider(uid));
    
    final modeSwitch = ref.read(modeStateProvider(uid).notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '外观', 
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
                result: mode, 
                tap: () async => await modeSwitch.followSystem(),
                index: 0,
              ),

              Divider(),

              OperationTile(
                title: '白天模式', 
                result: mode, 
                tap: () async => await modeSwitch.toLight(),
                index: 1,
              ),
              
              Divider(),

              OperationTile(
                title: '夜间模式', 
                result: mode, 
                tap: () async => await modeSwitch.toDark(),
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
