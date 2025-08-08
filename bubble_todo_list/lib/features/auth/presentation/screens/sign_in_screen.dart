import 'package:bubble_todo_list/core/utils/app_router.dart';
import 'package:bubble_todo_list/core/themes/config/app_sizes.dart';
import 'package:bubble_todo_list/core/utils/use_auth_state_listener.dart';
import 'package:bubble_todo_list/features/auth/application/auth_providers.dart';
import 'package:bubble_todo_list/features/auth/presentation/widgets/email_input.dart';
import 'package:bubble_todo_list/features/auth/presentation/widgets/password_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SignInScreen extends ConsumerStatefulWidget{
  const SignInScreen({super.key});

  @override
  ConsumerState<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen> {
  final _fromKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _pwdController = TextEditingController();

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
  void dispose() {
    _emailController.dispose();
    _pwdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authStateNotifierProvider);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.all(AppSizes.paddingRegular),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: AppSizes.screenHeight * 0.2,
            ),
            Form(
              key: _fromKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                spacing: AppSizes.paddingRegular,
                children: [
                  Text(
                    '登录',
                    style: Theme.of(context).textTheme.headlineLarge
                  ),
                  EmailInput(emailController: _emailController),
                  PasswordInput(pwdController: _pwdController),

                  OutlinedButton(
                    onPressed: () async {
                      if(_fromKey.currentState!.validate()){
                        await ref.read(authStateNotifierProvider.notifier).signIn(
                          email: _emailController.text.trim(),
                          password: _pwdController.text.trim(),
                        );
                        if(authState.currentUser != null){  
                          // LoadingOverlay.remove();
                          // ErrorOverlay.remove();
                          debugPrint('已经登陆');
                        }
                      }
                    },
                    child: Text('登录', style: Theme.of(context).textTheme.headlineLarge)
                  ),
                  TextButton(
                    onPressed: () => context.go(AppRouter.signUp),
                    child: Text(
                      '没有账号？去注册',
                      style: Theme.of(context).textTheme.bodyMedium
                    ),
                  ),
                ],
              ),
            ),
          ],
        )
      )
    );
  }
}