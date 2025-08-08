import 'package:bubble_todo_list/features/auth/application/auth_providers.dart';
import 'package:bubble_todo_list/features/auth/models/auth_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthStateChangeNotifier extends ChangeNotifier {
  final Ref ref;
  late final ProviderSubscription _sub;

  AuthStateChangeNotifier({required this.ref}) {
    _sub = ref.listen<AuthState>(
      authStateNotifierProvider,
      (_, __) => notifyListeners(),
    );
  }

  @override
  void dispose() {
    _sub.close();
    super.dispose();
  }
}
