// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import 'package:nilelon/core/resources/appstyles_manager.dart';
import 'package:nilelon/core/resources/color_manager.dart';
import 'package:nilelon/features/product/domain/models/review_model.dart';

class RatingContainer extends StatelessWidget {
  const RatingContainer({
    super.key,
    required this.review,
  });
  final ReviewModel review;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.sp),
      margin: EdgeInsets.symmetric(vertical: 6.sp),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CircleAvatar(
            radius: 20.r,
            backgroundImage: NetworkImage(review.profilePic),
          ),
          const SizedBox(
            width: 8,
          ),
          Expanded(
            child: Container(
              clipBehavior: Clip.antiAlias,
              decoration: ShapeDecoration(
                color: ColorManager.primaryW,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          review.customerName,
                          style: AppStylesManager.customTextStyleBl9,
                        ),
                        const Spacer(),
                        Text(
                          DateFormat('dd-MM-yyyy').format(
                              DateFormat('yyyy-MM-ddTHH:mm:ss.ssssss')
                                  .parse(review.date)),
                          style: AppStylesManager.customTextStyleG12,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    RatingBar.builder(
                      initialRating: review.rate.toDouble(),
                      minRating: 1,
                      ignoreGestures: true,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemSize: 16.r,
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        print(rating);
                      },
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      review.comment,
                      style: AppStylesManager.customTextStyleBl3.copyWith(
                          fontSize: 1.sw > 600 ? 22 : 12,
                          fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
