import 'package:bubble_todo_list/core/themes/config/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingTile extends ConsumerWidget {
  final String title;
  final VoidCallback tap;
  const SettingTile({super.key, required this.title, required this.tap});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Expanded(
      flex: 1,
      child: InkWell(
        onTap: tap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: Theme.of(context).textTheme.bodyMedium), 
            Icon(Icons.keyboard_arrow_right, size: AppSizes.iconRegular,)
          ],
        ),
      )
    );
  }
}
