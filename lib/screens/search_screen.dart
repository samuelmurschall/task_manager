import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/blocs/task/task_bloc.dart';
import 'package:task_manager/models/task_model.dart';
import 'package:task_manager/screens/edit_task_screen.dart';
import 'package:task_manager/screens/notification_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchBarController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Container(
            height: 30,
            width: 30,
            decoration: const BoxDecoration(
              color: Colors.black,
              shape: BoxShape.circle,
            ),
            child: Image.asset(
              'assets/images/icons/view-grid.png',
              scale: 2.75,
              color: Colors.white,
            ),
          ),
        ),
        title: const Center(
          child: Text(
            'Task Manager',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const NotificationScreen()));
              },
              splashRadius: 1,
              icon: Image.asset(
                'assets/images/icons/bell-24.png',
                scale: 2.75,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 17.5),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: TextField(
              cursorColor: Colors.orange,
              controller: searchBarController,
              textCapitalization: TextCapitalization.words,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 22,
              ),
              onChanged: (text) {
                setState(() {
                  searchBarController.text = text;
                  searchBarController.selection = TextSelection.fromPosition(
                      TextPosition(offset: searchBarController.text.length));
                });
              },
              decoration: InputDecoration(
                prefixIcon: Image.asset(
                  'assets/images/icons/search.png',
                  scale: 2.25,
                  color: Colors.black,
                ),
                hintText: 'Search',
                floatingLabelBehavior: FloatingLabelBehavior.never,
                border: InputBorder.none,
                suffixIcon: searchBarController.text.isEmpty
                    ? null
                    : GestureDetector(
                        onTap: (() {
                          searchBarController.clear();
                          setState(() {
                            searchBarController.text.isEmpty;
                          });
                        }),
                        child: Image.asset(
                          'assets/images/icons/ic_clear_24px.png',
                          scale: 2.25,
                          color: Colors.black,
                        ),
                      ),
              ),
            ),
          ),
          const SizedBox(height: 22.5),
          const Padding(
            padding: EdgeInsets.only(left: 16),
            child: Text(
              'Search Result',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 17.5),
          Expanded(
            child: BlocBuilder<TaskBloc, TaskState>(
              builder: (context, state) {
                if (state is TaskLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is TaskLoaded) {
                  var results = searchBarController.text.isEmpty
                      ? state.tasks.toList()
                      : state.tasks
                          .where((task) => task.name
                              .toLowerCase()
                              .contains(searchBarController.text.toLowerCase()))
                          .toList();
                  return results.isEmpty
                      ? Align(
                          alignment: Alignment.topCenter,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 85),
                            child: Column(
                              children: [
                                Image.asset(
                                  'assets/images/illustrations/no_results.jpg',
                                  width: MediaQuery.of(context).size.width - 40,
                                ),
                                const SizedBox(height: 15),
                                const Text(
                                  'No results found',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : ListView.builder(
                          itemCount: results.length,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            Task task = results[index];
                            return Padding(
                              padding: const EdgeInsets.only(
                                  left: 16, right: 16, bottom: 15),
                              child: Container(
                                height: 190,
                                width: MediaQuery.of(context).size.width,
                                padding:
                                    const EdgeInsets.fromLTRB(20, 20, 20, 0),
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
                                              padding: const EdgeInsets.only(
                                                  right: 8),
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
                                              padding: const EdgeInsets.only(
                                                  right: 8.0),
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
                                          padding:
                                              const EdgeInsets.only(left: 7.5),
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
                                              padding: const EdgeInsets.only(
                                                  left: 7.5),
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
                          },
                        );
                } else {
                  return const Text('Something went wrong');
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
