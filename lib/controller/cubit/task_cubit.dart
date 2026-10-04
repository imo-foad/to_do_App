import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:to_do/models/task_model.dart';

part 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  TaskCubit() : super(TaskInitial());

  addTask(TaskModel model) {
    emit(UpdateTask(List.from(state.tasksList)..add(model)));
  }

  removeTask(int id) {
    final List<TaskModel> newList = state.tasksList
        .where((task) => task.id != id)
        .toList();
    emit(UpdateTask(newList));
  }

  // ignore: strict_top_level_inference
  toggleTask(int id) {
    final List<TaskModel> newList = state.tasksList.map((task) {
      // ignore: unrelated_type_equality_checks
      return task.id == id
          ? task.copyWith(isCompleted: !task.isCompleted)
          : task;
    }).toList();
    emit(UpdateTask(newList));
  }
}
