import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

void showToast(String message) {
  BotToast.showText(text: message);
}

double screenWidth(context, double widthP) {
  return MediaQuery.of(context).size.width * widthP;
}

double screenHeight(context, double heightP) {
  return MediaQuery.of(context).size.height * heightP;
}