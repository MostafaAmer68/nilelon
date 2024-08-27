import 'package:flutter/material.dart';
import 'package:nilelon/core/resources/color_manager.dart';

class DefaultDivider extends StatelessWidget {
  const DefaultDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 4,
      child: Divider(
        color: ColorManager.primaryG8,
      ),
    );
  }
}
