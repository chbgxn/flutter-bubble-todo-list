import 'package:bubble_todo_list/core/utils/app_router.dart';
import 'package:bubble_todo_list/features/auth/application/auth_state_change_notifier.dart';
import 'package:bubble_todo_list/features/auth/application/auth_providers.dart';
import 'package:bubble_todo_list/features/todo/presentation/screens/deleted_screen.dart';
import 'package:bubble_todo_list/features/todo/presentation/todo_info_screen/todo_info_screen.dart';
import 'package:bubble_todo_list/features/todo/presentation/home_screen/home_screen.dart';
import 'package:bubble_todo_list/shared/screens/switch_locale_screen.dart';
import 'package:bubble_todo_list/shared/screens/switch_mode_screen.dart';
import 'package:bubble_todo_list/shared/screens/profile_screen.dart';
import 'package:bubble_todo_list/features/auth/presentation/screens/sign_in_screen.dart';
import 'package:bubble_todo_list/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:bubble_todo_list/shared/widgets/app_shell.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final routerProvider = Provider<GoRouter>((ref){
  final authState = ref.watch(authStateNotifierProvider);
  return GoRouter(
    initialLocation: AppRouter.home,
    routes: [
      ShellRoute(
        builder: (context, state, child) => AppShell(
          location: state.matchedLocation,
          child: child
        ),
        routes: [
          GoRoute(
            path: AppRouter.home,
            builder: (context, state) => const HomeScreen() 
          ),
          GoRoute(
            path: AppRouter.profile,
            builder: (_, state) => const ProfileScreen(),
          )
        ]
      ),
      GoRoute(
        path: AppRouter.signIn,
        builder: (_, state) => const SignInScreen(),
      ),
      GoRoute(
        path: AppRouter.signUp,
        builder: (_, state) => const SignUpScreen(),
      ),
      GoRoute(
        path: '${AppRouter.todoInfo}/:tid',
        builder: (_, state){
          final String tid = state.pathParameters['tid']!;
          return TodoInfoScreen(tid: tid);
        },
      ),
      GoRoute(
        path: AppRouter.switchMode,
        builder: (_, state) => const SwitchModeScreen(),
      ),
      GoRoute(
        path: AppRouter.switchLocale,
        builder: (_, state) => const SwitchLocaleScreen(),
      ),
      GoRoute(
        path: AppRouter.deletedTodoList,
        builder: (_, state) => const DeletedScreen(),
      )
    ],
    redirect: (context, state) {
      final isAuth = authState.currentUser != null;
       if(isAuth && state.matchedLocation == AppRouter.signIn){
        return AppRouter.home;
       }
       if(!isAuth && state.matchedLocation == AppRouter.home){
        return AppRouter.signIn;
       }
       return null;
    },
    refreshListenable: AuthStateChangeNotifier(ref: ref),
    debugLogDiagnostics: true
  );
});

