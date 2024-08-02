import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nilelon/resources/color_manager.dart';
import 'package:nilelon/resources/font_weight_manger.dart';

class AppStylesManager {
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;

  const AppStylesManager({
    required this.fontSize,
    required this.fontWeight,
    required this.color,
  });
  TextStyle toTextStyle() {
    return TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
    );
  }

//################# White Styles #################
  static TextStyle customTextStyleW = TextStyle(
    color: ColorManager.primaryW,
    fontSize: 1.sw > 600 ? 28 : 20,
    fontFamily: 'Nunito Sans',
    fontWeight: FontWeightManager.medium500,
  );
  static TextStyle customTextStyleW2 = TextStyle(
    color: ColorManager.primaryW,
    fontSize: 1.sw > 600 ? 22 : 14,
    fontFamily: 'Nunito Sans',
    fontWeight: FontWeightManager.bold700,
  );
  static TextStyle customTextStyleW3 = TextStyle(
    color: ColorManager.primaryW,
    fontSize: 1.sw > 600 ? 28 : 20,
    fontFamily: 'Londrina Solid',
    fontWeight: FontWeightManager.extraBold800,
  );
  static TextStyle customTextStyleW4 = TextStyle(
    color: ColorManager.primaryW,
    fontSize: 1.sw > 600 ? 20 : 12,
    fontFamily: 'Nunito Sans',
    fontWeight: FontWeightManager.semiBold600,
  );
  static TextStyle customTextStyleW5 = TextStyle(
    color: ColorManager.primaryW2,
    fontSize: 1.sw > 600 ? 20 : 12,
    fontFamily: 'Nunito Sans',
    fontWeight: FontWeightManager.regular400,
  );

//################# Black Styles #################
  static TextStyle customTextStyleBl = TextStyle(
    color: ColorManager.primaryBL,
    fontSize: 1.sw > 600 ? 24 : 16,
    fontFamily: 'Nunito Sans',
    fontWeight: FontWeightManager.regular400,
  );
  static TextStyle customTextStyleBl2 = TextStyle(
    color: ColorManager.primaryBL2,
    fontSize: 1.sw > 600 ? 28 : 20,
    fontFamily: 'Nunito Sans',
    fontWeight: FontWeightManager.bold700,
  );
  static TextStyle customTextStyleBl3 = TextStyle(
    color: ColorManager.primaryBL2,
    fontSize: 1.sw > 600 ? 22 : 14,
    fontFamily: 'Nunito Sans',
    fontWeight: FontWeightManager.regular400,
  );
  static TextStyle customTextStyleBl4 = TextStyle(
    color: ColorManager.primaryBL2,
    fontSize: 1.sw > 600 ? 32 : 24,
    fontFamily: 'Nunito Sans',
    fontWeight: FontWeightManager.bold700,
  );
  static TextStyle customTextStyleBl5 = TextStyle(
    color: ColorManager.primaryBL,
    fontSize: 1.sw > 600 ? 24 : 16,
    fontFamily: 'Nunito Sans',
    fontWeight: FontWeightManager.semiBold600,
  );
  static TextStyle customTextStyleBl6 = TextStyle(
    color: ColorManager.primaryBL2,
    fontSize: 1.sw > 600 ? 26 : 18,
    fontFamily: 'Nunito Sans',
    fontWeight: FontWeightManager.medium500,
  );
  static TextStyle customTextStyleBl7 = TextStyle(
    color: ColorManager.primaryBL3,
    fontSize: 1.sw > 600 ? 20 : 12,
    fontFamily: 'Nunito Sans',
    fontWeight: FontWeightManager.bold700,
  );
  static TextStyle customTextStyleBl8 = TextStyle(
    color: ColorManager.primaryBL2,
    fontSize: 1.sw > 600 ? 24 : 16,
    fontFamily: 'Nunito Sans',
    fontWeight: FontWeightManager.medium500,
  );
  static TextStyle customTextStyleBl9 = TextStyle(
    color: ColorManager.primaryBL2,
    fontSize: 1.sw > 600 ? 20 : 12,
    fontFamily: 'Nunito Sans',
    fontWeight: FontWeightManager.medium500,
  );
  static TextStyle customTextStyleBl10 = TextStyle(
    color: ColorManager.primaryBL2,
    fontSize: 1.sw > 600 ? 20 : 12,
    fontFamily: 'Nunito Sans',
    fontWeight: FontWeightManager.semiBold600,
  );
  static TextStyle customTextStyleBl11 = TextStyle(
    color: ColorManager.primaryBL2,
    fontSize: 1.sw > 600 ? 20 : 12,
    fontFamily: 'Nunito Sans',
    fontWeight: FontWeightManager.regular400,
  );
  static TextStyle customTextStyleBl12 = TextStyle(
    color: ColorManager.primaryBL2,
    fontSize: 1.sw > 600 ? 20 : 12,
    fontFamily: 'Nunito Sans',
    fontWeight: FontWeightManager.regular400,
  );
  static TextStyle customTextStyleBl13 = TextStyle(
    color: ColorManager.primaryBL2,
    fontSize: 1.sw > 600 ? 18 : 10,
    fontFamily: 'Nunito Sans',
    fontWeight: FontWeightManager.regular400,
  );

