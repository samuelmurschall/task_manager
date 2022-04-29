import 'package:flutter/material.dart';

class PopUpMenuColor extends StatefulWidget {
  PopUpMenuColor({Key? key, this.selectedColor = const Color(0xffFBE114)})
      : super(key: key);
  Color selectedColor;
  @override
  State<PopUpMenuColor> createState() => _PopUpMenuColorState();
}

class _PopUpMenuColorState extends State<PopUpMenuColor> {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<Color>(
      onSelected: (value) {
        setState(() {
          widget.selectedColor = value;
        });
      },
      child: Container(
        height: 25,
        width: 25,
        decoration: BoxDecoration(
          color: widget.selectedColor,
          shape: BoxShape.circle,
        ),
      ),
      itemBuilder: (BuildContext context) => <PopupMenuEntry<Color>>[
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
    );
  }
}
