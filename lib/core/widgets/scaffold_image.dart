import 'package:flutter/material.dart';

class ScaffoldImage extends StatelessWidget {
  const ScaffoldImage(
      {super.key,
      required this.body,
      this.appBar,
      this.persistentFooterButtons});
  final Widget body;
  final PreferredSizeWidget? appBar;
  final List<Widget>? persistentFooterButtons;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      persistentFooterButtons: persistentFooterButtons,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: body,
      ),
    );
  }
}
