import 'package:bubble_todo_list/shared/application/locale_state_notifier.dart';
import 'package:bubble_todo_list/shared/application/mode_state_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final modeStateProvider = StateNotifierProvider.autoDispose.family<ModeStateNotifier, int, String>(
  (ref, uid) => ModeStateNotifier(uid: uid)
);

final localeStateProvider = StateNotifierProvider.autoDispose.family<LocaleStateNotifier, int, String>(
  (ref, uid) => LocaleStateNotifier(uid: uid) ,
);