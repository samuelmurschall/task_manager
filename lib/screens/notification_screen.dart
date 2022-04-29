import 'package:flutter/material.dart';
import 'package:task_manager/widgets/notification_message_tile.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            'Notification',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        actions: [
          Image.asset(
            'assets/images/icons/view-grid.png',
            scale: 2.75,
            color: Colors.white,
          ),
        ],
      ),
      body: Column(
        children: const [
          SizedBox(height: 17.5),
          Expanded(
            child: NotificationMessageTile(),
          ),
        ],
      ),
    );
  }
}
