import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nilelon/resources/appstyles_manager.dart';

class RatingContainer extends StatelessWidget {
  const RatingContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.sp),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CircleAvatar(
            radius: 20.r,
            backgroundImage: const AssetImage('assets/images/profile.png'),
          ),
          const SizedBox(
            width: 8,
          ),
          Expanded(
            child: Container(
              clipBehavior: Clip.antiAlias,
              // width: screenWidth(context, 0.7),
              // height: 140,
              decoration: ShapeDecoration(
                color: const Color(0xFFF3F0F1),
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
                          'Rawan Ahmed',
                          style: AppStylesManager.customTextStyleBl9,
                        ),
                        const Spacer(),
                        Text(
                          '10:11 AM',
                          style: AppStylesManager.customTextStyleG12,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    RatingBar.builder(
                      initialRating: 3.5,
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
                      'Lorem ipsum dolor sit amet consectetur. Lorem aenean eget dolor mattis viverra. Sapien quisque donec gravida aenean quam amet rhoncus id. Leo mi nec in tincidunt turpis.',
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
