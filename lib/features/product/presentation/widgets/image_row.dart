import 'package:flutter/material.dart';

import '../../../../core/resources/const_functions.dart';
import '../../../../core/widgets/pop_ups/camera_popup.dart';
import '../cubit/add_product/add_product_cubit.dart';
import 'add_container.dart';
import 'image_container.dart';

class ImageRow extends StatefulWidget {
  const ImageRow({super.key});

  @override
  State<ImageRow> createState() => _ImageRowState();
}

class _ImageRowState extends State<ImageRow> {
  late final AddProductCubit cubit;

  @override
  void initState() {
    cubit = AddProductCubit.get(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: screenWidth(context, 0.21),
      width: screenWidth(context, 1),
      child: ListView.builder(
        itemCount: cubit.images.length + 1,
        itemBuilder: (context, index) {
          if (index == cubit.images.length) {
            return addContainer(
              () async {
                if (cubit.isVarientActive) {
                  cubit.images.add((await cameraDialog(context)));

                  setState(() {});
                }
              },
              context,
              null,
              null,
            );
          } else {
            return _buildImageContainer(index);
          }
        },
        scrollDirection: Axis.horizontal,
      ),
    );
  }

  Widget _buildImageContainer(index, {bool isEditable = true}) {
    return imageContainer(
      () async {
        if (isEditable) {
          cubit.images[index] = (await cameraDialog(context));
          setState(() {});
        }
      },
      cubit.images[index].path,
      context,
      null,
      null,
    );
  }
}
