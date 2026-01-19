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

  String? get _currentUserId => Supabase.instance.client.auth.currentUser?.id;

  Future<void> loadTodos() async {
    if (_currentUserId == null) return;
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

  Future<void> addTask(String task, DateTime date) async {
    if (_currentUserId == null) return;
    try {
      final newTask = await _repo.addTodo(_currentUserId!, task, date);
      if (newTask != null) {
        _todos.insert(0, newTask);
        notifyListeners();
      }
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  Future<void> deleteTask(String id) async {
    if(_currentUserId == null ) return;

    try {
      await _repo.deleteTodo(id);
      _todos.removeWhere((todo) => todo.id == id);
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  Future<void> editTask(String id, String title) async{
    if(_currentUserId == null) return;
    try{
      await _repo.editTodo(id, title);
      final index = _todos.indexWhere((todo) => todo.id == id);
      if(index != -1){
        final updated = _todos[index];
        _todos[index] = TodoModel(
          id: updated.id,
          title: title,
          isComplated: updated.isComplated,
          taskDate: updated.taskDate,
          createdAt: updated.createdAt,
          userId: updated.userId,
        );
        notifyListeners();
      }
    }catch(e){
      _error = e.toString();
      notifyListeners();
    }
  }



  Future<void> toggleTodo(String id, bool isDone, DateTime taskDate) async {
    if (_currentUserId == null) return;

    if (taskDate.day != DateTime.now().day ||
        taskDate.month != DateTime.now().month ||
        taskDate.year != DateTime.now().year) {
      return;
    }

    try {
      await _repo.toggleTodo(id, isDone);
      final index = _todos.indexWhere((todo) => todo.id == id);
      if (index != -1) {
        final updated = _todos[index];
        _todos[index] = TodoModel(
          id: updated.id,
          title: updated.title,
          isComplated: isDone,
          taskDate: updated.taskDate,
          createdAt: updated.createdAt,
          userId: updated.userId,
        );
        notifyListeners();
      }
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }
}
