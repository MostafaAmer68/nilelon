import 'package:flutter/material.dart';
import 'package:nilelon/core/widgets/scaffold_image.dart';
import 'package:nilelon/generated/l10n.dart';

import '../../../../core/widgets/custom_app_bar/custom_app_bar.dart';

class ReturnDetailsPage extends StatefulWidget {
  const ReturnDetailsPage({super.key});

  @override
  State<ReturnDetailsPage> createState() => _ReturnDetailsPageState();
}

class _ReturnDetailsPageState extends State<ReturnDetailsPage> {
  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);
    return ScaffoldImage(
        appBar: customAppBar(
          title: lang.reportOrder,
          context: context,
          hasIcon: false,
          hasLeading: true,
        ),
        body: Column(
          children: [],
        ));
  }
}
