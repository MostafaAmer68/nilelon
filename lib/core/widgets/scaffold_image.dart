import 'package:flutter/material.dart';
import 'package:nilelon/core/resources/color_manager.dart';

class ScaffoldImage extends StatelessWidget {
  const ScaffoldImage(
      {super.key,
      required this.body,
      this.appBar,
      this.persistentFooterButtons = const [],
      this.btmBar});
  final Widget body;
  final PreferredSizeWidget? appBar;
  final Widget? btmBar;
  final List<Widget> persistentFooterButtons;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/background.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        appBar: appBar,
        backgroundColor: Colors.transparent,
        persistentFooterButtons: persistentFooterButtons
            .map((e) => Container(
                  height: 5,
                  color: ColorManager.primaryW,
                  child: e,
                ))
            .toList(),
        bottomNavigationBar: Container(
          height: 5,
          color: ColorManager.primaryW,
          child: btmBar,
        ),
        body: body,
      ),
    );
  }
}
