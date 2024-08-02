import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gradient_borders/input_borders/gradient_outline_input_border.dart';
import 'package:nilelon/resources/color_manager.dart';

Widget textPin(context, TextEditingController controller) {
  return SizedBox(
    height: 100,
    width: 52,
    child: TextFormField(
      onSaved: (pin) {},
      onChanged: (value) {
        if (value.length == 1) {
          FocusScope.of(context).nextFocus();
        }
      },
      validator: (value) {
        if (value!.isEmpty) {
          return 'Required';
        }
        return null;
      },
      showCursor: false,
      enableSuggestions: false,
      controller: controller,
      autocorrect: false,
      maxLength: 1,
      autofocus: true,
      style: const TextStyle(fontSize: 20),
      decoration: InputDecoration(
        counterText: '',
        border: GradientOutlineInputBorder(
          gradient: const LinearGradient(colors: ColorManager.gradientColors),
          borderRadius: BorderRadius.circular(12),
          width: 2,
        ),
      ),
      keyboardType: TextInputType.text,
      textAlign: TextAlign.center,
      textAlignVertical: TextAlignVertical.top,
      inputFormatters: [
        LengthLimitingTextInputFormatter(1),
      ],
    ),
  );
}
