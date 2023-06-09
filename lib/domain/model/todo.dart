// This file is "main.dart"
import 'package:freezed_annotation/freezed_annotation.dart';

// required: associates our `main.dart` with the code generated by Freezed
part 'todo.freezed.dart';
// optional: Since our Person class is serializable, we must add this line.
// But if Person was not serializable, we could skip it.
part 'todo.g.dart';

@freezed
class Todo with _$Todo {
  const factory Todo({
    required String id,
    required String title,
    String? description,
    @Default(false) bool completed,
  }) = _Todo;


  factory Todo.fromJson(Map<String, Object?> json) => _$TodoFromJson(json);
}
