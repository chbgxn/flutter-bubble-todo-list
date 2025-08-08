import 'package:bubble_todo_list/core/themes/config/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OperationTile extends ConsumerWidget {
  final String title;
  final int result;
  final VoidCallback tap;
  final int index;

  const OperationTile({
    super.key,
    required this.title,
    required this.result,
    required this.tap,
    required this.index
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Expanded(
      flex: 1,
      child: InkWell(
        onTap: tap,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSizes.paddingRegular),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.bodyMedium
              ),
              result == index 
                ? Icon(Icons.check, size: AppSizes.iconRegular) 
                : SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}
