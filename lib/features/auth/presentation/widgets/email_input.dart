import 'package:bubble_todo_list/core/themes/config/app_sizes.dart';
import 'package:flutter/material.dart';

class EmailInput extends StatelessWidget {
  final TextEditingController emailController;
  final FocusNode emailFoucs = FocusNode();
  EmailInput({super.key, required this.emailController});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: emailController,
      focusNode: emailFoucs,
      autovalidateMode:
          emailFoucs.hasFocus
              ? AutovalidateMode.onUserInteraction
              : AutovalidateMode.disabled,
      textInputAction: TextInputAction.next,
      // onFieldSubmitted: (value) => pwdFoucs.requestFocus(),
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.email, size: AppSizes.iconRegular),
        labelText: '邮箱',
        labelStyle: Theme.of(context).textTheme.bodyMedium,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusRegular),
        ),
      ),
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value == null || value.isEmpty) return '请输入邮箱';
        if (!RegExp(
          r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
        ).hasMatch(value)) {
          return '请输入有效的邮箱地址';
        }
        return null;
      },
    );
  }
}
