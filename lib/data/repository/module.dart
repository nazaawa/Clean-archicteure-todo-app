import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/data/repository/todos_impl.dart';

import '../../domain/repository/todos.dart';
import '../source/module.dart';

final todosProvider = Provider.autoDispose<TodosRepository>((ref) {
  return TodosRepositoryImpl(ref.read(filesProvider));
});
