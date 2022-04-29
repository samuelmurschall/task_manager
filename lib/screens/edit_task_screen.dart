import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:task_manager/blocs/task/task_bloc.dart';
import 'package:task_manager/models/task_model.dart';
import 'package:task_manager/widgets/files_page.dart';
import 'package:task_manager/widgets/chip_select.dart';

class EditTaskScreen extends StatefulWidget {
  const EditTaskScreen({Key? key, required this.task}) : super(key: key);
  final Task task;
  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  late Color _selectedColor;
  late DateTime dateTime;
  TextEditingController placeLocationController = TextEditingController();
  TextEditingController taskController = TextEditingController();
  FilePickerResult? result;
  late Box<Task> tasksBox;

  void filePicker() async {
    result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['pdf', 'mp4'],
    );
    setState(() {
      if (result == null) return;
    });
  }

  void openFile(PlatformFile file) {
    OpenFile.open(file.path!);
  }

  void openFiles(List<PlatformFile> files) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => FilesPage(files: files, onOpenedFile: openFile)));
  }

  @override
  void initState() {
    super.initState();
    taskController.text = widget.task.name;
    _selectedColor = Color(widget.task.color);
    placeLocationController.text = widget.task.place;
    String date = '${widget.task.deadlineDate}, ${widget.task.deadlineTime}';
    dateTime = DateFormat('dd MMMM yyyy, hh:mm a').parse(date);
  }

  @override
  Widget build(BuildContext context) {
    bool showFAB = MediaQuery.of(context).viewInsets.bottom != 0;
    return BlocBuilder<TaskBloc, TaskState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              leading: Padding(
                padding: const EdgeInsets.only(left: 16),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Image.asset(
                    'assets/images/icons/arrow-left-24.png',
                    scale: 2.25,
                    color: Colors.black,
                  ),
                ),
              ),
              title: const Center(
                child: Text(
                  'Edit Task',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              actions: [
                GestureDetector(
                  onTap: (() {
                    context.read<TaskBloc>().add(DeleteTask(task: widget.task));
                    Navigator.pop(context);
                  }),
                  child: Image.asset(
                    'assets/images/icons/trash-alt.png',
                    scale: 2.75,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(width: 5),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: ListView(
                controller: ScrollController(),
                scrollDirection: Axis.vertical,
                physics: const BouncingScrollPhysics(),
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 30),
                      const Text(
                        'My Task',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12.5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                TextFormField(
                                  controller: taskController,
                                  minLines: 1,
                                  maxLines: 3,
                                  textCapitalization: TextCapitalization.words,
                                  keyboardType: TextInputType.text,
                                  enableSuggestions: true,
                                  autocorrect: true,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22,
                                  ),
                                  onChanged: (text) {
                                    setState(() {
                                      taskController.text = text;
                                      taskController.selection =
                                          TextSelection.fromPosition(
                                              TextPosition(
                                                  offset: taskController
                                                      .text.length));
                                    });
                                  },
                                  decoration: const InputDecoration(
                                      hintText: 'Meeting With Client',
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.never,
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.zero),
                                ),
                              ],
                            ),
                          ),
                          PopupMenuButton<Color>(
                            onSelected: (value) {
                              _selectedColor = value;
                              setState(() {});
                            },
                            child: Container(
                              height: 25,
                              width: 25,
                              decoration: BoxDecoration(
                                color: _selectedColor,
                                shape: BoxShape.circle,
                              ),
                            ),
                            itemBuilder: (BuildContext context) =>
                                <PopupMenuEntry<Color>>[
                              PopupMenuItem<Color>(
                                value: const Color(0xffFBE114),
                                child: Container(
                                  height: 25,
                                  width: 25,
                                  decoration: const BoxDecoration(
                                    color: Color(0xffFBE114),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                              PopupMenuItem<Color>(
                                value: const Color(0xff4BEED1),
                                child: Container(
                                  height: 25,
                                  width: 25,
                                  decoration: const BoxDecoration(
                                    color: Color(0xff4BEED1),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                              PopupMenuItem<Color>(
                                value: const Color(0xff13D3FB),
                                child: Container(
                                  height: 25,
                                  width: 25,
                                  decoration: const BoxDecoration(
                                    color: Color(0xff13D3FB),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                              PopupMenuItem<Color>(
                                value: const Color(0xffB6ADFF),
                                child: Container(
                                  height: 25,
                                  width: 25,
                                  decoration: const BoxDecoration(
                                    color: Color(0xffB6ADFF),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                              PopupMenuItem<Color>(
                                value: const Color(0xffFB1467),
                                child: Container(
                                  height: 25,
                                  width: 25,
                                  decoration: const BoxDecoration(
                                    color: Color(0xffFB1467),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                              PopupMenuItem<Color>(
                                value: const Color(0xffF5815C),
                                child: Container(
                                  height: 25,
                                  width: 25,
                                  decoration: const BoxDecoration(
                                    color: Color(0xffF5815C),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                              PopupMenuItem<Color>(
                                value: const Color(0xff148CFB),
                                child: Container(
                                  height: 25,
                                  width: 25,
                                  decoration: const BoxDecoration(
                                    color: Color(0xff148CFB),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                              PopupMenuItem<Color>(
                                value: const Color(0xffA949C1),
                                child: Container(
                                  height: 25,
                                  width: 25,
                                  decoration: const BoxDecoration(
                                    color: Color(0xffA949C1),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Divider(color: Colors.grey.shade300, thickness: 2),
                      const SizedBox(height: 20),
                      const Text(
                        'Deadline',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12.5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  onTap: (() {
                                    showDialog(
                                      //barrierColor: Colors.transparent,
                                      context: context,
                                      builder: (ctx) => Dialog(
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(25),
                                                topRight: Radius.circular(25))),
                                        alignment: Alignment.bottomCenter,
                                        insetPadding: EdgeInsets.only(
                                            top: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.7),
                                        child: CupertinoDatePicker(
                                          mode: CupertinoDatePickerMode
                                              .dateAndTime,
                                          maximumYear: 2022,
                                          onDateTimeChanged: (dateTime) {
                                            setState(() {
                                              this.dateTime = dateTime;
                                            });
                                          },
                                          initialDateTime: dateTime,
                                        ),
                                      ),
                                    );
                                  }),
                                  child: Text(
                                    DateFormat('dd MMMM yyyy, hh:mm a')
                                        .format(dateTime),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Image.asset(
                            'assets/images/icons/calendar-alt.png',
                            scale: 2.75,
                          ),
                        ],
                      ),
                      const SizedBox(height: 12.5),
                      Divider(color: Colors.grey.shade300, thickness: 2),
                      const SizedBox(height: 20),
                      const Text(
                        'Place',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12.5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextFormField(
                                  controller: placeLocationController,
                                  textCapitalization: TextCapitalization.words,
                                  keyboardType: TextInputType.text,
                                  enableSuggestions: true,
                                  autocorrect: true,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22,
                                  ),
                                  onChanged: (text) {
                                    setState(() {
                                      placeLocationController.text = text;
                                      placeLocationController.selection =
                                          TextSelection.fromPosition(
                                              TextPosition(
                                                  offset:
                                                      placeLocationController
                                                          .text.length));
                                    });
                                  },
                                  decoration: const InputDecoration(
                                      hintText: 'Zoom At Home',
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.never,
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.zero),
                                ),
                              ],
                            ),
                          ),
                          Image.asset(
                            'assets/images/icons/cil-location-pin.png',
                            scale: 2.75,
                          ),
                        ],
                      ),
                      const SizedBox(height: 12.5),
                      Divider(color: Colors.grey.shade300, thickness: 2),
                      const SizedBox(height: 20),
                      const Text(
                        'Task Type',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 15),
                      const ChipsSelect(
                        selected: 0,
                        filters: [
                          Filter(label: "Basic"),
                          Filter(label: "Urgent"),
                          Filter(label: "Important"),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Divider(color: Colors.grey.shade300, thickness: 2),
                      const SizedBox(height: 12.5),
                      GestureDetector(
                        onTap: () async {
                          filePicker();
                        },
                        child: Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: _selectedColor,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(50)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/images/icons/file-plus.png',
                                scale: 2.75,
                              ),
                              const SizedBox(width: 10),
                              const Text(
                                'Attach File',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 250,
                        child: result?.files != null
                            ? FilesPage(
                                files: result!.files, onOpenedFile: openFile)
                            : null,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Visibility(
              visible: !showFAB,
              child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: SizedBox(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  child: FloatingActionButton.extended(
                    onPressed: () {
                      Task task = Task(
                        id: widget.task.id,
                        name: taskController.text,
                        color: _selectedColor.value,
                        deadlineDate:
                            DateFormat('dd MMMM yyyy').format(dateTime),
                        deadlineTime: DateFormat('hh:mm a').format(dateTime),
                        place: placeLocationController.text,
                        done: false,
                      );
                      context.read<TaskBloc>().add(UpdateTask(
                          task: task.copyWidth(
                              name: taskController.text,
                              deadlineDate:
                                  DateFormat('dd MMMM yyyy').format(dateTime),
                              deadlineTime:
                                  DateFormat('hh:mm a').format(dateTime),
                              place: placeLocationController.text)));
                      Navigator.pop(context);
                    },
                    backgroundColor: Colors.black,
                    elevation: 0,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50))),
                    label: const Text(
                      'Update Task',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
