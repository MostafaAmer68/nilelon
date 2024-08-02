import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:nilelon/resources/color_manager.dart';
import 'package:nilelon/resources/const_functions.dart';
import 'package:nilelon/resources/appstyles_manager.dart';
import 'package:nilelon/utils/navigation.dart';
import 'package:nilelon/widgets/button/button_builder.dart';
import 'package:nilelon/widgets/button/gradient_button_builder.dart';
import 'package:nilelon/widgets/rating/cubit/review_cubit.dart';
import 'package:nilelon/widgets/text_form_field/text_field/text_form_field_builder.dart';

Future ratingDialog(
  BuildContext context,
) {
  return showModalBottomSheet(
    isScrollControlled: true,
    useSafeArea: true,
    context: context,
    builder: (BuildContext context) {
      return SingleChildScrollView(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          height: 500,
          width: screenWidth(context, 1),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 16,
                ),
                Text(
                  'Rate Product',
                  style: AppStylesManager.customTextStyleBl6
                      .copyWith(fontWeight: FontWeight.w700),
                ),
                const SizedBox(
                  height: 32,
                ),
                RatingBar.builder(
                  initialRating: RatingCubit.get(context).ratingg,
                  itemSize: 40,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: const EdgeInsets.only(right: 8),
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    print(rating);
                    RatingCubit.get(context).ratingg = rating;
                  },
                ),
                const SizedBox(
                  height: 24,
                ),
                TextFormFieldBuilder(
                  label: 'Write Comment ',
                  height: 230,
                  controller: TextEditingController(),
                  type: TextInputType.text,
                  maxlines: false,
                  width: screenWidth(context, 1),
                  noIcon: true,
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ButtonBuilder(
                      buttonColor: Colors.transparent,
                      style: AppStylesManager.customTextStyleW2
                          .copyWith(color: ColorManager.primaryB2),
                      text: 'Cancel',
                      ontap: () {
                        navigatePop(context: context);
                      },
                      height: 45,
                    ),
                    GradientButtonBuilder(
                      text: 'Save',
                      ontap: () {},
                      height: 45,
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      );
    },
  );
}
