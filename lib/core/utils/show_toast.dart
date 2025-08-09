import 'package:bubble_todo_list/core/themes/config/app_sizes.dart';
import 'package:flutter/material.dart';

class ShowToast {
  static OverlayEntry? _entry;

  static Future<void> show({
    required BuildContext context,
    required bool status,
    String? msg}
  ) async {
    _entry?.remove();
    _entry = OverlayEntry(
      builder: (_) => Positioned(
        top: AppSizes.screenHeight * 0.12,
        left: AppSizes.screenWidth * 0.3,
        child:Material(
          type: MaterialType.transparency,
          child: Container(
            height: AppSizes.screenHeight * 0.05,
            width: AppSizes.screenWidth * 0.4,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppSizes.radiusRegular),
              color: status ? Colors.green : Colors.red,
            ),
            child: Text(
              msg ?? (status ? '成功' : '失败'),
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white)
            ),
          ),
        )
      )
    );

    WidgetsBinding.instance.addPostFrameCallback((_){
      Overlay.of(context).insert(_entry!);
    });
    await Future.delayed(Duration(seconds: 3));
     _entry?.remove();
    _entry = null;
  }
}