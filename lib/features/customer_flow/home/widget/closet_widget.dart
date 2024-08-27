import 'package:flutter/material.dart';
import 'package:nilelon/core/resources/appstyles_manager.dart';

class ClosetsWidget extends StatelessWidget {
  const ClosetsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: const DecorationImage(
                  image: AssetImage('assets/images/saveToCloset.png'),
                  fit: BoxFit.fill)),
        ),
        const SizedBox(
          width: 16,
        ),
        Text(
          'T-Shirt',
          style: AppStylesManager.customTextStyleBl6,
        ),
      ],
    );
  }
}
