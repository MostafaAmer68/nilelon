import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:nilelon/core/resources/color_manager.dart';
import 'package:nilelon/core/resources/const_functions.dart';
import 'package:nilelon/core/resources/appstyles_manager.dart';
import 'package:nilelon/core/utils/navigation.dart';
import 'package:nilelon/core/widgets/button/button_builder.dart';
import 'package:nilelon/core/widgets/button/gradient_button_builder.dart';
import 'package:nilelon/core/widgets/text_form_field/text_field/text_form_field_builder.dart';
import 'package:nilelon/features/product/presentation/cubit/products_cubit/products_cubit.dart';

import '../../../../features/product/presentation/cubit/products_cubit/products_state.dart';

Future ratingDialog(
  BuildContext context,
) {
  return showModalBottomSheet(
    isScrollControlled: true,
    useSafeArea: true,
    context: context,
    builder: (BuildContext context) {
      return BlocListener<ProductsCubit, ProductsState>(
        listener: (context, state) {
          state.mapOrNull(loading: (_) {
            BotToast.showLoading();
          }, success: (_) {
            BotToast.closeAllLoading();
            ProductsCubit.get(context)
                .getReviews(ProductsCubit.get(context).product.id);
            navigatePop(context: context);
          }, failure: (r) {
            BotToast.showText(text: r.msg);
          });
        },
        child: SingleChildScrollView(
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
                    initialRating: ProductsCubit.get(context).rate.toDouble(),
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
                      ProductsCubit.get(context).rate = rating;
                    },
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  TextFormFieldBuilder(
                    label: 'Write Comment ',
                    height: 230,
                    controller: ProductsCubit.get(context).comment,
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
                        ontap: () {
                          ProductsCubit.get(context).createReview();
                        },
                        height: 45,
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}
