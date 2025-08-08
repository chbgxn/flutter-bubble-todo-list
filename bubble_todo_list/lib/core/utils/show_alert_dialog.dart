import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

Future<void> showAlertDialog({
  required BuildContext context, 
  required String title,
  required void Function(BuildContext context) onPressed
  }) async{
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title, style: Theme.of(context).textTheme.bodyMedium),
      content: Text('待您确认后可执行', style: Theme.of(context).textTheme.bodyMedium),
      actions: [
        TextButton(
          onPressed: () => context.pop(), 
          child: Text('取消', style: Theme.of(context).textTheme.bodyMedium)
        ),
        TextButton(
          onPressed: () => onPressed(context), 
          child: Text('确定', style: Theme.of(context).textTheme.bodyMedium)
        )
      ],
    )
  );
}