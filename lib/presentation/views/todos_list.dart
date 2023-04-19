import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/domain/model/todo.dart';

import '../../domain/model/todos.dart';
import '../viewmodel/module.dart';
import '../widgets/todo_tile.dart';

class TodosList extends ConsumerWidget {
  const TodosList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Todos todos = ref.watch(todosListState);
    final model = ref.read(todosListModel);
    final active = todos.active;
    final List<Todo> completed = todos.completed;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Todos'),
      ),
      body: Column(
        children: [
          Expanded(
            child: active.isEmpty
                ? const Center(
                    child: Text(
                      'No Todos',
                    ),
                  )
                : ListView.builder(
                    itemCount: todos.values.length,
                    itemBuilder: (context, index) {
                      final todo = todos.values[index];
                      return TodoTile(
                        todo: todo,
                        //  value: todo.completed,
                      );
                    },
                  ),
          ),
          if (completed.isNotEmpty)
            ExpansionTile(
              title: const Text("completed"),
              children: [for (final todo in completed) TodoTile(todo: todo)],
            )
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          context.push("/todos/new");
        },
        icon: const Icon(Icons.add),
        label: const Text("Add Todo"),
        tooltip: 'Add Todo',
      ),
    );
  }
}
