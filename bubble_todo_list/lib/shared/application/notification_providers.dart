import 'package:bubble_todo_list/shared/services/notification_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final localNotificationsPluginProvider = Provider<FlutterLocalNotificationsPlugin>((ref){
    final FlutterLocalNotificationsPlugin plugin = FlutterLocalNotificationsPlugin();
     
    const AndroidInitializationSettings initializationSettingsAndroid  
      = AndroidInitializationSettings('@mipmap/ic_launcher');


    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid, 
    );

    plugin.initialize(initializationSettings);

    return plugin;
});

final notificationServiceProvider = Provider.family.autoDispose<NotificationService,String>(
  (ref, uid){
    final plugin = ref.watch(localNotificationsPluginProvider);
    return NotificationService(plugin: plugin, uid: uid);
  } 
);