import 'dart:async';
import 'dart:ffi';

import 'package:bubble_todo_list/features/auth/application/auth_providers.dart';
import 'package:bubble_todo_list/features/auth/models/auth_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthStateNotifier extends Notifier<AuthState> {
  final _control = StreamController<Void>.broadcast();

  Stream get refreshStream => _control.stream;

  @override
  AuthState build() {
    return AuthState(
      currentUser: ref.watch(authProvider).currentUser
    );
  }

  Future<void> signUp({required String email, required String password}) async {
    state = state.copyWith(isLoading: true);
    await Future.delayed(Duration(seconds: 5));
    try{
      await ref.watch(authServiceProvider).signUp(email: email, password: password);
      state = state.copyWith(
        currentUser: ref.watch(authProvider).currentUser,
        isLoading: false,
        hasError: false,
        errorMsg: null
      );
    }catch(e){
      state = state.copyWith(
        isLoading: false,
        hasError: true,
        errorMsg: e.toString()
      );
    }
  }

  Future<void> signIn({required String email, required String password}) async {
    state = state.copyWith(isLoading: true);
    try{
      await ref.watch(authServiceProvider).signIn(email: email, password: password);
      state = state.copyWith(
        currentUser: ref.watch(authProvider).currentUser,
        isLoading: false,
        hasError: false,
        errorMsg: null
      );
    }catch(e){
      state = state.copyWith(
        isLoading: false,
        hasError: true,
        errorMsg: e.toString()
      );
    }
  }

  Future<void> signOut() async{
    state = state.copyWith(isLoading: true);
    await Future.delayed(Duration(seconds: 5));
    try{
      await ref.watch(authServiceProvider).signOut();
      state = state.copyWith(
        currentUser: null,
        isLoading: false,
        hasError: false,
        errorMsg: null
      );
    }catch(e){
      state = state.copyWith(
        isLoading: false,
        hasError: true,
        errorMsg: e.toString()
      );
    }
  }
}