//################# Blue Styles #################
  static TextStyle customTextStyleB = TextStyle(
    color: ColorManager.primaryB3,
    fontSize: 1.sw > 600 ? 22 : 14,
    fontFamily: 'Nunito Sans',
    fontWeight: FontWeightManager.medium500,
  );
  static TextStyle customTextStyleB2 = TextStyle(
    color: ColorManager.primaryB2,
    fontSize: 1.sw > 600 ? 14 : 10,
    fontFamily: 'Poppins',
    fontWeight: FontWeightManager.semiBold600,
  );
  static TextStyle customTextStyleB3 = TextStyle(
    color: ColorManager.primaryB2,
    fontSize: 1.sw > 600 ? 18 : 10,
    fontFamily: 'Nunito Sans',
    fontWeight: FontWeightManager.medium500,
  );
  static TextStyle customTextStyleB4 = TextStyle(
    color: ColorManager.primaryB2,
    fontSize: 1.sw > 600 ? 26 : 18,
    fontFamily: 'Nunito Sans',
    fontWeight: FontWeightManager.medium500,
  );
  static TextStyle customTextStyleB5 = TextStyle(
    color: ColorManager.primaryB6,
    fontSize: 1.sw > 600 ? 24 : 16,
    fontFamily: 'Nunito Sans',
    fontWeight: FontWeightManager.regular400,
  );

//################# L Styles #################
  static TextStyle customTextStyleL = TextStyle(
    color: ColorManager.primaryL2,
    fontSize: 1.sw > 600 ? 22 : 14,
    fontFamily: 'Nunito Sans',
    fontWeight: FontWeightManager.regular400,
  );
  static TextStyle customTextStyleL2 = TextStyle(
    color: ColorManager.primaryL3,
    fontSize: 1.sw > 600 ? 20 : 12,
    fontFamily: 'Nunito Sans',
    fontWeight: FontWeightManager.medium500,
  );
  static TextStyle customTextStyleL3 = TextStyle(
    color: ColorManager.primaryL,
    fontSize: 1.sw > 600 ? 20 : 12,
    fontFamily: 'Nunito Sans',
    fontWeight: FontWeightManager.medium500,
  );
  static TextStyle customTextStyleL4 = TextStyle(
    color: ColorManager.primaryL,
    fontSize: 1.sw > 600 ? 30 : 22,
    fontFamily: 'Nunito Sans',
    fontWeight: FontWeightManager.bold700,
  );
  static TextStyle customTextStyleL5 = TextStyle(
    fontSize: 1.sw > 600 ? 48 : 40,
    fontWeight: FontWeightManager.bold700,
    color: ColorManager.primaryL,
  );

