import 'package:flutter/material.dart';
import 'package:nilelon/resources/color_manager.dart';

class StepIndicator extends StatelessWidget {
  final int totalSteps;
  final int currentStep;

  const StepIndicator(
      {super.key, required this.totalSteps, required this.currentStep});

  @override
  Widget build(BuildContext context) {
    List<Widget> steps = [];

    for (int i = 1; i <= totalSteps; i++) {
      steps.add(
        i <= currentStep
            ? Container(
                width: 25,
                height: 25,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                      colors: i - 1 <= currentStep
                          ? ColorManager.gradientColors2
                          : [
                              ColorManager.primaryB,
                              ColorManager.primaryB,
                            ]),
                ),
                child: const Center(
                  child: Icon(Icons.check, color: Colors.white, size: 18),
                ),
              )
            : Container(
                width: 25,
                height: 25,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                      colors: i - 1 <= currentStep
                          ? ColorManager.gradientColors2
                          : [
                              ColorManager.primaryB,
                              ColorManager.primaryB,
                            ]),
                ),
              ),
      );
      if (i < totalSteps) {
        steps.add(
          Expanded(
            child: Container(
              height: 4,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: i <= currentStep
                        ? ColorManager.gradientColors3
                        : [
                            ColorManager.primaryB,
                            ColorManager.primaryB,
                          ]),
              ),
            ),
          ),
        );
      }
    }
    return Row(
      children: steps,
    );
  }
}
