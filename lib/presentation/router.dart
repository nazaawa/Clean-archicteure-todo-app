import 'package:go_router/go_router.dart';

import 'views/home.dart';
import 'views/todos_edit.dart';
import 'views/todos_list.dart';

final router = GoRouter(
  initialLocation: '/todos',
  routes: [
    GoRoute(
      path: '/todos',
      builder: (context, state) => const TodosList(),
      routes: [
        GoRoute(
          path: "new",
          builder: (context, state) => const TodoEdit(),
        ),
        GoRoute(
          path: ":id",
          builder: (context, state) => TodoEdit(
            todoId: state.params['id'],
          ),
        )
      ],
    ),
  ],
);
