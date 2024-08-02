// import 'package:flutter/material.dart';
// import 'package:nilelon/resources/const_functions.dart';
// import 'package:nilelon/widgets/filter/category_container.dart';
// import 'package:nilelon/widgets/filter/filter_container.dart';
// import 'package:nilelon/widgets/filter/static_lists.dart';

// Column filtersColumn({
//   required BuildContext context,
//   // required void Function() onGenderTap,
//   required bool genderSelected,
//   // required void Function() onCategoryTap,
//   required bool categorySelected,
// }) {
//   int selectedGender = 0;
//   int selectedCategory = 0;
//   return Column(
//     children: [
//       Padding(
//         padding: const EdgeInsets.only(left: 8, right: 8),
//         child: SizedBox(
//           height: screenWidth(context, 0.28),
//           width: MediaQuery.of(context).size.width,
//           child: ListView.builder(
//             shrinkWrap: true,
//             scrollDirection: Axis.horizontal,
//             itemBuilder: (context, index) => GestureDetector(
//                 onTap: () {
//                   selectedCategory = index;
//                   setState(() {});
//                 },
//                 child: categoryContainer(
//                   context: context,
//                   image: categoryFilter[index]['image'],
//                   name: categoryFilter[index]['name'],
//                   isSelected: selectedCategory == index,
//                 )),
//             itemCount: categoryFilter.length,
//           ),
//         ),
//       ),
//       const SizedBox(
//         height: 16,
//       ),
//       Row(
//         children: [
//           const SizedBox(
//             width: 16,
//           ),
//           const Icon(Icons.tune),
//           const SizedBox(
//             width: 8,
//           ),
//           Expanded(
//             child: SizedBox(
//               height: 52,
//               width: MediaQuery.of(context).size.width,
//               child: ListView.builder(
//                 shrinkWrap: true,
//                 scrollDirection: Axis.horizontal,
//                 itemBuilder: (context, index) => GestureDetector(
//                     onTap: () {
//                       selectedGender = index;
//                       setState(() {});
//                     },
//                     child: filterContainer(
//                       genderFilter[index],
//                       selectedGender == index,
//                     )),
//                 itemCount: genderFilter.length,
//               ),
//             ),
//           ),
//         ],
//       ),
//       const SizedBox(
//         height: 16,
//       ),
//     ],
//   );
// }

// class FiltersColumn extends StatefulWidget {
//   const FiltersColumn({super.key});
//   @override
//   State<FiltersColumn> createState() => _FiltersColumnState();
// }

// class _FiltersColumnState extends State<FiltersColumn> {
//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }
