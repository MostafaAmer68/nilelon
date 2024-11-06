// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:nilelon/core/resources/appstyles_manager.dart';
import 'package:nilelon/core/resources/color_manager.dart';
import 'package:nilelon/core/resources/const_functions.dart';

class NotifyViewedCard extends StatelessWidget {
  const NotifyViewedCard({
    super.key,
    required this.image,
    required this.title,
    required this.time,
    required this.type,
  });
  final String image;
  final String title;
  final String time;
  final String type;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:(){
        switch(type){
          
        }
      },
      child: Container(
        height: 100,
        width: screenWidth(context, 0.9),
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: ColorManager.primaryW,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: ColorManager.primaryG6,
              blurRadius: 10,
              offset: Offset(0, 2),
              spreadRadius: 0,
            )
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              width: 16,
            ),
            Container(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              width: 70,
              height: 70,
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                color: Color(0xFFECE7FF),
                shape: BoxShape.circle,
              ),
              child: Image.asset(image, fit: BoxFit.cover),
            ),
            const SizedBox(
              width: 4,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 8,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      title,
                      style: AppStylesManager.customTextStyleG3,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 4,
                    ),
                    const Spacer(),
                    Text(
                      DateFormat('dd-MM-yyyy').format(
                          DateFormat('yyyy-MM-ddTHH:mm:ss.ssssss').parse(time)),
                      style: AppStylesManager.customTextStyleG5,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              width: 12,
            ),
          ],
        ),
      ),
    );
  }
}
