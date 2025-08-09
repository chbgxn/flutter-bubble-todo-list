import 'dart:async';

import 'package:bubble_todo_list/core/themes/config/app_sizes.dart';
import 'package:flutter/material.dart';

class LoadingOverlay {
  static OverlayEntry? _entry;
  static Timer? _timeOutTimer;

  static void show({
    required BuildContext context,
    Duration duration = const Duration(seconds: 10),
    VoidCallback? onTimeOut,
  }){
    remove();

    _timeOutTimer = Timer(duration, (){
      if(_entry != null){
        remove();
        if(onTimeOut != null) onTimeOut();
      }
    });

    _entry = OverlayEntry(
      builder: (_) => Stack(
        children: [
          ModalBarrier(
            dismissible: false,
            color: Colors.transparent,
          ),
          Positioned(
            top: AppSizes.screenHeight /2 - AppSizes.screenWidth * 0.2,
            left: AppSizes.screenWidth /2 - AppSizes.screenWidth * 0.2,
            child:Material(
              type: MaterialType.transparency,
              child: Container(
                height: AppSizes.screenWidth * 0.4,
                width: AppSizes.screenWidth * 0.4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppSizes.radiusRegular),
                  color: Colors.grey,
                ),
                alignment: Alignment.center,
                child: FractionallySizedBox(
                  heightFactor: 0.3,
                  widthFactor: 0.3,
                  child: CircularProgressIndicator(),
                )
              ),
            )
          )
        ],
      )
    );

    WidgetsBinding.instance.addPostFrameCallback((_){
      final overlay = Overlay.of(context);
      if(overlay.mounted){
        overlay.insert(_entry!);
      }
    });
    
  }

  static void remove() {
    _timeOutTimer?.cancel();
    _timeOutTimer = null;
    _entry?.remove();
    _entry = null;
  }
}