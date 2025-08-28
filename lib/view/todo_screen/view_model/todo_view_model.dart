import 'package:azkar_app/view/todo_screen/model/repository/todo_repostory.dart';
import 'package:azkar_app/view/todo_screen/model/toda_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TodoViewModel extends ChangeNotifier {
  final TodoRepo _repo = TodoRepo();

  List<TodoModel> _todos = [];
  bool _loading = false;
  String? _error;

  List<TodoModel> get todos => _todos;
  bool get isLoading => _loading;
  String? get error => _error;

  /// 📌 نجيب الـ userId من Supabase مباشرة
  String? get _currentUserId =>
      Supabase.instance.client.auth.currentUser?.id;

  // جلب المهام الخاصة بالمستخدم الحالي فقط
  Future<void> loadTodos() async {
    if (_currentUserId == null) return; // المستخدم مش لوج إن
    _loading = true;
    notifyListeners();
    try {
      _todos = await _repo.fetchTodos(_currentUserId!);
    } catch (e) {
      _error = e.toString();
    }
    _loading = false;
    notifyListeners();
  }

  // إضافة مهمة جديدة للمستخدم الحالي
  Future<void> addTask(String task, DateTime date) async {
    if (_currentUserId == null) return; // المستخدم مش لوج إن
    try {
      final newTask = await _repo.addTodo(_currentUserId!, task, date);
      if (newTask != null) {
        _todos.insert(0, newTask); // إضافة المهمة فورًا في القائمة
        notifyListeners();
      }
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  // تغيير حالة المهمة الخاصة بالمستخدم الحالي
  Future<void> toggleTodo(
      String id, bool isDone, DateTime taskDate) async {
    if (_currentUserId == null) return; // المستخدم مش لوج إن

    // السماح بتعديل المهام اليوم فقط
    if (taskDate.day != DateTime.now().day ||
        taskDate.month != DateTime.now().month ||
        taskDate.year != DateTime.now().year) {
      return;
    }

    try {
      await _repo.toggleTodo(id, isDone);
      // تحديث المهمة محليًا بدل إعادة تحميل كل المهام
      final index = _todos.indexWhere((todo) => todo.id == id);
      if (index != -1) {
        _todos[index] = TodoModel(
          id: _todos[index].id,
          title: _todos[index].title,
          isComplated: isDone,
          taskDate: _todos[index].taskDate,
          createdAt: _todos[index].createdAt,
        );
        notifyListeners();
      }
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }
}
