import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:state_notifier/state_notifier.dart';

class TaskState {
  final Map<int, String> tasks;

  TaskState({required this.tasks});

  TaskState copyWith({Map<int, String>? tasks}) {
    return TaskState(
      tasks: tasks ?? this.tasks,
    );
  }
}

class TaskNotifier extends StateNotifier<TaskState> {
  TaskNotifier() : super(TaskState(tasks: {}));
  List<String> getTasks() {
    return state.tasks.values.toList();
  }

  void setTask(int index, String task) {
    state = state.copyWith(
      tasks: {...state.tasks, index: task},
    );
  }

  List<int> getTaskIndexes() {
    return state.tasks.keys.toList();
  }
}

final taskNotifierProvider = StateNotifierProvider<TaskNotifier, TaskState>(
  (ref) => TaskNotifier(),
);
