import 'package:bubble_todo_list/core/themes/config/app_sizes.dart';
import 'package:bubble_todo_list/features/auth/application/auth_providers.dart';
import 'package:bubble_todo_list/features/auth/presentation/screens/sign_in_screen.dart';
import 'package:bubble_todo_list/features/auth/presentation/widgets/email_input.dart';
import 'package:bubble_todo_list/features/auth/presentation/widgets/password_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignUpScreen extends ConsumerStatefulWidget{
  const SignUpScreen({super.key});

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  final _fromKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final pwdController = TextEditingController();
  final _emailFoucs = FocusNode();
  final _pwdFoucs = FocusNode();

  @override
  void dispose() {
    emailController.dispose();
    pwdController.dispose();
    _emailFoucs.dispose();
    _pwdFoucs.dispose();
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
                  Text('注册', style: Theme.of(context).textTheme.headlineLarge),
                  EmailInput(emailController: emailController),
                  PasswordInput(pwdController: pwdController),

                  OutlinedButton(
                    onPressed: () async {
                      if(_fromKey.currentState!.validate()){
                        await ref.read(authStateNotifierProvider.notifier).signUp(
                          email: emailController.text.trim(),
                          password: pwdController.text.trim(),
                        );
                        if(authState.currentUser != null){
                          debugPrint('已经登陆');
                        }
                      }
                    },
                    child: Text('注册', style: Theme.of(context).textTheme.headlineLarge)
                  ),

                  TextButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => SignInScreen())
                    ),
                    child: Text('已有账号？去登录', style: Theme.of(context).textTheme.bodyMedium),
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