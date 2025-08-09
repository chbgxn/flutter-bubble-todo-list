  import 'package:permission_handler/permission_handler.dart';

Future<bool> checkPermission() async {
    var notificationStatus = await Permission.notification.status;
    var scheduleStatus =  await Permission.scheduleExactAlarm.status;
    if(notificationStatus.isDenied){
      notificationStatus = await Permission.notification.request();
    }
    if(scheduleStatus.isDenied){
      scheduleStatus = await Permission.scheduleExactAlarm.request();
    }
    if(scheduleStatus.isPermanentlyDenied || notificationStatus.isPermanentlyDenied){
      await openAppSettings();
      return false;
    }
    return notificationStatus.isGranted && scheduleStatus.isGranted;
  }