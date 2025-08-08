import 'package:bubble_todo_list/core/themes/config/app_sizes.dart';
import 'package:bubble_todo_list/core/utils/app_router.dart';
import 'package:bubble_todo_list/core/utils/required_uid.dart';
import 'package:bubble_todo_list/features/todo/presentation/home_screen/widgets/completed_todos_sheet.dart';
import 'package:bubble_todo_list/features/todo/application/todo_providers.dart';
import 'package:bubble_todo_list/features/todo/presentation/home_screen/widgets/todo_list_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  bool _isSuccessful = false;

  @override
  Widget build(BuildContext context) {
    final uid = requiredUid(context, ref);
    if(uid == null) return SizedBox();
    
    final todoListStateAsync = ref.watch(todoListStateAsyncNotifierProvider(uid));

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('待办事项', style: Theme.of(context).textTheme.headlineLarge),
        actions: _isSuccessful 
        ? [
          IconButton(
            onPressed: () => completedTodosSheet(context, 0), 
            icon: Icon(Icons.check, size: AppSizes.iconRegular, color: Colors.lightGreen,),
          ),
          IconButton(
            onPressed: () => completedTodosSheet(context, 1), 
            icon: Icon(Icons.today , size: AppSizes.iconRegular, color: Colors.orange,)
          ),
          IconButton(
            onPressed: () => context.push(AppRouter.deletedTodoList), 
            icon: Icon(Icons.delete, size: AppSizes.iconRegular, color: Colors.red,)
          ),
        ]
        : null,
      ),
      body: SizedBox(
        height: AppSizes.screenHeight,
        width: AppSizes.screenWidth,
        child: todoListStateAsync.when(
          data: (_){
            WidgetsBinding.instance.addPostFrameCallback((_){
              if(mounted){
                setState(() => _isSuccessful = true);
              }
            });
            return TodoListData();
          },
          error: (e, _){
            WidgetsBinding.instance.addPostFrameCallback((_){
              if(mounted){
                setState(() => _isSuccessful = false);
              }
            });
            return Text(e.toString());
          },
          loading: (){
            WidgetsBinding.instance.addPostFrameCallback((_){
              if(mounted){
                setState(() => _isSuccessful = false);
              }
            });
            return Center(child: CircularProgressIndicator());
          }
        )
      )
    );
  }
}