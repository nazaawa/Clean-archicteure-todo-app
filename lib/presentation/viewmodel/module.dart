import '../../data/repository/module.dart';
import '../../domain/model/todos.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part "module.g.dart";

@riverpod
Future<Todos> getTodos(TodosListRef ref) async {
  final usecase = ref.watch(getTodosProvider);
  return await usecase.execute();
}
