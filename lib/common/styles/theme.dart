import '../../lib.dart';

class AppTheme {
  static ThemeData baseTheme = ThemeData(
    dividerColor: AppColors.dividerColor,
    useMaterial3: true,
    colorScheme: ColorScheme.fromSwatch(
      backgroundColor: AppColors.whiteColor,
      primarySwatch: const MaterialColor(
        0xffF5F5F5,
        {
          50: Color(0xffF5F5F5),
          100: Color(0xffF5F5F5),
          200: Color(0xffF5F5F5),
          300: Color(0xffF5F5F5),
          400: Color(0xffF5F5F5),
          500: Color(0xffF5F5F5),
          600: Color(0xffF5F5F5),
          700: Color(0xffF5F5F5),
          800: Color(0xffF5F5F5),
          900: Color(0xffF5F5F5),
        },
      ),
    ).copyWith(
      secondary: AppColors.blackColor,
      tertiary: AppColors.blackColor,
      outline: const Color(0xFF000000),
    ),
    scaffoldBackgroundColor: AppColors.whiteColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.blackColor,
      centerTitle: true,
    ),
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: Colors.black,
    ),
    indicatorColor: const Color(0xFF000000),
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w300,
      ),
      filled: true,
      fillColor: AppColors.whiteColor,
      border: OutlineInputBorder(
        borderSide: const BorderSide(
          color: AppColors.blackColor,
        ),
        borderRadius: BorderRadius.all(Radius.circular(8.r)),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: AppColors.blackColor,
        ),
        borderRadius: BorderRadius.all(Radius.circular(8.r)),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: AppColors.blackColor,
        ),
        borderRadius: BorderRadius.all(Radius.circular(8.r)),
      ),
      disabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: AppColors.blackColor,
        ),
        borderRadius: BorderRadius.all(Radius.circular(8.r)),
      ),
      constraints: BoxConstraints(
        maxHeight: 56.h,
      ),
    ),
  );
}
