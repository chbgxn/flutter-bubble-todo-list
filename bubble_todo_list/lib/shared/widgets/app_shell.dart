import 'package:bubble_todo_list/core/utils/app_router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppShell extends StatelessWidget {
  final String location;
  final Widget child;
  const AppShell({super.key, required this.location, required this.child});

  int _getCurrentIndex(){
    if(location == '/') return 0;
    if(location.startsWith(AppRouter.profile)) return 1;
    return 0;
  }

  void _jumpToIndex(BuildContext context,int index){
    switch(index){
      case 0:
        context.go(AppRouter.home);
        break;
      case 1:
        context.go(AppRouter.profile);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _getCurrentIndex(),
        onTap: (index) => _jumpToIndex(context, index),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '主页'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: '我的'
          )
        ],
        selectedLabelStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(color:Colors.amber),
        unselectedLabelStyle: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }
}