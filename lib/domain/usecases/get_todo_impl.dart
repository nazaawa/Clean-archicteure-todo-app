import 'package:todo_app/domain/model/todo.dart';
import 'package:todo_app/domain/model/todos.dart';

import '../repository/todos.dart';
import 'get_todo.dart';
import 'get_todos.dart';

class GetTodoUseCaseImpl extends GetTodoUseCase {
  final TodosRepository todosRepository;

  GetTodoUseCaseImpl(this.todosRepository);

  @override
  Future<Todo?> execute(String id) => todosRepository.getTodoById(id);
}
