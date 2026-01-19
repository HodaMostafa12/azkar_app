import 'package:azkar_app/view/todo_screen/model/toda_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TodoRepo {
  final SupabaseClient _client = Supabase.instance.client;

  Future<List<TodoModel>> fetchTodos(String uid) async {
    final response = await _client
        .from('todos')
        .select()
        .eq('user_id', uid)
        .order('task_date', ascending: false);

    return (response as List)
        .map((json) => TodoModel.fromJson(json))
        .toList();
  }

  Future<TodoModel?> addTodo(String uId, String task, DateTime date) async {
    final response = await _client.from('todos').insert({
      'user_id': uId,
      'title': task,
      'task_date': date.toIso8601String(),
      'is_completed': false,
    }).select();

    if (response.isNotEmpty) {
      return TodoModel.fromJson(response.first);
    }
    return null;
  }

  Future<void> deleteTodo(String id) async {
    await _client
        .from('todos')
        .delete()
        .eq('id', id);
  }


  Future<void> editTodo(String id, String title) async {
    await _client.from('todos')
        .update({'title': title})
        .eq('id', id);
  }

  Future<void> toggleTodo(String id, bool isDone) async {
    await _client
        .from('todos')
        .update({'is_completed': isDone})
        .eq('id', id);
  }
}
