import 'package:flutter/material.dart';
import 'package:nilelon/features/store_flow/guide_book/cubit/guide_book_cubit.dart';
import 'package:nilelon/core/generated/l10n.dart';
import 'package:nilelon/core/resources/appstyles_manager.dart';
import 'package:nilelon/core/resources/color_manager.dart';
import 'package:nilelon/core/resources/const_functions.dart';
import 'package:nilelon/core/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:nilelon/core/widgets/divider/default_divider.dart';
import 'package:svg_flutter/svg_flutter.dart';

class GuideBookView extends StatefulWidget {
  const GuideBookView({super.key});

  @override
  State<GuideBookView> createState() => _GuideBookViewState();
}

class _GuideBookViewState extends State<GuideBookView> {
  List<Map<String, dynamic>> guideBookItems = [
    {
      'image': 'assets/images/calculator.gif',
      'text':
          'To know how it works you only need to imagine that we’re clustering the brands based on comparing their numbers to the market average numbers in every factor in this page. '
    },
    {
      'image': 'assets/images/guide2.png',
      'text':
          'The brands that have numbers which are equal to the market average are in ‘B cluster’.'
    },
    {
      'image': 'assets/images/guide3.gif',
      'image2': 'assets/images/guide2.png',
      'text':
          'Now you know where to aim, And this is your compass. In which cluster you’re is your most needed information to start evaluating your business.'
    },
    {
      'image': 'assets/images/guide4.gif',
      'text':
          'And don’t forget the total number of sales in the whole market is getting increasing while we’re talking which means the average is getting bigger too so hold on to your position and aim for a higher one.'
    },
  ];
  @override
  Widget build(BuildContext context) {
    final controller = PageController();
    final lang = S.of(context);

    return Scaffold(
      backgroundColor: ColorManager.primaryW,
      appBar: customAppBar(
        title: lang.guideBook,
        context: context,
        hasIcon: false,
      ),
      body: Column(
        children: [
          const DefaultDivider(),
          const SizedBox(
            height: 100,
          ),
          SizedBox(
            width: screenWidth(context, 1),
            height: screenHeight(context, 0.6),
            child: PageView.builder(
              itemBuilder: (context, index) {
                if (index == 2) {
                  return Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RotatedBox(
                              quarterTurns: 1,
                              child: Image.asset(
                                guideBookItems[index]['image'],
                                width: screenWidth(context, 0.35),
                                height: screenHeight(context, 0.1),
                              ),
                            ),
                            Image.asset(
                              guideBookItems[index]['image2'],
                              width: screenWidth(context, 0.65),
                              height: screenHeight(context, 0.3),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Text(
                          guideBookItems[index]['text'],
                          style: AppStylesManager.customTextStyleBl8,
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  );
                }
                return Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    children: [
                      Image.asset(
                        guideBookItems[index]['image'],
                        width: screenWidth(context, 0.6),
                        height: screenHeight(context, 0.3),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Text(
                        guideBookItems[index]['text'],
                        style: AppStylesManager.customTextStyleBl8,
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                );
              },
              physics: const BouncingScrollPhysics(),
              onPageChanged: (i) {
                GuideBookCubit.get(context).index = i;
                setState(() {});
                if (i == guideBookItems.length - 1) {
                  GuideBookCubit.get(context).changeisLast(true);
                } else if (GuideBookCubit.get(context).isLast) {
                  GuideBookCubit.get(context).changeisLast(false);
                }
              },
              controller: controller,
              itemCount: guideBookItems.length,
            ),
          ),
          const Spacer(
            flex: 3,
          ),
          Container(
            height: 50,
            width: 100,
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              shadows: const [
                BoxShadow(
                  color: Color(0x33726363),
                  blurRadius: 16,
                  offset: Offset(0, 4),
                  spreadRadius: 0,
                )
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    controller.previousPage(
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.bounceOut);
                  },
                  child: SvgPicture.asset('assets/images/ic_chevron.svg'),
                ),
                Text(
                  (GuideBookCubit.get(context).index + 1).toString(),
                  style: AppStylesManager.customTextStyleBl6,
                ),
                GestureDetector(
                  onTap: () {
                    controller.nextPage(
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.bounceOut);
                  },
                  child: SvgPicture.asset('assets/images/ic_chevron_2.svg'),
                ),
              ],
            ),
          ),
          const Spacer(
            flex: 3,
          ),
        ],
      ),
    );
  }
}
