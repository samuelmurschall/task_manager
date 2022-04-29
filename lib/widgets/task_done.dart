import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/blocs/task/task_bloc.dart';
import 'package:task_manager/models/task_model.dart';

class TaskDone extends StatefulWidget {
  const TaskDone({Key? key}) : super(key: key);

  @override
  State<TaskDone> createState() => _TaskDoneState();
}

class _TaskDoneState extends State<TaskDone> {
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
          return state.tasks.where((task) => task.done == true).isEmpty
              ? Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: Column(
                      children: [
                        Image.asset(
                            'assets/images/illustrations/attention.jpg'),
                        const SizedBox(height: 15),
                        const Text(
                          'Hadn\'t you tasks today?! ',
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
                    if (task.done == true) {
                      return Padding(
                        padding: const EdgeInsets.only(
                            left: 16, right: 16, bottom: 15),
                        child: Container(
                          height: 112.5,
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
                                          setState(() {
                                            task.done = !task.done;
                                            context
                                                .read<TaskBloc>()
                                                .add(DeleteAllTasks());
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
                              const SizedBox(height: 15),
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
                              //const SizedBox(height: 22.5),
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
