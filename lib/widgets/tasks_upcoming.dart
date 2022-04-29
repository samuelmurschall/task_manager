import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:task_manager/blocs/task/task_bloc.dart';
import 'package:task_manager/models/task_model.dart';
import 'package:task_manager/screens/edit_task_screen.dart';

class TaskUpComing extends StatefulWidget {
  const TaskUpComing({Key? key}) : super(key: key);

  @override
  State<TaskUpComing> createState() => _TaskUpComingState();
}

class _TaskUpComingState extends State<TaskUpComing> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskBloc, TaskState>(
      builder: (context, state) {
        if (state is TaskLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is TaskLoaded) {
          return state.tasks
                  .where((task) =>
                      (task.done == false) &&
                      ((task.deadlineDate !=
                          DateFormat('dd MMMM yyyy').format(DateTime.now()))))
                  .isEmpty
              ? Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 46.5),
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/images/illustrations/cheer_up.jpg',
                          width: MediaQuery.of(context).size.width - 25,
                        ),
                        const SizedBox(height: 15),
                        const Text(
                          'No further task are assigned',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : ListView.builder(
                  itemCount: state.tasks.length,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    Task task = state.tasks[index];
                    if ((task.done == false) &&
                        (task.deadlineDate !=
                            DateFormat('dd MMMM yyyy')
                                .format(DateTime.now()))) {
                      return Padding(
                        padding: const EdgeInsets.only(
                            left: 16, right: 16, bottom: 15),
                        child: Container(
                          height: 190,
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                          decoration: BoxDecoration(
                            color: Color(task.color),
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 8),
                                        child: Container(
                                          padding: const EdgeInsets.only(
                                              left: 8,
                                              top: 4,
                                              bottom: 4,
                                              right: 8),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.black
                                                    .withOpacity(0.25)),
                                            borderRadius:
                                                BorderRadius.circular(50),
                                          ),
                                          child: const Text(
                                            'School',
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 8.0),
                                        child: Container(
                                          padding: const EdgeInsets.only(
                                              left: 8,
                                              top: 4,
                                              bottom: 4,
                                              right: 8),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.black
                                                    .withOpacity(0.25)),
                                            borderRadius:
                                                BorderRadius.circular(50),
                                          ),
                                          child: const Text('Everyday'),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      EditTaskScreen(
                                                          task: task)));
                                        },
                                        child: Image.asset(
                                          'assets/images/icons/bxs-message-square-edit.png',
                                          scale: 2.25,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 17.5),
                              Row(
                                children: [
                                  Text(
                                    task.name,
                                    style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 22.5),
                              Row(
                                children: [
                                  Image.asset(
                                    'assets/images/icons/calendar-alt.png',
                                    scale: 3.75,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 7.5),
                                    child: Text(
                                      task.deadlineDate,
                                      style: const TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 5),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Image.asset(
                                        'assets/images/icons/clock-circle.png',
                                        scale: 3.75,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 7.5),
                                        child: Text(
                                          task.deadlineTime,
                                          style: const TextStyle(
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            task.done = true;
                                          });
                                        },
                                        child: Container(
                                          height: 30,
                                          width: 30,
                                          decoration: BoxDecoration(
                                            color: task.done
                                                ? Colors.black
                                                : Colors.transparent,
                                            border: Border.all(
                                                color: Colors.black,
                                                width: 2.5),
                                            borderRadius:
                                                BorderRadius.circular(50),
                                          ),
                                          child: task.done
                                              ? Image.asset(
                                                  'assets/images/icons/tick.png',
                                                  scale: 4.75,
                                                  color: Colors.white,
                                                )
                                              : null,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                );
        } else {
          return const Text('Something went wrong');
        }
      },
    );
  }
}
