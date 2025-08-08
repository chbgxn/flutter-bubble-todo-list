import 'package:bubble_todo_list/core/themes/config/app_sizes.dart';
import 'package:bubble_todo_list/core/utils/required_uid.dart';
import 'package:bubble_todo_list/features/todo/application/todo_providers.dart';
import 'package:bubble_todo_list/features/todo/presentation/todo_info_screen/widgets/edit_description.dart';
import 'package:bubble_todo_list/features/todo/presentation/todo_info_screen/widgets/edit_title.dart';
import 'package:bubble_todo_list/features/todo/presentation/shared/empty_widget.dart';
import 'package:bubble_todo_list/features/todo/presentation/todo_info_screen/widgets/priority_tile.dart';
import 'package:bubble_todo_list/features/todo/presentation/todo_info_screen/widgets/due_tile.dart';
import 'package:bubble_todo_list/features/todo/presentation/todo_info_screen/widgets/remind_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TodoInfoScreen extends ConsumerWidget {
  final String tid;
  
  const TodoInfoScreen({super.key, required this.tid});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final uid = requiredUid(context, ref);
    if(uid == null) return SizedBox();

    final todoListState = ref.watch(todoListStateAsyncNotifierProvider(uid)).valueOrNull;
    if(todoListState == null) return EmptyWidget();

    final repo = ref.watch(todoRepositoryProvider(uid));
    final todo = repo.local.box.get(tid);
    if(todo == null) return EmptyWidget();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('详情', style: Theme.of(context).textTheme.headlineLarge),
      ),
      body: Container(
        height: AppSizes.screenHeight * 0.6,
        width: AppSizes.screenWidth,
        padding: EdgeInsets.all(AppSizes.paddingSmall),
        child: Column(
          spacing: AppSizes.paddingSmall,
          children: [

            EditTitle(todo: todo),
            
            PriorityTile(todo: todo),

            Divider(),

            DueTile(tid: tid),

            Divider(),
              
            RemindTile(tid: tid),

            Divider(),

            EditDescription(todo: todo),

            Divider()
          ],
        )
      ),
    );
  }
}