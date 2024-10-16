import 'package:flutter/material.dart';

import 'cateogyr_filter_item.dart';

class GendarFilterWidget extends StatefulWidget {
  const GendarFilterWidget({
    super.key,
    required this.onSelected,
    required this.selectedCategory,
  });
  final String selectedCategory;
  final Function(String category) onSelected;
  @override
  State<GendarFilterWidget> createState() => _GendarFilterWidgetState();
}

class _GendarFilterWidgetState extends State<GendarFilterWidget> {
  List<String> gander = ['Male', 'Female', 'All'];
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: gander.length,
        itemBuilder: (context, index) {
          final ganderItem = gander[index];
          return CategoryFilterItem(
            name: ganderItem,
            isSelected: widget.selectedCategory == ganderItem,
            onTap: () {
              widget.onSelected(ganderItem);
            },
          );
        },
      ),
    );
  }
}
