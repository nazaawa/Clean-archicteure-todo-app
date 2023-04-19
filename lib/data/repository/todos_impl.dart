import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:todo_app/domain/model/todo.dart';

import '../../domain/model/todos.dart';
import '../../domain/repository/todos.dart';
import '../source/files.dart';

class TodosRepositoryImpl extends TodosRepository {
  final Files files;

  TodosRepositoryImpl(this.files);
  late final String path = 'todos.json';
  @override
  Future<void> deleteAllTodos(Todo todo) async {
    await files.delete(path);
  }

  @override
  Future<void> deleteTodo(String id) async {
    final todos = await loadTodos();

    final newTodos = todos.values.where((element) => element.id != id).toList();

    // save the new list
    await files.write(
      path,
      jsonEncode(
        Todos(values: newTodos).toJson(),
      ),
    );
  }

  @override
  Future<Todo?> getTodoById(String id) async {
    final todos = await loadTodos();

    return todos.values.firstWhereOrNull((element) => element.id == id);
  }

  @override
  Future<Todos> loadTodos() async {
    final content = await files.read(path);
    if (content == null) return const Todos(values: []);
    return Todos.fromJson(jsonDecode(content));
  }

  @override
  Future<void> saveTodo(Todo todo) async {
    final todos = await loadTodos();

//Edit the todo if it exists
    final existing =
        todos.values.firstWhereOrNull((element) => element.id == todo.id);
    if (existing != null) {
      final newTodo = existing.copyWith(
        title: todo.title,
        description: todo.description,
        completed: todo.completed,
      );
      final newTodos =
          todos.values.map((e) => e.id == todo.id ? newTodo : e).toList();
      await files.write(
        path,
        jsonEncode(
          Todos(values: newTodos).toJson(),
        ),
      );
      return;
    } else {
      final newTodos = [...todos.values, todo];
      await files.write(
        path,
        jsonEncode(
          Todos(values: newTodos).toJson(),
        ),
      );
    }

    // save the new list
  }
}
