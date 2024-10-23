import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:nilelon/features/search/presentation/cubit/search_cubit.dart';
import 'package:nilelon/generated/l10n.dart';
import 'package:nilelon/core/resources/color_manager.dart';
import 'package:nilelon/core/resources/const_functions.dart';
import 'package:nilelon/core/resources/appstyles_manager.dart';
import 'package:nilelon/core/widgets/text_form_field/text_field/text_form_field_builder.dart';
import 'package:nilelon/core/widgets/cards/brand/brand_card.dart';

import '../../../../core/tools.dart';
import '../../../../core/widgets/scaffold_image.dart';
import '../../../profile/data/models/store_profile_model.dart';
import '../../../search/presentation/widgets/search_delegate.dart';

class SeeMoreStoresView extends StatefulWidget {
  const SeeMoreStoresView({super.key, required this.stores});
  final List<StoreProfileModel> stores;

  @override
  State<SeeMoreStoresView> createState() => _SeeMoreStoresViewState();
}

class _SeeMoreStoresViewState extends State<SeeMoreStoresView> {
  bool isSearch = false;
  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);
    return ScaffoldImage(
      appBar: searchAppBar(context),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: isSearch
            ?  const SearchResult(isBrand:true)
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    lang.allBrands,
                    style: AppStylesManager.customTextStyleB4,
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  Expanded(
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              mainAxisExtent: 200,
                              crossAxisCount: 2,
                              crossAxisSpacing: 20.0,
                              mainAxisSpacing: 12),
                      itemCount: widget.stores.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            BrandCard(
                              store: widget.stores[index],
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  AppBar searchAppBar(BuildContext context) {
    return AppBar(
      clipBehavior: Clip.none,
      leadingWidth: 30,
      backgroundColor: ColorManager.primaryW,
      title: TextFormFieldBuilder(
        label: lang(context).searchByItemBrand,
        controller: SearchCubit.get(context).searchC,
        type: TextInputType.text,
        isIcon: false,
        onchanged: (v) {
          if (v.isEmpty) {
            isSearch = false;
            setState(() {});
          } else {
            SearchCubit.get(context).search();
            isSearch = true;
          }
          setState(() {});
        },
        onpressed: () {
          SearchCubit.get(context).search();
          isSearch = true;
          setState(() {});
        },
        // height: 40,
        prefixWidget: const Icon(Iconsax.search_normal),
        width: screenWidth(context, 1),
      ),
    );
  }
}
