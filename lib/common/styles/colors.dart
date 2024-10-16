import '../../lib.dart';

class AppColors {
  static const dividerColor = Color(0xFFEEEEF4);
  static const whiteColor = Color(0xFFFFFFFF);
  static const blackColor = Color(0xFF130F26);
  static const greyColor = Color(0xFFB7B7B7);
  static const outlineColor = Color(0xFFE7E7EB);
  static const greyTextColor = Color(0xFF8C919D);
}

class StepColors {
  static const stepStyle = StepStyle(
    color: AppColors.blackColor,
    connectorColor: AppColors.greyColor,
    errorColor: AppColors.blackColor,
  );
}
