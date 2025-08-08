import 'package:bubble_todo_list/core/themes/config/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UpdateDateButton extends ConsumerWidget {
  final VoidCallback onTap;
  final String title;
  final Icon icon;
  const UpdateDateButton({
    super.key,
    required this.onTap,
    required this.title,
    required this.icon
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Row(
          spacing: AppSizes.radiusRegular,
          children: [
            icon,
            Text(title, style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }
}
