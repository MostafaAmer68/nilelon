import 'package:flutter/material.dart';
import 'package:nilelon/widgets/button/button_builder.dart';
import 'package:nilelon/widgets/button/gradient_button_builder.dart';

class AddToFooter extends StatelessWidget {
  const AddToFooter({super.key, this.visible = true});
  final bool visible;
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible,
      child: Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GradientButtonBuilder(text: 'Add To Cart', ontap: () {}),
                ButtonBuilder(text: 'Buy Now', ontap: () {})
              ],
            ),
          ),
        ],
      ),
    );
  }
}
