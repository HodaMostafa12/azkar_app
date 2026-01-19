import 'package:azkar_app/view/todo_screen/view_model/todo_view_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../utils/appbar.dart';
import '../Authentication/view_model/auth_viewModel.dart';
import 'dart:ui' as ui;

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authVM = context.read<AuthViewModel>();
      final todoVM = context.read<TodoViewModel>();

      if (authVM.user != null) {
        todoVM.loadTodos();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final authVM = Provider.of<AuthViewModel>(context);
    final todoVM = Provider.of<TodoViewModel>(context);

    final groupedTodos = <String, List<dynamic>>{};
    for (var todo in todoVM.todos) {
      final dateKey = DateFormat('d-M-yyyy').format(todo.taskDate);
      groupedTodos.putIfAbsent(dateKey, () => []);
      groupedTodos[dateKey]!.add(todo);
    }
    return SafeArea(
      child: Scaffold(
        backgroundColor: colors.background,
        appBar: const CustomAppBar(
          title: "المهام اليومية",
          showBackButton: true,
        ),
        body: todoVM.isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : todoVM.todos.isEmpty
                ? const Center(
                    child: Text(
                      'ADD Tasks Here',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey,
                      ),
                    ),
                  )
                : ListView(
                    children: groupedTodos.entries.map((entry) {
                      final date = entry.key;
                      final tasks = entry.value;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            child: Text(
                              date,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          ...tasks.map<Widget>((todo) {
                            bool isToday = todo.taskDate.day ==
                                    DateTime.now().day &&
                                todo.taskDate.month == DateTime.now().month &&
                                todo.taskDate.year == DateTime.now().year;

                            return Card(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 4),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: ListTile(
                                title: Text(
                                  todo.title,
                                  style: TextStyle(
                                    decoration: todo.isComplated
                                        ? TextDecoration.lineThrough
                                        : TextDecoration.none,
                                    color: todo.isComplated
                                        ? colors.onSecondary.withOpacity(0.5)
                                        : colors.onSecondary,
                                    fontWeight: todo.isComplated
                                        ? FontWeight.w900 // أو w700
                                        : FontWeight.normal,
                                  ),
                                ),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AddEditTodoDialog(
                                                onSave: (task) async {
                                                  await todoVM.editTask( todo.id,task);
                                                },
                                                initialText: todo.title,
                                              );
                                            },
                                          );
                                        },
                                        icon: Icon(
                                          Icons.edit,
                                          color: colors.onSecondary,
                                        )),
                                    IconButton(
                                        onPressed: () {
                                          todoVM.deleteTask(todo.id);
                                        },
                                        icon: Icon(
                                          Icons.delete,
                                          color: colors.onSecondary,
                                        )),
                                    Checkbox(
                                      value: todo.isComplated,
                                      onChanged: isToday
                                          ? (val) {
                                              todoVM.toggleTodo(
                                                todo.id,
                                                val!,
                                                todo.taskDate,
                                              );
                                            }
                                          : null,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        ],
                      );
                    }).toList(),
                  ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: colors.error,
          child: const Icon(Icons.add),
          onPressed: () {
            if (authVM.user == null) return;
            showDialog(
              context: context,
              builder: (context) {
                return AddEditTodoDialog(
                  onSave: (task) async {
                    await todoVM.addTask(task, DateTime.now());
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
class AddEditTodoDialog extends StatelessWidget {
  final void Function(String task) onSave;
  final String? initialText; // لو موجود معناها Edit

  const AddEditTodoDialog({
    super.key,
    required this.onSave,
    this.initialText,
  });

  @override
  Widget build(BuildContext context) {
    final TextEditingController taskController =
    TextEditingController(text: initialText ?? '');
    final colors = Theme.of(context).colorScheme;

    return AlertDialog(
      backgroundColor: colors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      title: Text(
        initialText == null ? "إضافة مهمة جديدة" : "تعديل المهمة",
        style: TextStyle(
          color: colors.onSurface,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: TextField(
        controller: taskController,
        textDirection: ui.TextDirection.rtl,
        textAlign: TextAlign.right,
        style: TextStyle(color: colors.onSurface),
        decoration: InputDecoration(
          labelText: "اكتب المهمة",
          labelStyle: TextStyle(color: colors.onSurface.withOpacity(0.7)),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: colors.outline),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: colors.primary, width: 2),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            "إلغاء",
            style: TextStyle(color: colors.secondary),
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: colors.primary,
            foregroundColor: colors.onPrimary,
          ),
          onPressed: () {
            final task = taskController.text.trim();
            if (task.isNotEmpty) {
              onSave(task); // 🔹 هنا بنرسل المهمة للـ ViewModel
              Navigator.of(context).pop();
            }
          },
          child: Text(initialText == null ? "إضافة" : "حفظ"),
        ),
      ],
    );
  }
}
