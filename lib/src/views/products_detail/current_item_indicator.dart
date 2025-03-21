import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';

// used to indicate how many items are on the PageView, and also
// the current item being shown in the viewport.
class CurrentItemIndicator extends StatelessWidget {
  const CurrentItemIndicator({super.key, required this.isCurrentPage});
  final bool isCurrentPage;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 6.0,
      width: isCurrentPage ? 30.0 : 8.0,
      decoration: BoxDecoration(
        color: isCurrentPage ? kPrimaryColor : kPrimarySwatchColor,
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
  }
}
