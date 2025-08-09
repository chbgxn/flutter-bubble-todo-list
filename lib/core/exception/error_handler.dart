import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';

String catchErrorHandler(Object e){
  if(e is FirebaseException){
    return '服务器发生错误';
  }
  if(e is SocketException){
    return '网络错误';
  }
  return '发生错误';
}
