import 'package:flutter/material.dart';
import 'package:nilelon/resources/appstyles_manager.dart';
import 'package:nilelon/resources/color_manager.dart';
import 'package:nilelon/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:nilelon/widgets/cards/small/market_small_card.dart';
import 'package:nilelon/widgets/divider/default_divider.dart';
import 'package:nilelon/widgets/pop_ups/customer_store_popup.dart';

class StoreProfileStore extends StatefulWidget {
  const StoreProfileStore(
      {super.key,
      required this.storeName,
      required this.image,
      required this.description});
  final String storeName;
  final String image;
  final String description;
  @override
  State<StoreProfileStore> createState() => _StoreProfileStoreState();
}

class _StoreProfileStoreState extends State<StoreProfileStore> {
  List<String> items = [
    'All Items',
    'T-Shirts',
    'Jackets',
    'Sneakers',
    'Pants'
  ];
  int _selectedIndex = 0;
  // String _indexName = 'All Items';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primaryW,
      appBar: customAppBar(
        title: widget.storeName,
        context: context,
        onPressed: () {
          customerStoreDialog(context);
        },
        icon: Icons.more_vert_rounded,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const DefaultDivider(),
            const SizedBox(
              height: 30,
            ),
            circleItems(widget.image),
            const SizedBox(
              height: 16,
            ),
            Text(
              widget.storeName,
              style: AppStylesManager.customTextStyleBl8
                  .copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              widget.description,
              style: AppStylesManager.customTextStyleG5,
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
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 20.0,
                    mainAxisExtent: 220,
                    mainAxisSpacing: 12),
                shrinkWrap: true,
                itemCount: 7,
                itemBuilder: (context, sizeIndex) {
                  return Container(
                    child: marketSmallCard(context: context),
                  );
                },
              ),
            ),
          ],
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
        backgroundImage: AssetImage(image),
      ),
    );
  }
}
