import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'task_model.g.dart';

@HiveType(typeId: 0)
class Task extends Equatable {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final int color;

  @HiveField(3)
  final String deadlineDate;

  @HiveField(4)
  final String deadlineTime;

  @HiveField(5)
  final String place;

  @HiveField(6)
  bool done;

  Task({
    required this.id,
    required this.name,
    required this.color,
    required this.deadlineDate,
    required this.deadlineTime,
    required this.place,
    required this.done,
  });

  Task copyWidth({
    String? id,
    String? name,
    int? color,
    String? deadlineDate,
    String? deadlineTime,
    String? place,
    bool? done,
  }) {
    return Task(
      id: id ?? this.id,
      name: name ?? this.name,
      color: color ?? this.color,
      deadlineDate: deadlineDate ?? this.deadlineDate,
      deadlineTime: deadlineTime ?? this.deadlineTime,
      place: place ?? this.place,
      done: done ?? this.done,
    );
  }

  @override
  List<Object> get props {
    return [
      id,
      name,
      color,
      deadlineDate,
      deadlineTime,
      place,
      done,
    ];
  }

  void sort(Function(dynamic a, dynamic b) param0) {}
}
