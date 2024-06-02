import '../../lib.dart';

class AppButton {
  static simple({
    required VoidCallback? onTap,
    required String text,
  }) =>
      GestureDetector(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          height: 56.h,
          decoration: BoxDecoration(
            color: AppColors.blackColor,
            borderRadius: BorderRadius.circular(8.r),
          ),
          alignment: Alignment.center,
          child: AppText.commonText(
            text: text,
            color: AppColors.whiteColor,
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
}
