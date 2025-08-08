import 'package:bubble_todo_list/core/utils/show_toast.dart';
import 'package:bubble_todo_list/core/utils/loading_overlay.dart';
import 'package:bubble_todo_list/features/auth/application/auth_providers.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void useAuthStateListener(BuildContext context, WidgetRef ref) {
  ref.listenManual(authStateNotifierProvider, (_, next) async {
    if (next.isLoading) {
      LoadingOverlay.show(context: context);
    } else {
      LoadingOverlay.remove();
    }
    if (next.hasError) {
      LoadingOverlay.remove();
      await ShowToast.show(context: context, msg: next.errorMsg, status: false);
    }
  });
}