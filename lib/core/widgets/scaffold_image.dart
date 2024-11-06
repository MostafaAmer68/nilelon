import 'package:flutter/material.dart';

class ScaffoldImage extends StatelessWidget {
  const ScaffoldImage(
      {super.key,
      required this.body,
      this.appBar,
      this.persistentFooterButtons,
      this.bgColor = 'assets/images/background.png',
      this.btmBar});
  final Widget body;
  final PreferredSizeWidget? appBar;
  final Widget? btmBar;
  final String bgColor;
  final List<Widget>? persistentFooterButtons;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(bgColor),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        appBar: appBar,
        backgroundColor: Colors.transparent,
        persistentFooterButtons: persistentFooterButtons,
        bottomNavigationBar: btmBar,
        body: body,
      ),
    );
  }
}
