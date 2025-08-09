import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ModeStateNotifier extends StateNotifier<int> {
  final String uid;

  ModeStateNotifier({required this.uid}) : super(0){
    _loadModePrefs();
  }
  
  Future<void> _loadModePrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final mode = prefs.getInt('${uid}_mode') ?? 0;
    state = mode;
  }

  Future<void> followSystem() async {
    state = 0;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('${uid}_mode', 0);
    }

  Future<void> toLight() async{
    state = 1;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('${uid}_mode', 1);
  }

  Future<void> toDark() async{
    state = 2;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('${uid}_mode', 2);
  }
}