import 'package:flutter/material.dart';
import 'package:nilelon/features/shared/pdf_view/pdf_view.dart';
import 'package:nilelon/core/resources/color_manager.dart';
import 'package:nilelon/core/resources/const_functions.dart';

class OrderDetailsFooter extends StatelessWidget {
  const OrderDetailsFooter({super.key, this.visible = true});
  final bool visible;
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible,
      child: Container(
        color: ColorManager.primaryW,
        width: screenWidth(context, 1),
        child: const NilelonPdfView(
          cells: [
            ['T-shirt', 'Store', '1', 'White', 'XL', '300 L.E'],
            ['T-shirt', 'Store', '1', 'White', 'XL', '300 L.E'],
            ['T-shirt', 'Store', '1', 'White', 'XL', '300 L.E'],
            ['T-shirt', 'Store', '1', 'White', 'XL', '300 L.E'],
            ['T-shirt', 'Store', '1', 'White', 'XL', '300 L.E'],
            ['T-shirt', 'Store', '1', 'White', 'XL', '300 L.E'],
            ['T-shirt', 'Store', '1', 'White', 'XL', '300 L.E'],
            ['T-shirt', 'Store', '1', 'White', 'XL', '300 L.E'],
            ['T-shirt', 'Store', '1', 'White', 'XL', '300 L.E'],
            ['T-shirt', 'Store', '1', 'White', 'XL', '300 L.E'],
            ['T-shirt', 'Store', '1', 'White', 'XL', '300 L.E'],
            ['T-shirt', 'Store', '1', 'White', 'XL', '300 L.E'],
            ['T-shirt', 'Store', '1', 'White', 'XL', '300 L.E'],
            ['T-shirt', 'Store', '1', 'White', 'XL', '300 L.E'],
            ['T-shirt', 'Store', '1', 'White', 'XL', '300 L.E'],
            ['T-shirt', 'Store', '1', 'White', 'XL', '300 L.E'],
            ['T-shirt', 'Store', '1', 'White', 'XL', '300 L.E'],
            ['T-shirt', 'Store', '1', 'White', 'XL', '300 L.E'],
            ['T-shirt', 'Store', '1', 'White', 'XL', '300 L.E'],
            ['T-shirt', 'Store', '1', 'White', 'XL', '300 L.E'],
            ['T-shirt', 'Store', '1', 'White', 'XL', '300 L.E'],
            ['T-shirt', 'Store', '1', 'White', 'XL', '300 L.E'],
            ['T-shirt', 'Store', '1', 'White', 'XL', '300 L.E'],
            ['T-shirt', 'Store', '1', 'White', 'XL', '300 L.E'],
            ['T-shirt', 'Store', '1', 'White', 'XL', '300 L.E'],
            ['T-shirt', 'Store', '1', 'White', 'XL', '300 L.E'],
            ['T-shirt', 'Store', '1', 'White', 'XL', '300 L.E'],
            ['T-shirt', 'Store', '1', 'White', 'XL', '300 L.E'],
            ['T-shirt', 'Store', '1', 'White', 'XL', '300 L.E'],
            ['T-shirt', 'Store', '1', 'White', 'XL', '300 L.E'],
            ['T-shirt', 'Store', '1', 'White', 'XL', '300 L.E'],
            ['T-shirt', 'Store', '1', 'White', 'XL', '300 L.E'],
            ['T-shirt', 'Store', '1', 'White', 'XL', '300 L.E'],
            ['T-shirt', 'Store', '1', 'White', 'XL', '300 L.E'],
            ['T-shirt', 'Store', '1', 'White', 'XL', '300 L.E'],
            ['T-shirt', 'Store', '1', 'White', 'XL', '300 L.E'],
            ['T-shirt', 'Store', '1', 'White', 'XL', '300 L.E'],
            ['T-shirt', 'Store', '1', 'White', 'XL', '300 L.E'],
            ['T-shirt', 'Store', '1', 'White', 'XL', '300 L.E'],
            ['T-shirt', 'Store', '1', 'White', 'XL', '300 L.E'],
            ['T-shirt', 'Store', '1', 'White', 'XL', '300 L.E'],
            ['T-shirt', 'Store', '1', 'White', 'XL', '300 L.E'],
            ['T-shirt', 'Store', '1', 'White', 'XL', '300 L.E'],
            ['T-shirt', 'Store', '1', 'White', 'XL', '300 L.E'],
            ['T-shirt', 'Store', '1', 'White', 'XL', '300 L.E'],
            ['T-shirt', 'Store', '1', 'White', 'XL', '300 L.E'],
            ['T-shirt', 'Store', '1', 'White', 'XL', '300 L.E'],
            ['T-shirt', 'Store', '1', 'White', 'XL', '300 L.E'],
            ['T-shirt', 'Store', '1', 'White', 'XL', '300 L.E'],
            ['T-shirt', 'Store', '1', 'White', 'XL', '300 L.E'],
            ['T-shirt', 'Store', '1', 'White', 'XL', '300 L.E'],
            ['T-shirt', 'Store', '1', 'White', 'XL', '300 L.E'],
            ['T-shirt', 'Store', '1', 'White', 'XL', '300 L.E'],
            ['T-shirt', 'Store', '1', 'White', 'XL', '300 L.E'],
            ['T-shirt', 'Store', '1', 'White', 'XL', '300 L.E'],
            ['T-shirt', 'Store', '1', 'White', 'XL', '300 L.E'],
            ['T-shirt', 'Store', '1', 'White', 'XL', '300 L.E'],
            ['T-shirt', 'Store', '1', 'White', 'XL', '300 L.E'],
            ['T-shirt', 'Store', '1', 'White', 'XL', '300 L.E'],
            ['T-shirt', 'Store', '1', 'White', 'XL', '300 L.E'],
            ['T-shirt', 'Store', '1', 'White', 'XL', '300 L.E'],
            ['T-shirt', 'Store', '1', 'White', 'XL', '300 L.E'],
            ['T-shirt', 'Store', '1', 'White', 'XL', '300 L.E'],
            ['T-shirt', 'Store', '1', 'White', 'XL', '300 L.E'],
            ['T-shirt', 'Store', '1', 'White', 'XL', '300 L.E'],
            ['T-shirt', 'Store', '1', 'White', 'XL', '300 L.E'],
            ['T-shirt', 'Store', '1', 'White', 'XL', '300 L.E'],
            ['T-shirt', 'Store', '1', 'White', 'XL', '300 L.E'],
            ['T-shirt', 'Store', '1', 'White', 'XL', '300 L.E'],
            ['T-shirt', 'Store', '1', 'White', 'XL', '300 L.E'],
            ['T-shirt', 'Store', '1', 'White', 'XL', '300 L.E'],
            ['T-shirt', 'Store', '1', 'White', 'XL', '300 L.E'],
            ['T-shirt', 'Store', '1', 'White', 'XL', '300 L.E'],
          ],
          netTotal: '30000',
          discount: '2000',
          total: '29000',
          delivery: '1000',
        ),
        // GradientButtonBuilder(
        //   text: 'Download Receipt ',
        //   ontap: () {},
        //   width: screenWidth(context, 1),
        // ),
      ),
    );
  }
}