import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/model/todo.dart';
import '../../domain/model/todos.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/usecases/module.dart';
import '../views/todos_list.dart';

class TodosStateNotifier extends StateNotifier<Todos> {
  TodosStateNotifier(this.ref) : super(const Todos(values: [])) {
    loadTodos();
  }

  final Ref ref;
  late final getTodos = ref.read(getTodosProvider);

  Future<void> loadTodos() async {
    state = await getTodos.execute();
  }

  Future<void> save(Todo todo) async {
    await ref.read(saveTodoProvider).execute(todo);
    await loadTodos();
  }

  Future<Todo?> get(String id) async {
    await ref.read(getTodoProvider).execute(id);
  }

  Future<void> delete(String id) async {
    await ref.read(deleteTodoProvider).execute(id);
  }
}

final todosListState = StateNotifierProvider<TodosStateNotifier, Todos>(
  (ref) {
    return TodosStateNotifier(ref);
  },
);

final todosListModel = Provider<TodosStateNotifier>((ref) {
  return ref.watch(todosListState.notifier);
});
