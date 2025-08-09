import 'package:bubble_todo_list/core/themes/config/app_sizes.dart';
import 'package:flutter/material.dart';

class PasswordInput extends StatelessWidget {
  final TextEditingController pwdController;
  final FocusNode pwdFoucs = FocusNode();
  PasswordInput({super.key, required this.pwdController});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: pwdController,
      focusNode: pwdFoucs,
      autovalidateMode:
          pwdFoucs.hasFocus
              ? AutovalidateMode.onUserInteraction
              : AutovalidateMode.disabled,
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.lock),
        labelText: '密码',
        labelStyle: Theme.of(context).textTheme.bodyMedium,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusRegular),
        ),
      ),
      obscureText: true,
      validator: (value) {
        if (value == null || value.isEmpty) return '请输入密码';
        if (value.length < 6) return '密码长度至少为6位';
        return null;
      },
    );
  }
}