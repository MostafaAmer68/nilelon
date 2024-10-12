import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nilelon/features/closet/presentation/cubit/closet_cubit.dart';
import 'package:nilelon/core/resources/const_functions.dart';
import 'package:nilelon/core/resources/appstyles_manager.dart';
import 'package:nilelon/features/product/presentation/cubit/products_cubit/products_cubit.dart';

import '../../../features/closet/presentation/widget/closet_widget_with_options.dart';
import '../../../features/closet/presentation/widget/create_section_widget.dart';
import '../../../features/customer_flow/section_details/section_details_view.dart';
import '../../../generated/l10n.dart';
import '../../utils/navigation.dart';

Future addToClosetDialog(
  BuildContext context,
  String productid,
) {
  ClosetCubit.get(context).getclosets();
  return showModalBottomSheet(
    isScrollControlled: true,
    useSafeArea: true,
    context: context,
    builder: (BuildContext context) {
      return BlocListener<ClosetCubit, ClosetState>(
        listener: (context, state) {
          state.mapOrNull(
            success: (_) {
              BotToast.closeAllLoading();
              final productIndex = ProductsCubit.get(context)
                  .products
                  .indexWhere((e) => e.id == productid);
              ProductsCubit.get(context).products[productIndex] =
                  ProductsCubit.get(context)
                      .products[productIndex]
                      .copyWith(isInCloset: true);
              // navigatePop(context: context);
            },
          );
        },
        child: SingleChildScrollView(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            height: 500.h,
            width: screenWidth(context, 1),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(16.0.sp),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                            'Save to Closet',
                            style: AppStylesManager.customTextStyleBl6
                                .copyWith(fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(height: 20),
                          BlocConsumer<ClosetCubit, ClosetState>(
                            listener: (context, state) {
                              state.mapOrNull(successAdded: (_) {
                                BotToast.closeAllLoading();
                                BotToast.showCustomText(
                                  duration: const Duration(seconds: 4),
                                  toastBuilder: (_) => Card(
                                    color: Colors.black87,
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            S.of(context).productAddedToCart,
                                            style: const TextStyle(
                                                color: Colors.white),
                                          ),
                                          const SizedBox(width: 10),
                                          TextButton(
                                            onPressed: () {
                                              BotToast.closeAllLoading();
                                              navigateTo(
                                                context: context,
                                                screen: SectionDetailsView(
                                                  closet:
                                                      ClosetCubit.get(context)
                                                          .closet,
                                                ),
                                              );
                                            },
                                            child: Text(
                                              S.of(context).viewCart,
                                              style: const TextStyle(
                                                  color: Colors.blue),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }, loading: (_) {
                                BotToast.showLoading();
                              });
                            },
                            builder: (context, state) {
                              return state.whenOrNull(initial: () {
                                return const Text('Waiting to Get Closets');
                              }, loading: () {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }, success: () {
                                return ListView.builder(
                                  shrinkWrap: true,
                                  itemCount:
                                      ClosetCubit.get(context).closets.length,
                                  itemBuilder: (context, index) {
                                    final closet =
                                        ClosetCubit.get(context).closets[index];
                                    return ClosetsWidgetWithOptions(
                                      closet: closet,
                                      onTap: () {
                                        ClosetCubit.get(context)
                                            .addProductToClosets(
                                                productid,
                                                ClosetCubit.get(context)
                                                    .closets[index]
                                                    .id);
                                      },
                                    );
                                  },
                                );
                              }, failure: () {
                                return const Text(
                                    'there are error try again later');
                              })!;
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 8.h),
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        // isScrollControlled: true,
                        // useSafeArea: true,
                        context: context,
                        builder: (BuildContext context) {
                          return CreateNewSection();
                        },
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x3F000000),
                            blurRadius: 20,
                            offset: Offset(-4, 4),
                            spreadRadius: 0,
                          )
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(8.0.sp),
                        child: Row(
                          children: [
                            Container(
                              width: 48.w,
                              height: 48.w,
                              padding: EdgeInsets.all(12.sp),
                              clipBehavior: Clip.antiAlias,
                              decoration: ShapeDecoration(
                                color: const Color(0xFFDADADA),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5)),
                                shadows: const [
                                  BoxShadow(
                                    color: Color(0x19000000),
                                    blurRadius: 4,
                                    offset: Offset(0, 1),
                                    spreadRadius: 0,
                                  )
                                ],
                              ),
                              child: const Icon(
                                Icons.add,
                                color: Color(0xFF878FB2),
                              ),
                            ),
                            SizedBox(
                              width: 8.w,
                            ),
                            Text(
                              'Create New Section',
                              style: AppStylesManager.customTextStyleBl6,
                            ),
                          ],
                        ),
                      ),
                    ),
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
