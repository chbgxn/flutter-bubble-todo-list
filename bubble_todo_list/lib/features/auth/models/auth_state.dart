import 'package:firebase_auth/firebase_auth.dart';

class AuthState {
  final User? currentUser;
  final bool isLoading;
  final bool hasError;
  final String? errorMsg;

  AuthState({
    this.currentUser, 
    this.isLoading = false,
    this.hasError = false,
    this.errorMsg
  });

  AuthState copyWith({
    User? currentUser,
    bool? isLoading,
    bool? hasError,
    String? errorMsg
  }){
    return AuthState(
      currentUser: currentUser ?? this.currentUser, 
      isLoading: isLoading ?? this.isLoading, 
      hasError: hasError ?? this.hasError, 
      errorMsg: errorMsg ?? this.errorMsg
    );
  }
}