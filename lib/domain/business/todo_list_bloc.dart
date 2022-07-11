import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:todo_list_project/data/model/todo_info.dart';

import '../repository/todo_repository.dart';
import 'tab_bar_bloc.dart';

abstract class TodoListEvent {}

class TodoListLoading extends TodoListEvent {
  @override
  String toString() {
    return "Event TodoListLoading";
  }
}

class TodoListInserted extends TodoListEvent {
  final TodoInfo todoInfo;

  TodoListInserted({required this.todoInfo});

  @override
  String toString() {
    return "Event TodoListInserted: $todoInfo";
  }
}

class TodoListRemoved extends TodoListEvent {
  final int id;

  TodoListRemoved({required this.id});

  @override
  String toString() {
    return "Event TodoListRemoved: $id";
  }
}

class TodoListEdited extends TodoListEvent {
  final TodoInfo todoInfo;

  TodoListEdited({required this.todoInfo});

  @override
  String toString() {
    return "Event TodoListEdited: $todoInfo";
  }
}

class TodoListLoaded extends TodoListEvent {
  final List<TodoInfo> todos;

  TodoListLoaded({required this.todos});

  @override
  String toString() {
    return "Event TodoListLoaded: ${todos.map((e) => e.toString())}";
  }
}

class TodoListNotifyError extends TodoListEvent {
  @override
  String toString() {
    return "Event TodoListNotifyError";
  }
}

class TodoListErrorConfirmed extends TodoListEvent {
  @override
  String toString() {
    return "Event TodoListErrorConfirmed";
  }
}

@immutable
class TodoListState {
  final List<TodoInfo> todos;
  final bool isLoading;
  final bool isError;

  const TodoListState(
      {this.todos = const [], this.isLoading = false, this.isError = false});

  TodoListState copyWith(
      {List<TodoInfo>? todos, bool? isLoading, bool? isError}) {
    return TodoListState(
        todos: todos ?? this.todos,
        isLoading: isLoading ?? this.isLoading,
        isError: isError ?? this.isError);
  }

  @override
  String toString() {
    return "TodoListState(todos: ${todos.map((e) => e.toString())}, isLoading: $isLoading, isError: $isError)";
  }
}

class TodoListBloc extends Bloc<TodoListEvent, TodoListState> {
  TodoRepository todoRepository;
  TabBarCubit tabBarCubit;
  StreamSubscription? tabBarEventListener;

  TodoListBloc({required this.todoRepository, required this.tabBarCubit})
      : super(const TodoListState(isLoading: true)) {
    on<TodoListLoading>((event, emit) {
      final newState = state.copyWith(isLoading: false);
      emit(newState);
      _getTodos();
    });
    on<TodoListInserted>((event, emit) {
      _insertTodo(event.todoInfo);
    });
    on<TodoListRemoved>((event, emit) {
      _deleteTodo(event.id);
    });
    on<TodoListEdited>((event, emit) {
      _editTodo(event.todoInfo);
    });
    on<TodoListLoaded>((event, emit) {
      emit(
          state.copyWith(todos: event.todos, isLoading: false, isError: false));
    });
    on<TodoListNotifyError>((event, emit) {
      emit(state.copyWith(
        isError: true,
      ));
    });
    on<TodoListErrorConfirmed>((event, emit) {
      emit(state.copyWith(isError: false));
    });
    _loadTodos();
    addTabBarEventListener();
  }

  @override
  void onEvent(TodoListEvent event) {
    super.onEvent(event);
    if (kDebugMode) {
      print(event);
    }
  }

  @override
  void onChange(Change<TodoListState> change) {
    super.onChange(change);
    if (kDebugMode) {
      print(change);
    }
  }

  @override
  void onTransition(Transition<TodoListEvent, TodoListState> transition) {
    super.onTransition(transition);
    if (kDebugMode) {
      print(transition);
    }
  }

  void _insertTodo(TodoInfo todoInfo) {
    final isSuccess = todoRepository.insert(todoInfo);
    if (isSuccess) {
      if (tabBarCubit.state.tabOption == TabOption.complete) {
        tabBarCubit.emit(SwitchTabEvent(option: TabOption.incomplete));
      }
      _loadTodos();
    } else {
      handleError();
    }
  }

  void _deleteTodo(int id) {
    final isSuccess = todoRepository.remove(id);
    if (isSuccess) {
      _loadTodos();
    } else {
      handleError();
    }
  }

  void _editTodo(TodoInfo todoInfo) {
    bool isSuccess = todoRepository.edit(todoInfo);
    if (isSuccess) {
      _loadTodos();
    } else {
      handleError();
    }
  }

  void _loadTodos() {
    add(TodoListLoading());
  }

  void _getTodos() async {
    todoRepository.fetchTodoInfo().then((value) {
      final List<TodoInfo> listTodos;
      switch (tabBarCubit.state.tabOption) {
        case TabOption.complete:
          {
            listTodos = value.where((element) => element.isChecked).toList();
            break;
          }
        case TabOption.incomplete:
          {
            listTodos = value.where((element) => !element.isChecked).toList();
            break;
          }
        default:
          {
            listTodos = value;
            break;
          }
      }
      add(TodoListLoaded(todos: listTodos));
    });
  }

  void addTabBarEventListener() {
    tabBarEventListener = tabBarCubit.stream.listen((event) {
      _loadTodos();
    });
  }

  void dispose() {
    tabBarEventListener?.cancel();
    tabBarCubit.close();
    close();
  }

  void handleError() {
    add(TodoListNotifyError());
  }
}
