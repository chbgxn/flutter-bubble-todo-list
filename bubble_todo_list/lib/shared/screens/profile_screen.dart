import 'package:bubble_todo_list/core/utils/use_auth_state_listener.dart';
import 'package:bubble_todo_list/shared/widgets/profile_screen/settings_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileScreen extends ConsumerStatefulWidget{
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  bool _listen = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if(!_listen){
      _listen = true;
      useAuthStateListener(context, ref);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('个人界面', style: Theme.of(context).textTheme.headlineLarge)),
      body: SafeArea(
        child: Center(
          child: SettingsList()
        ) 
      ),
    );
  }
}