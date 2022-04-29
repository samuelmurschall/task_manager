import 'package:flutter/material.dart';

class NotificationMessageTile extends StatelessWidget {
  const NotificationMessageTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 15,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, bottom: 15),
          child: Container(
            height: 75,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.only(left: 12.5),
            decoration: BoxDecoration(
              border:
                  Border.all(color: Colors.black.withOpacity(0.1), width: 1.5),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Row(
              children: [
                Container(
                  height: 50,
                  width: 50,
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    'assets/images/icons/bell-24.png',
                    color: Colors.white,
                    scale: 2.5,
                  ),
                ),
                const SizedBox(width: 15),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Taking My Sister To School',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 2.5),
                    Row(
                      children: [
                        Image.asset(
                          'assets/images/icons/clock-circle.png',
                          scale: 3.75,
                        ),
                        const SizedBox(width: 5),
                        const Text(
                          '07:30',
                          style: TextStyle(
                            fontSize: 16,
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
  }
}
