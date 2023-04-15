import 'package:todo_app/domain/model/todo.dart';
import 'package:todo_app/domain/model/todos.dart';
import 'package:todo_app/domain/usecases/save_todo.dart';

import '../repository/todos.dart';
import 'get_todo.dart';
import 'get_todos.dart';

class SaveTodoUseCaseImpl extends SaveTodoUseCase {
  final TodosRepository todosRepository;

  SaveTodoUseCaseImpl(this.todosRepository);

  @override
  Future<void> execute(Todo todo) async => await todosRepository.saveTodo(todo);
}
