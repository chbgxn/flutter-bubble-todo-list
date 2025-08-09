import 'package:bubble_todo_list/core/themes/config/app_sizes.dart';
import 'package:bubble_todo_list/core/themes/app_theme.dart';
import 'package:bubble_todo_list/core/utils/required_uid.dart';
import 'package:bubble_todo_list/features/todo/application/todo_providers.dart';
import 'package:bubble_todo_list/firebase_options.dart';
import 'package:bubble_todo_list/features/todo/models/todo.dart';
import 'package:bubble_todo_list/shared/application/notification_providers.dart';
import 'package:bubble_todo_list/shared/application/router_provider.dart';
import 'package:bubble_todo_list/shared/application/setting_provider.dart';
import 'package:bubble_todo_list/shared/services/native_timezone.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tzdata;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter<Todo>(TodoAdapter());
  await Hive.openBox<Todo>('todos'); 
  // Hive.box('todos').clear();

  tzdata.initializeTimeZones();

  final timezone = await NativeTimezone.getLocalTimezone();
  final location = tz.getLocation(timezone);
  tz.setLocalLocation(location);

  final container = ProviderContainer();
  container.read(localNotificationsPluginProvider);

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    UncontrolledProviderScope(
      container: container,
      child: BubbleTodoList(),
    )
  );
}


class BubbleTodoList extends ConsumerWidget {
  const BubbleTodoList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AppSizes.init(context);
    
    final uid = requiredUid(context, ref);
    final router = ref.watch(routerProvider);

    if(uid != null){
       ref.listen(syncManagerProvider, (_,_){});
    }
    
    final int mode = uid == null 
      ? 0
      : ref.watch(modeStateProvider(uid));

    final int theLocale = uid == null
      ? 0
      : ref.watch(localeStateProvider(uid));
    
    return MaterialApp.router(
      routerConfig: router,

      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: mode == 0 
        ? ThemeMode.system 
        : (mode == 1 ? ThemeMode.light : ThemeMode.dark),

      
      locale: theLocale == 0
        ? null
        : (theLocale == 1 ? const Locale('zh') : const Locale('en')),
    ); 
  }
}