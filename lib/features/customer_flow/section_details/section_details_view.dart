import 'package:flutter/material.dart';
import 'package:nilelon/resources/color_manager.dart';
import 'package:nilelon/widgets/cards/small/section_small_card.dart';
import 'package:nilelon/widgets/custom_app_bar/custom_app_bar.dart';

class SectionDetailsView extends StatelessWidget {
  const SectionDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primaryW,
      appBar: customAppBar(title: 'T-Shirt', context: context),
      body: Column(
        children: [
          const SizedBox(
            height: 4,
            child: Divider(
              color: ColorManager.primaryG8,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 0.85,
                    crossAxisCount: 2,
                    crossAxisSpacing: 20.0,
                    mainAxisSpacing: 12),
                itemCount: 7,
                itemBuilder: (context, sizeIndex) {
                  return Container(
                    child: sectionSmallCard(context: context),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
