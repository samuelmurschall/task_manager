import 'package:flutter/material.dart';

class Filter {
  final String label;

  const Filter({required this.label});
}

class ChipsSelect extends StatefulWidget {
  final List<Filter> filters;

  final int selected;

  const ChipsSelect({Key? key, required this.filters, required this.selected})
      : super(key: key);

  @override
  _ChipsSelectState createState() => _ChipsSelectState();
}

class _ChipsSelectState extends State<ChipsSelect> {
  int? selectedIndex;

  @override
  void initState() {
    if (widget.selected >= 0 && widget.selected < widget.filters.length) {
      selectedIndex = widget.selected;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: chipBuilder,
        itemCount: widget.filters.length,
        scrollDirection: Axis.horizontal,
      ),
    );
  }

  ///
  /// Build a single chip
  ///
  Widget chipBuilder(context, currentIndex) {
    Filter filter = widget.filters[currentIndex];
    bool isActive = selectedIndex == currentIndex;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = currentIndex;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 27.5),
        margin: const EdgeInsets.only(right: 12.5),
        decoration: BoxDecoration(
          color: isActive ? Colors.black : Colors.white,
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              filter.label,
              style: TextStyle(
                color: isActive ? Colors.white : Colors.black,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
