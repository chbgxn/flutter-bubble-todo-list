import 'package:bubble_todo_list/core/utils/handle_conversion_tz_and_date_time.dart';
import 'package:bubble_todo_list/features/todo/models/todo.dart';

enum FilterMode {all, completed, incomplete}
enum SortMode {newestFirst, priorityHighToLow, none}

class TodoListState {
  final List<Todo> todoList;
  final bool isSuccessful;
  final bool isLoading;
  final bool hasError;
  final String? errorMsg;
  final FilterMode filter;
  final SortMode sort;

  const TodoListState({
    this.todoList = const [],
    this.isSuccessful = false,
    this.isLoading = false,
    this.hasError = false,
    this.errorMsg,
    this.filter = FilterMode.incomplete,
    this.sort = SortMode.newestFirst
  });

  TodoListState copyWith({
    List<Todo>? todoList,
    bool? isSuccessful,
    bool? isLoading,
    bool? hasError,
    String? errorMsg,
    FilterMode? filter,
    SortMode? sort
  }){
    return TodoListState(
      todoList: todoList ?? this.todoList, 
      isSuccessful: isSuccessful ?? this.isSuccessful,
      isLoading: isLoading ?? this.isLoading, 
      hasError: hasError ?? this.hasError,
      errorMsg: errorMsg ?? this.errorMsg,
      filter: filter ?? this.filter,
      sort: sort ?? this.sort
    );
  }

  List<Todo> get filteredList {
    final List<Todo> notDeletedList = todoList.where((todo) => !todo.isDeleted).toList();
    switch(filter){
      case FilterMode.incomplete:
        final List<Todo> incompleteList = notDeletedList.where(
          (todo) => !todo.isCompleted 
            && (todo.dueDate?.isAfter(HandleConversionTzAndDateTime.dateTimeToTzUtc(DateTime.now())) ?? true)
        ).toList();
        switch(sort){
          case SortMode.newestFirst:
            incompleteList.sort((a, b) => b.createdAt.compareTo(a.createdAt));
            return incompleteList;
          case SortMode.priorityHighToLow:
            incompleteList.sort((a, b) => b.priority.compareTo(a.priority));
            return incompleteList;
          case SortMode.none:
            return incompleteList;
        }
      
      case FilterMode.completed:
        final List<Todo> completedList = notDeletedList.where((todo) => todo.isCompleted).toList();
        completedList.sort((a, b) => b.updatedAt!.compareTo(a.updatedAt!));
        return completedList;

      case FilterMode.all:
        final List<Todo> allList = notDeletedList;
        allList.sort((a, b) => b.createdAt.compareTo(a.createdAt));
        return allList;
    }
  }

  List<Todo> get completedTodos{
    final list = todoList.where((todo) => todo.isCompleted && !todo.isDeleted).toList();
    list.sort((a, b) => b.updatedAt!.compareTo(a.updatedAt!));
    return list;
  }

  List<Todo> get deletedTodos{
    final list = todoList.where((todo) => todo.isDeleted).toList();
    list.sort((a,b) => b.updatedAt!.compareTo(a.updatedAt!));
    return list;
  } 

  List<Todo> get overdueTodos{
    final list = todoList.where(
      (todo) => !todo.isCompleted &&
        (todo.dueDate?.isBefore(
          HandleConversionTzAndDateTime.dateTimeToTzUtc(DateTime.now())
        ) ?? false)
    ).toList();
    list.sort((a,b) => b.updatedAt!.compareTo(a.updatedAt!));
    return list;
  } 
}