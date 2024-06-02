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
}
