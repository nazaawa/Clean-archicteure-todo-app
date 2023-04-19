import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../domain/model/todo.dart';
import '../viewmodel/module.dart';

class TodoTile extends ConsumerWidget {
  final Todo todo;

  const TodoTile({super.key, required this.todo});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      title: Text(todo.title),
      onTap: () {
        context.push('/todos/${todo.id}');
      },
      subtitle: todo.description != null && todo.description!.isNotEmpty
          ? Text(todo.description!)
          : null,
      trailing: Checkbox(
        value: todo.completed,
        onChanged: (value) async {
          if (value == null) return;
          final newTodo = todo.copyWith(completed: value);
          ref.watch(todosListModel).save(newTodo);
        },
      ),
    );
  }
}
