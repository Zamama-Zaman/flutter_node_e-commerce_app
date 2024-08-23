import '../../../lib.dart';

abstract class BaseController extends GetxController {
  bool get isEng => Get.context!.locale.toString() == 'en';
  bool get isArabic => Get.context!.locale.toString() == 'ar';
  String get getLocale =>
      Get.context != null ? Get.context!.locale.toString() : "en";
}
