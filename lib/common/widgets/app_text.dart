import '../../lib.dart';

class AppText {
  /// 14 400
  static simpleText({
    required String text,
    Color? color,
  }) =>
      Text(
        text,
        style: TextStyle(
          height: 1.4.h,
          color: color ?? AppColors.greyColor,
          fontWeight: FontWeight.w400,
          fontSize: 14.sp,
        ),
      );

  static Text commonText({
    required String text,
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
    String? fontFamily,
    TextDecoration? decoration,
    FontStyle? fontStyle,
    double? height,
  }) =>
      Text(
        text,
        style: TextStyle(
          color: color ?? AppColors.blackColor,
          fontSize: fontSize ?? 14.0,
          fontWeight: fontWeight ?? FontWeight.w400,
          decoration: decoration,
          fontStyle: fontStyle,
          height: height ?? 1.4,
        ),
      );
}