//################# Grey Styles #################
  static TextStyle customTextStyleG = TextStyle(
    color: ColorManager.primaryG2,
    fontSize: 1.sw > 600 ? 22 : 14,
    fontFamily: 'Nunito Sans',
    fontWeight: FontWeightManager.regular400,
  );
  static TextStyle customTextStyleG2 = TextStyle(
    color: ColorManager.primaryG,
    fontSize: 1.sw > 600 ? 22 : 14,
    fontFamily: 'Nunito Sans',
    fontWeight: FontWeightManager.regular400,
  );
  static TextStyle customTextStyleG3 = TextStyle(
    color: ColorManager.primaryG4,
    fontSize: 1.sw > 600 ? 22 : 14,
    fontFamily: 'Nunito Sans',
    fontWeight: FontWeightManager.regular400,
  );
  static TextStyle customTextStyleG4 = TextStyle(
    color: ColorManager.primaryG5,
    fontSize: 1.sw > 600 ? 22 : 14,
    fontFamily: 'Nunito Sans',
    fontWeight: FontWeightManager.regular400,
  );
  static TextStyle customTextStyleG5 = TextStyle(
    color: ColorManager.primaryG7,
    fontSize: 1.sw > 600 ? 20 : 12,
    fontFamily: 'Nunito Sans',
    fontWeight: FontWeight.w300,
  );
  static TextStyle customTextStyleG6 = TextStyle(
    color: ColorManager.primaryB4,
    fontSize: 1.sw > 600 ? 22 : 14,
    fontFamily: 'Nunito Sans',
    fontWeight: FontWeightManager.regular400,
  );
  static TextStyle customTextStyleG7 = TextStyle(
    color: ColorManager.primaryG9,
    fontSize: 1.sw > 600 ? 18 : 10,
    fontFamily: 'Nunito Sans',
    fontWeight: FontWeightManager.medium500,
  );
  static TextStyle customTextStyleG8 = TextStyle(
    color: ColorManager.primaryG11,
    fontSize: 1.sw > 600 ? 20 : 12,
    fontFamily: 'Nunito Sans',
    fontWeight: FontWeightManager.medium500,
  );
  static TextStyle customTextStyleG9 = TextStyle(
    color: ColorManager.primaryG12,
    fontSize: 1.sw > 600 ? 20 : 12,
    fontFamily: 'Nunito Sans',
    fontWeight: FontWeightManager.medium500,
  );
  static TextStyle customTextStyleG10 = TextStyle(
    color: ColorManager.primaryG13,
    fontSize: 1.sw > 600 ? 24 : 16,
    fontFamily: 'Nunito Sans',
    fontWeight: FontWeightManager.semiBold600,
  );
  static TextStyle customTextStyleG11 = TextStyle(
    color: ColorManager.primaryG14,
    fontSize: 1.sw > 600 ? 20 : 12,
    fontFamily: 'Nunito Sans',
    fontWeight: FontWeightManager.semiBold600,
  );
  static TextStyle customTextStyleG12 = TextStyle(
    color: ColorManager.primaryG7,
    fontSize: 1.sw > 600 ? 16 : 8,
    fontFamily: 'Nunito Sans',
    fontWeight: FontWeightManager.semiBold600,
  );
  static TextStyle customTextStyleG13 = TextStyle(
    color: ColorManager.primaryG18,
    fontSize: 1.sw > 600 ? 18 : 10,
    fontFamily: 'Nunito Sans',
    fontWeight: FontWeightManager.regular400,
  );
  static TextStyle customTextStyleG14 = TextStyle(
    color: ColorManager.primaryG2,
    fontSize: 1.sw > 600 ? 18 : 10,
    fontFamily: 'Nunito Sans',
    fontWeight: FontWeightManager.regular400,
  );
  static TextStyle customTextStyleG15 = TextStyle(
    color: ColorManager.primaryG19,
    fontSize: 1.sw > 600 ? 20 : 12,
    fontFamily: 'Nunito Sans',
    fontWeight: FontWeightManager.regular400,
  );
  static TextStyle customTextStyleG16 = TextStyle(
    color: ColorManager.primaryG13,
    fontSize: 1.sw > 600 ? 19 : 11,
    fontFamily: 'Nunito Sans',
    fontWeight: FontWeightManager.medium500,
  );
  static TextStyle customTextStyleG17 = TextStyle(
    color: ColorManager.primaryG4,
    fontSize: 1.sw > 600 ? 20 : 12,
    fontFamily: 'Nunito Sans',
    fontWeight: FontWeightManager.regular400,
  );
  static TextStyle customTextStyleG18 = TextStyle(
    color: ColorManager.primaryG20,
    fontSize: 1.sw > 600 ? 20 : 12,
    fontFamily: 'Nunito Sans',
    fontWeight: FontWeightManager.medium500,
  );
  static TextStyle customTextStyleG19 = TextStyle(
    color: ColorManager.primaryG20,
    fontSize: 1.sw > 600 ? 18 : 10,
    fontFamily: 'Nunito Sans',
    fontWeight: FontWeightManager.regular400,
  );
  static TextStyle customTextStyleG20 = TextStyle(
    color: ColorManager.primaryG21,
    fontSize: 1.sw > 600 ? 18 : 10,
    fontFamily: 'Nunito Sans',
    fontWeight: FontWeightManager.light300,
  );
  static TextStyle customTextStyleG21 = TextStyle(
    color: ColorManager.primaryG11,
    fontSize: 1.sw > 600 ? 14 : 6,
    fontFamily: 'Nunito Sans',
    fontWeight: FontWeightManager.medium500,
  );
  static TextStyle customTextStyleG22 = TextStyle(
    color: ColorManager.primaryG22,
    fontSize: 1.sw > 600 ? 26 : 18,
    fontFamily: 'Nunito Sans',
    fontWeight: FontWeightManager.medium500,
  );
  static TextStyle customTextStyleG23 = TextStyle(
    color: ColorManager.primaryG22,
    fontSize: 1.sw > 600 ? 20 : 12,
    fontFamily: 'Nunito Sans',
    fontWeight: FontWeightManager.regular400,
  );
  static TextStyle customTextStyleG24 = TextStyle(
    color: ColorManager.primaryG11,
    fontSize: 1.sw > 600 ? 16 : 8,
    fontFamily: 'Nunito Sans',
    fontWeight: FontWeightManager.medium500,
  );

