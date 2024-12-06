import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gradient_borders/input_borders/gradient_outline_input_border.dart';
import 'package:nilelon/core/resources/color_manager.dart';
import 'package:nilelon/core/resources/const_functions.dart';

class PinCodeView extends StatefulWidget {
  final int length;
  final void Function(String)? onCompleted;

  const PinCodeView({super.key, required this.length, this.onCompleted});

  @override
  _PinCodeViewState createState() => _PinCodeViewState();
}

class _PinCodeViewState extends State<PinCodeView> {
  late List<TextEditingController> _controllers;
  late List<FocusNode> _focusNodes;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(widget.length, (_) => TextEditingController());
    _focusNodes = List.generate(
        widget.length, (_) => FocusNode()); // Unique FocusNode for each field
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(widget.length, (index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: SizedBox(
            height: screenWidth(context, 0.13),
            width: screenWidth(context, 0.13),
            child: KeyboardListener(
              focusNode: _focusNodes[index], // Use the unique FocusNode
              onKeyEvent: (KeyEvent event) {
                if (event is KeyDownEvent &&
                    event.logicalKey == LogicalKeyboardKey.backspace) {
                  if (_controllers[index].text.isEmpty && index > 0) {
                    FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
                    FocusScope.of(context).nextFocus();
                    _controllers[index - 1].clear();
                  }
                }
              },
              child: TextFormField(
                controller: _controllers[index],
                // focusNode: _focusNodes[index], // Use the unique FocusNode
                onChanged: (value) {
                  if (value.length == 1) {
                    if (index < widget.length - 1) {
                      FocusScope.of(context)
                          .requestFocus(_focusNodes[index + 1]);
                      FocusScope.of(context).nextFocus();
                    } else {
                      _submitPin();
                    }
                  }
                },
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Required';
                  }
                  return null;
                },
                showCursor: true,
                enableSuggestions: false,
                autocorrect: false,
                maxLength: 1,
                autofocus: index == 0,
                style: const TextStyle(fontSize: 20),
                decoration: InputDecoration(
                  counterText: '',
                  border: GradientOutlineInputBorder(
                    gradient: const LinearGradient(
                        colors: ColorManager.gradientColors),
                    borderRadius: BorderRadius.circular(12),
                    width: 2,
                  ),
                ),
                keyboardType: TextInputType.text,
                textAlign: TextAlign.center,
                textAlignVertical: TextAlignVertical.top,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(1),
                  // FilteringTextInputFormatter.,
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  void _submitPin() {
    String pin = _controllers.map((controller) => controller.text).join();
    if (widget.onCompleted != null) {
      widget.onCompleted!(pin);
    }
  }
}
