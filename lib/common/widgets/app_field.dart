import '../../lib.dart';

class AppField {
  static simple({
    required TextEditingController controller,
    required String hintText,
  }) =>
      TextFormField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          border: InputBorder.none,
        ),
      );

  static password({
    required TextEditingController controller,
    required String hintText,
    required bool isPassVisible,
    required VoidCallback? onTap,
  }) =>
      TextFormField(
        controller: controller,
        obscureText: isPassVisible,
        decoration: InputDecoration(
          hintText: hintText,
          border: InputBorder.none,
          suffixIcon: IconButton(
            onPressed: onTap,
            icon: Icon(
              isPassVisible ? Icons.visibility_off : Icons.visibility,
            ),
          ),
        ),
      );

  static search({
    required TextEditingController controller,
    required String hintText,
  }) =>
      TextFormField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(
            color: AppColors.greyTextColor,
          ),
          border: InputBorder.none,
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: AppColors.greyColor,
            ),
            borderRadius: BorderRadius.all(Radius.circular(8.r)),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: AppColors.greyColor,
            ),
            borderRadius: BorderRadius.all(Radius.circular(8.r)),
          ),
        ),
      );
}
