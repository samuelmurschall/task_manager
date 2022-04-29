import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:task_manager/hive_database.dart';
import 'package:task_manager/models/task_model.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final HiveDataBase hiveDataBase;
  TaskBloc({required this.hiveDataBase}) : super(TaskLoading()) {
    on<LoadTask>(_onLoadTask);
    on<UpdateTask>(_onUpdateTask);
    on<AddTask>(_onAddTask);
    on<DeleteTask>(_onDeleteTask);
    on<DeleteAllTasks>(_onDeleteAllTasks);
  }
  void _onLoadTask(
    LoadTask event,
    Emitter<TaskState> emit,
  ) async {
    Future<void>.delayed(const Duration(seconds: 1));
    Box box = await hiveDataBase.openBox();
    List<Task> tasks = hiveDataBase.getTasks(box);
    emit(TaskLoaded(tasks: tasks));
  }

  void _onUpdateTask(
    UpdateTask event,
    Emitter<TaskState> emit,
  ) async {
    Box box = await hiveDataBase.openBox();
    if (state is TaskLoaded) {
      await hiveDataBase.updateTask(box, event.task);
      emit(TaskLoaded(tasks: hiveDataBase.getTasks(box)));
    }
  }

  void _onAddTask(
    AddTask event,
    Emitter<TaskState> emit,
  ) async {
    Box box = await hiveDataBase.openBox();
    if (state is TaskLoaded) {
      await hiveDataBase.addTask(box, event.task);
      emit(TaskLoaded(tasks: hiveDataBase.getTasks(box)));
    }
  }

  void _onDeleteTask(
    DeleteTask event,
    Emitter<TaskState> emit,
  ) async {
    Box box = await hiveDataBase.openBox();
    if (state is TaskLoaded) {
      hiveDataBase.deleteTask(box, event.task);
      emit(TaskLoaded(tasks: hiveDataBase.getTasks(box)));
    }
  }

  void _onDeleteAllTasks(
    DeleteAllTasks event,
    Emitter<TaskState> emit,
  ) async {
    Box box = await hiveDataBase.openBox();
    if (state is TaskLoaded) {
      hiveDataBase.deleteAllTasks(box);
      emit(TaskLoaded(tasks: hiveDataBase.getTasks(box)));
    }
  }
}
