import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:task_manager/blocs/task/task_bloc.dart';
import 'package:task_manager/models/task_model.dart';
import 'package:task_manager/screens/edit_task_screen.dart';

class TaskToday extends StatefulWidget {
  const TaskToday({Key? key}) : super(key: key);

  @override
  State<TaskToday> createState() => _TaskTodayState();
}

class _TaskTodayState extends State<TaskToday> {
  int parseTime(String time) {
    var components = time.split(RegExp('[: ]'));
    if (components.length != 3) {
      throw FormatException('Time not in the expected format: $time');
    }
    var hours = int.parse(components[0]);
    var minutes = int.parse(components[1]);
    var period = components[2].toUpperCase();

    if (hours < 1 || hours > 12 || minutes < 0 || minutes > 59) {
      throw FormatException('Time not in the expected format: $time');
    }

    if (hours == 12) {
      hours = 0;
    }

    if (period == 'PM') {
      hours += 12;
    }

    return hours * 100 + minutes;
  }

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
                      ((task.deadlineDate ==
                          DateFormat('dd MMMM yyyy').format(DateTime.now()))))
                  .isEmpty
              ? Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Column(
                      children: [
                        Image.asset(
                            'assets/images/illustrations/completed.jpg'),
                        const SizedBox(height: 15),
                        const Text(
                          'You\'ve finished all tasks!',
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
                    task.sort((a, b) => parseTime(a['deadlineTime']
                        .compareTo(parseTime(b['deadlineTime']))));

                    print(task);
                    if ((task.done == false) &&
                        (task.deadlineDate ==
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
                                          /*  context
                                        .read<TaskBloc>()
                                        .add(DeleteAllTasks()); */
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
