import 'package:flutter/material.dart';
import 'package:nilelon/core/generated/l10n.dart';
import 'package:nilelon/core/resources/appstyles_manager.dart';
import 'package:nilelon/core/resources/color_manager.dart';
import 'package:nilelon/core/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:nilelon/core/widgets/divider/default_divider.dart';

import '../../../core/widgets/scaffold_image.dart';

class LanguageView extends StatefulWidget {
  const LanguageView({super.key});

  @override
  State<LanguageView> createState() => _LanguageViewState();
}

class _LanguageViewState extends State<LanguageView> {
  String _tempSelectedOption = 'English';
  List<String> options = [
    'English',
    'Arabic',
  ];
  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);

    return ScaffoldImage(
      appBar:
          customAppBar(title: lang.language, context: context, hasIcon: false),
      body: Column(
        children: [
          const DefaultDivider(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: options
                  .map((option) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Container(
                          decoration: ShapeDecoration(
                            color: const Color(0xFFFBF9F9),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            shadows: const [
                              BoxShadow(
                                color: Color(0x33726363),
                                blurRadius: 4,
                                offset: Offset(0, 4),
                                spreadRadius: 0,
                              )
                            ],
                          ),
                          child: Center(
                            child: RadioListTile(
                              title: Text(
                                option,
                                style: AppStylesManager.customTextStyleBl9,
                              ),
                              value: option,
                              activeColor: ColorManager.primaryO,
                              groupValue: _tempSelectedOption,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 6,
                              ),
                              onChanged: (value) {
                                setState(() {
                                  _tempSelectedOption = value!;
                                });
                              },
                            ),
                          ),
                        ),
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
