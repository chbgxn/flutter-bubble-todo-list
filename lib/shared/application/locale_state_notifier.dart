import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleStateNotifier extends StateNotifier<int> {
  final String uid;

  LocaleStateNotifier({required this.uid}) : super(0){
    _loadLocalePrefs();
  }
  
  Future<void> _loadLocalePrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final mode = prefs.getInt('${uid}_locale') ?? 0;
    state = mode;
  }

  Future<void> followSystem() async {
    state = 0;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('${uid}_locale', 0);
    }

  Future<void> toZh() async{
    state = 1;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('${uid}_locale', 1);
  }

  Future<void> toEn() async{
    state = 2;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('${uid}_locale', 2);
  }
}