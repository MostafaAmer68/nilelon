import 'package:flutter/material.dart';

import 'gander_filter_item.dart';

class GendarFilterWidget extends StatefulWidget {
  const GendarFilterWidget({
    super.key,
    required this.onSelected,
    required this.selectedCategory,
    this.isDark = false,
  });
  final String selectedCategory;
  final bool isDark;
  final Function(String category) onSelected;
  @override
  State<GendarFilterWidget> createState() => _GendarFilterWidgetState();
}

class _GendarFilterWidgetState extends State<GendarFilterWidget> {
  List<String> gander = ['All', 'Male', 'Female'];
  @override
  Widget build(BuildContext context) {
    return Visibility(
      // visible: HiveStorage.get(HiveKeys.isStore),
      child: SizedBox(
        height: 56,
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: gander.length,
          itemBuilder: (context, index) {
            final ganderItem = gander[index];
            return GanderFilterItem(
              isDark: widget.isDark,
              name: ganderItem,
              isSelected: widget.selectedCategory == ganderItem,
              onTap: () {
                widget.onSelected(ganderItem);
              },
            );
          },
        ),
      ),
    );
  }
}
