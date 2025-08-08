import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'todo.g.dart';

@HiveType(typeId: 0) // Hive类型ID，每个模型需要唯一
@JsonSerializable() 
class Todo {
  @HiveField(0)
  final String tid; //事项id: uid_时间戳

  @HiveField(1)
  final String uid; // owner: firebase的uid

  @HiveField(2)
  final String title; // 标题

  @HiveField(3)
  final String? description; // 描述（可选）

  @HiveField(4)
  final bool isCompleted; // 是否完成
  
  @HiveField(5)
  final DateTime createdAt; // 创建时间
  
  @HiveField(6)
  final DateTime? updatedAt; // 更新时间（可选）

  @HiveField(7)
  final DateTime? dueDate; // 截止日期（可选）
  
  @HiveField(8)
  final int priority; // 优先级（0-低，1-中，2-高）

  @HiveField(9)
  final bool isDeleted; //是否已删除
  
  @HiveField(10)
  final bool isSynced; // 是否已同步到服务器

  @HiveField(11)
  final int syncRetryCount; //重试次数

  @HiveField(12)
  final String? syncError; //firebase返回的错误信息

  Todo({
    required this.uid,
    required this.tid,
    required this.title,
    this.description,
    this.isCompleted = false,
    required this.createdAt,
    this.updatedAt,
    this.dueDate,
    this.priority = 1,
    this.isSynced = false,
    this.isDeleted = false,
    this.syncRetryCount = 0,
    this.syncError
  });

  Todo copyWith({
    String? uid,
    String? tid,
    String? title,
    String? description,
    bool? isCompleted,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? dueDate,
    int? priority,
    bool? isSynced,
    bool? isDeleted,
    int? syncRetryCount,
    String? syncError
  }) {
    return Todo(
      uid: uid ?? this.uid,
      tid: tid ?? this.tid,
      title: title ?? this.title,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      dueDate: dueDate ?? this.dueDate,
      priority: priority ?? this.priority,
      isSynced: isSynced ?? this.isSynced,
      isDeleted: isDeleted ?? this.isDeleted,
      syncRetryCount: syncRetryCount ?? this.syncRetryCount,
      syncError: syncError ?? this.syncError
    );
  }

   // 生成 fromJson 方法: JSON → Dart 对象
  factory Todo.fromJson(Map<String, dynamic> json) => _$TodoFromJson(json);

  // 生成 toJson 方法: Dart 对象 → JSON(通常是 Map<String, dynamic>)
  Map<String, dynamic> toJson() => _$TodoToJson(this);
}

// class Todo {
//   final String tid; //事项id: uid_时间戳
//   final String uid; // owner: firebase的uid
//   final String title; // 标题
//   final String? description; // 描述（可选）
//   final bool isCompleted; // 是否完成
//   final DateTime createdAt; // 创建时间
//   final DateTime? updatedAt; // 更新时间（可选）
//   final DateTime? dueDate; // 截止日期（可选）
//   final int priority; // 优先级（0-低，1-中，2-高）
//   final bool isDeleted; //是否已删除
//   final bool isSynced; // 是否已同步到服务器
//   final int syncRetryCount; //重试次数,需要，isSynced=false就重试
//   final String? syncError; //firebase返回的错误信息
// }