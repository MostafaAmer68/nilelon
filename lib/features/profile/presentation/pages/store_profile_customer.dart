import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:nilelon/core/generated/l10n.dart';
import 'package:nilelon/core/resources/color_manager.dart';
import 'package:nilelon/core/resources/const_functions.dart';
import 'package:nilelon/core/resources/appstyles_manager.dart';
import 'package:nilelon/core/widgets/button/gradient_button_builder.dart';
import 'package:nilelon/core/widgets/button/outlined_button_builder.dart';
import 'package:nilelon/core/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:nilelon/core/widgets/divider/default_divider.dart';
import 'package:nilelon/core/widgets/pop_ups/customer_store_popup.dart';
import 'package:nilelon/core/widgets/cards/small/small_card.dart';
import 'package:nilelon/features/profile/presentation/cubit/profile_cubit.dart';

class StoreProfileCustomer extends StatefulWidget {
  const StoreProfileCustomer({super.key, required this.storeId});

  final String storeId;
  @override
  State<StoreProfileCustomer> createState() => _StoreProfileCustomerState();
}

class _StoreProfileCustomerState extends State<StoreProfileCustomer> {
  late final ProfileCubit cubit;
  List<String> items = [
    'All Items',
    'T-Shirts',
    'Jackets',
    'Sneakers',
    'Pants'
  ];
  bool notFollowing = true;
  int _selectedIndex = 0;
  @override
  void initState() {
    cubit = BlocProvider.of(context);
    cubit.getStoreById(widget.storeId);
    super.initState();
  }

  // String _indexName = 'All Items';
  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);
    return Scaffold(
      backgroundColor: ColorManager.primaryW,
      appBar: customAppBar(
        title: cubit.storeProfile!.name,
        context: context,
        onPressed: () {
          customerStoreDialog(context);
        },
        icon: Icons.more_vert_rounded,
      ),
      body: SingleChildScrollView(
        child: BlocConsumer<ProfileCubit, ProfileState>(
          listener: (context, state) {
            state.mapOrNull(loading: (r) {
              BotToast.showLoading();
            }, success: (r) {
              BotToast.closeAllLoading();
              BotToast.showText(text: 'You are now following this store');
            }, failure: (r) {
              BotToast.closeAllLoading();
            });
          },
          builder: (context, state) {
            return state.when(
                initial: () => const SizedBox(),
                failure: () => const SizedBox(),
                loading: () => const Center(child: CircularProgressIndicator()),
                success: () {
                  return Column(
                    children: [
                      const DefaultDivider(),
                      const SizedBox(
                        height: 30,
                      ),
                      circleItems(cubit.storeProfile!.profilePic),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        cubit.storeProfile!.name,
                        style: AppStylesManager.customTextStyleBl8
                            .copyWith(fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        cubit.storeProfile!.storeSlogan ?? '',
                        style: AppStylesManager.customTextStyleG5,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          notFollowing
                              ? GradientButtonBuilder(
                                  text: lang.follow,
                                  ontap: () {
                                    notFollowing = !notFollowing;
                                    cubit.followStore(widget.storeId);
                                    setState(() {});
                                  },
                                  width: screenWidth(context, 0.55),
                                  height: 38,
                                )
                              : OutlinedButtonBuilder(
                                  text: lang.following,
                                  ontap: () {
                                    notFollowing = !notFollowing;
                                    setState(() {});
                                  },
                                  width: screenWidth(context, 0.55),
                                  height: 38,
                                ),
                          const SizedBox(
                            width: 16,
                          ),
                          Container(
                            height: 38,
                            width: 38,
                            decoration: BoxDecoration(
                                color: ColorManager.primaryG16,
                                borderRadius: BorderRadius.circular(12)),
                            child: IconButton(
                              icon: const Icon(
                                Iconsax.notification,
                                color: ColorManager.primaryO,
                                size: 18,
                              ),
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const DefaultDivider(),
                      const SizedBox(
                        height: 18,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 16,
                          ),
                          const Icon(Icons.tune),
                          const SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            child: SizedBox(
                              height: 52,
                              width: MediaQuery.of(context).size.width,
                              child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) =>
                                    filterContainer(items[index], index),
                                itemCount: items.length,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  mainAxisExtent: 220,
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 20.0,
                                  mainAxisSpacing: 12),
                          shrinkWrap: true,
                          itemCount: 7,
                          itemBuilder: (context, sizeIndex) {
                            return Container(
                              child: smallCard(context: context),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                });
          },
        ),
      ),
    );
  }

  GestureDetector filterContainer(String name, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
          // _indexName = name;
        });
      },
      child: _selectedIndex == index
          ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Container(
                // height: 30,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: ColorManager.primaryB2,
                    border: Border.all(color: ColorManager.primaryB2)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  child: Center(
                    child: Text(
                      name,
                      textAlign: TextAlign.center,
                      style: AppStylesManager.customTextStyleW4,
                    ),
                  ),
                ),
              ),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Container(
                // height: 30,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: ColorManager.primaryB2)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  child: Center(
                    child: Text(
                      name,
                      textAlign: TextAlign.center,
                      style: AppStylesManager.customTextStyleB3
                          .copyWith(fontSize: 12, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
            ),
    );
  }

  Container circleItems(String image) {
    return Container(
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(500),
        ),
        shadows: const [
          BoxShadow(
            color: Color(0x33726363),
            blurRadius: 16,
            offset: Offset(0, 1),
            spreadRadius: 0,
          )
        ],
      ),
      child: CircleAvatar(
        radius: 50,
        backgroundImage: NetworkImage(image),
      ),
    );
  }
}
