import 'package:azkar_app/view/todo_screen/model/toda_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TodoRepo {
  final SupabaseClient _client = Supabase.instance.client;

  // جلب المهام الخاصة بالمستخدم فقط
  Future<List<TodoModel>> fetchTodos(String uid) async {
    final response = await _client
        .from('todos')
        .select()
        .eq('user_id', uid)
        .order('task_date', ascending: false);
    return (response as List).map((json) => TodoModel.fromJson(json)).toList();
  }

  // إضافة مهمة جديدة مرتبطة بالمستخدم
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

  // تغيير حالة المهمة
  Future<void> toggleTodo(String id, bool isDone) async {
    await _client.from('todos').update({'is_completed': isDone}).eq('id', id);
  }
}
