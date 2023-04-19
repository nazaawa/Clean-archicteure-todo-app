import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shortid/shortid.dart';
import 'package:todo_app/presentation/widgets/extensons.dart';

import '../../domain/model/todo.dart';
import '../viewmodel/module.dart';

class TodoEdit extends ConsumerStatefulWidget {
  final String? todoId;
  const TodoEdit({
    super.key,
    this.todoId,
  });

  @override
  ConsumerState<TodoEdit> createState() => _TodoEditState();
}

class _TodoEditState extends ConsumerState<TodoEdit> {
  final title = TextEditingController();
  final description = TextEditingController();
  bool isCompleted = false;
  final _formKey = GlobalKey<FormState>();
  late final model = ref.read(todosListModel);
  bool edited = false;

  void change() {
    if (mounted) {
      setState(() {
        edited = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    title.addListener(change);
    description.addListener(change);
    if (widget.todoId != null) {
      model.get(widget.todoId!).then(
            (value) => {
              if (value != null)
                {
                  title.text = value.title,
                  description.text = value.description ?? "",
                  isCompleted = value.completed,
                  if (mounted)
                    {
                      setState(() {
                        isCompleted = value.completed;
                      })
                    }
                }
            },
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.todoId != null
            ? const Text('Edit Todo')
            : const Text('New Todo'),
        actions: [
          //Delete Todo
          if (widget.todoId != null)
            IconButton(
              onPressed: () {
                final confirmed = showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Delete Todo?'),
                        content: const Text('Do you want to delete this Todo?'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(false);
                            },
                            child: const Text('No'),
                          ),
                          TextButton(
                            style: TextButton.styleFrom(
                              foregroundColor:
                                  Theme.of(context).colorScheme.error,
                            ),
                            onPressed: () {
                              Navigator.of(context).pop(true);
                            },
                            child: const Text(
                              'Yes',
                            ),
                          )
                        ],
                      );
                    });
                if (confirmed == true) {
                  model.delete(widget.todoId!);
                  context.go('/');
                }
              },
              icon: const Icon(Icons.delete),
            )
        ],
      ),
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            onWillPop: () async {
              if (edited) {
                final confirmed = await showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Discard changes?'),
                    content: const Text('Do you want to discard changes?'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        },
                        child: const Text('No'),
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          foregroundColor: Theme.of(context).colorScheme.error,
                        ),
                        onPressed: () {
                          Navigator.of(context).pop(true);
                        },
                        child: const Text(
                          'Yes',
                        ),
                      )
                    ],
                  ),
                );
                if (confirmed == true) return true;
                return false;
              }
              return true;
            },
            child: Column(
              children: [
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a title';
                    }
                    return null;
                  },
                  controller: title,
                  decoration: const InputDecoration(
                    hintText: 'Title',
                  ),
                ),
                TextFormField(
                  controller: description,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a description';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    hintText: 'Description',
                  ),
                ),
                CheckboxListTile(
                  title: const Text('Completed'),
                  value: isCompleted,
                  onChanged: (value) {
                    if (mounted) {
                      setState(() {
                        edited = true;
                      });
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.add),
        label: const Text("Add Todo"),
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            _formKey.currentState!.save();
            final newTodo = Todo(
              title: title.text,
              description: description.text,
              completed: isCompleted,
              id: widget.todoId ?? shortid.generate(),
            );
            final messager = ScaffoldMessenger.of(context);
            final router = GoRouter.of(context);
            await model.save(newTodo);
            await model.loadTodos();
            if (router.canPop()) {
              router.pop();
            }
            messager.toast('Todo added');
          }
        },
      ),
    );
  }
}
