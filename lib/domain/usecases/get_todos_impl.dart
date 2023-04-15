import 'package:todo_app/domain/model/todos.dart';

import '../repository/todos.dart';
import 'get_todos.dart';

class GetTodosUseCaseImpl extends GetTodosUseCase {
  final TodosRepository todosRepository;

  GetTodosUseCaseImpl(this.todosRepository);
  @override
  Future<Todos> execute() => todosRepository.loadTodos();
}
