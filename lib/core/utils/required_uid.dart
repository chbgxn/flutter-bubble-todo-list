import 'package:bubble_todo_list/core/utils/app_router.dart';
import 'package:bubble_todo_list/features/auth/application/auth_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

String? requiredUid(BuildContext context, WidgetRef ref) {
  final uid = ref.watch(authStateNotifierProvider).currentUser?.uid;
  if(uid == null){
    WidgetsBinding.instance.addPostFrameCallback((_){
      context.go(AppRouter.signIn);
    });
  }
  return uid;
}