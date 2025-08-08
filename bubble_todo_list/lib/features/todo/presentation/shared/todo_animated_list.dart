import 'package:bubble_todo_list/core/themes/config/app_sizes.dart';
import 'package:bubble_todo_list/features/todo/models/todo.dart';
import 'package:bubble_todo_list/features/todo/presentation/shared/todo_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:implicitly_animated_reorderable_list_2/implicitly_animated_reorderable_list_2.dart';
import 'package:implicitly_animated_reorderable_list_2/transitions.dart';

class TodoAnimatedList extends ConsumerWidget {
  final List<Todo> todos;
  const TodoAnimatedList({super.key, required this.todos});
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return Expanded(
      flex: 9,
      child: todos.isEmpty
      ? Center(
        child: Text('空空如也', style: Theme.of(context).textTheme.headlineLarge),
      )
      : ImplicitlyAnimatedList<Todo>(
        items: todos,
        areItemsTheSame: (oldTodo, newTodo) => oldTodo.tid == newTodo.tid, 
        itemBuilder: (context, itemAnimation, todo, index){
         
         return SizeFadeTransition(
            sizeFraction: 0.7,
            curve: Curves.easeInOut,
            animation: itemAnimation,
            child: Column(
              children: [
                TodoListTile(todo: todo),

                Divider(color: Colors.lightBlue,),
              
                SizedBox(height: AppSizes.paddingSmall),

                index == todos.length -1 
                  ? Align(child: Text('- 没有更多了 -'),)
                  : SizedBox.shrink()
              ],
            ),
          );
        },
      )
    );  
  }
}