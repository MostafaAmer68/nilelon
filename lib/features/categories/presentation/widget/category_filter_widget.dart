// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../../../core/data/hive_stroage.dart';
import '../../domain/model/result.dart';
import 'cateogyr_filter_item.dart';

class CategoryFilterWidget extends StatefulWidget {
  const CategoryFilterWidget({
    super.key,
    required this.onSelected,
    required this.selectedCategory,
  });
  final CategoryModel selectedCategory;
  final Function(CategoryModel category) onSelected;
  @override
  State<CategoryFilterWidget> createState() => _CategoryFilterWidgetState();
}

class _CategoryFilterWidgetState extends State<CategoryFilterWidget> {
  // CategoryModel _selectedCategory = CategoryModel.empty();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: HiveStorage.get<List>(HiveKeys.categories).length,
        itemBuilder: (context, index) {
          final category = HiveStorage.get<List>(HiveKeys.categories)[index];
          return CategoryFilterItem(
            name: category.name,
            image: category.image,
            isSelected: widget.selectedCategory == category,
            onTap: () {
              widget.onSelected(category);
            },
          );
        },
      ),
    );
  }
}
