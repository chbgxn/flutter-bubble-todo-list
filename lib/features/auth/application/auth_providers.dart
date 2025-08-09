import 'package:bubble_todo_list/features/auth/application/auth_state_notifier.dart';
import 'package:bubble_todo_list/features/auth/damain/auth_service.dart';
import 'package:bubble_todo_list/features/auth/models/auth_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//Data Source, [ZH]数据源 
final authProvider = Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);

//业务逻辑层
final authServiceProvider = Provider<AuthService>((ref){
  final auth = ref.watch(authProvider);
  return AuthService(auth: auth);
});

final authStateNotifierProvider = NotifierProvider<AuthStateNotifier, AuthState>(
  () => AuthStateNotifier());