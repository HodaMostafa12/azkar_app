import 'package:azkar_app/view/todo_screen/view_model/todo_view_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../Authentication/utils/appbar.dart';
import '../Authentication/view_model/auth_viewModel.dart';
import 'dart:ui' as ui;

class TodaScreen extends StatelessWidget {
  const TodaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final authVM = Provider.of<AuthViewModel>(context);
    final todoVM = Provider.of<TodoViewModel>(context);

    // ✅ مش محتاج أبعت userId
    if (!todoVM.isLoading && todoVM.todos.isEmpty && authVM.user != null) {
      todoVM.loadTodos();
    }

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
            ? const Center(child: CircularProgressIndicator())
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
                  bool isToday = todo.taskDate.day == DateTime.now().day &&
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
                        ),
                      ),
                      trailing: Checkbox(
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
                final TextEditingController taskController =
                TextEditingController();
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  title: const Text("إضافة مهمة جديدة"),
                  content: TextField(
                    controller: taskController,
                    textDirection: ui.TextDirection.rtl,
                    textAlign: TextAlign.right,
                    decoration: const InputDecoration(
                      labelText: "اكتب المهمة",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text("إلغاء"),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        final task = taskController.text.trim();
                        if (task.isNotEmpty) {
                          await todoVM.addTask(
                            task,
                            DateTime.now(),
                          );
                          Navigator.of(context).pop();
                        }
                      },
                      child: const Text("إضافة"),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