//################# Orange Styles #################
  static TextStyle customTextStyleO = TextStyle(
    color: ColorManager.primaryO,
    fontSize: 1.sw > 600 ? 20 : 12,
    fontFamily: 'Nunito Sans',
    fontWeight: FontWeightManager.semiBold600,
  );
  static TextStyle customTextStyleO2 = TextStyle(
    color: ColorManager.primaryO,
    fontSize: 1.sw > 600 ? 22 : 14,
    fontFamily: 'Nunito Sans',
    fontWeight: FontWeightManager.bold700,
  );
  static TextStyle customTextStyleO3 = TextStyle(
    color: ColorManager.primaryO,
    fontSize: 1.sw > 600 ? 24 : 16,
    fontFamily: 'Nunito Sans',
    fontWeight: FontWeightManager.medium500,
  );
  static TextStyle customTextStyleO4 = TextStyle(
    color: ColorManager.primaryO,
    fontSize: 1.sw > 600 ? 32 : 24,
    fontFamily: 'Nunito Sans',
    fontWeight: FontWeightManager.bold700,
  );
  static TextStyle customTextStyleO5 = TextStyle(
    color: ColorManager.primaryO,
    fontSize: 1.sw > 600 ? 28 : 20,
    fontFamily: 'Nunito Sans',
    fontWeight: FontWeightManager.bold700,
  );
  static TextStyle customTextStyleO6 = TextStyle(
    fontSize: 1.sw > 600 ? 48 : 40,
    fontWeight: FontWeightManager.bold700,
    color: ColorManager.primaryO4,
  );

//################# Green Styles #################
  static TextStyle customTextStyleGR = TextStyle(
    color: ColorManager.primaryGR,
    fontSize: 1.sw > 600 ? 30 : 22,
    fontFamily: 'Nunito Sans',
    fontWeight: FontWeightManager.bold700,
  );

  //################# Date Styles #################
  static TextStyle customDateStyle = TextStyle(
    fontSize: 1.sw > 600 ? 18 : 10,
    fontWeight: FontWeight.bold,
    color: ColorManager.primaryO,
  );

//################# Red Styles #################
  static TextStyle customTextStyleR = TextStyle(
    color: ColorManager.primaryR,
    fontSize: 1.sw > 600 ? 22 : 14,
    fontFamily: 'Nunito Sans',
    fontWeight: FontWeightManager.medium500,
  );
}
