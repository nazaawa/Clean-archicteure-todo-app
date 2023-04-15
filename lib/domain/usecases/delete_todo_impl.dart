import 'package:todo_app/domain/model/todo.dart';
import 'package:todo_app/domain/repository/todos.dart';

import 'delete_todo.dart';

class DeleteTodoUseCaseImpl extends DeleteTodoUseCase {
  final TodosRepository todosRepository;

  DeleteTodoUseCaseImpl(this.todosRepository);

  @override
  Future<void> execute(Todo todo) async {
    await todosRepository.deleteTodo(todo);
  }
}
