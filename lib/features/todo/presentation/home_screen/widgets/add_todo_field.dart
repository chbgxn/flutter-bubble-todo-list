import 'package:bubble_todo_list/core/themes/config/app_sizes.dart';
import 'package:bubble_todo_list/core/utils/required_uid.dart';
import 'package:bubble_todo_list/features/todo/application/todo_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddTodoField extends ConsumerStatefulWidget {
  const AddTodoField({super.key});

  @override
  ConsumerState<AddTodoField> createState() => _AddTodoFieldState();
}

class _AddTodoFieldState extends ConsumerState<AddTodoField> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final uid = requiredUid(context, ref);
    if(uid == null) return SizedBox();

    final todoListStateAsyncNotifier = ref.read(todoListStateAsyncNotifierProvider(uid).notifier);

    return Container(
      width: AppSizes.screenWidth,
      height: AppSizes.screenHeight * 0.08,
      color: Colors.blueGrey,
      padding: EdgeInsets.all(AppSizes.paddingSmall),
      child: Column(
        children: [
          Expanded(
            child: TextField(
              autofocus: true,
              controller: _controller,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.edit_note, size: AppSizes.iconLarge, color: Colors.blue,),
                hintText: '添加待办',
                hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white),
                suffixIcon: TextButton(
                  onPressed: () async {
                    _controller.text.trim().isEmpty
                      ? ref.read(textFieldExpandProvider.notifier).state = false
                      : await todoListStateAsyncNotifier.addTodo(title: _controller.text.trim());
                  }, 
                  child: Text(
                    _controller.text.trim().isEmpty ? '返回' : '完成', 
                    style: Theme.of(context).textTheme.bodyMedium
                  )
                ),
                border: InputBorder.none,
              ),
              style: Theme.of(context).textTheme.bodyMedium,
              textInputAction: TextInputAction.done,
              onSubmitted: (value) async {
                value.trim().isEmpty
                  ? ref.read(textFieldExpandProvider.notifier).state = false
                  : await todoListStateAsyncNotifier.addTodo(title: value.trim());
                 _controller.clear();
                 setState(() => value = '');
              },
            ),
          ),
          Divider()
        ],
      ),
    );
  }
}
