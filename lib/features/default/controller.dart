import '../../lib.dart';

class DefaultController extends BaseController {
  static final instance = Get.find<DefaultController>();

  PageController pageController = PageController();
  int navSelectedIndex = 0;
  void navSelected(int index) {
    navSelectedIndex = index;
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeIn,
    );
    update();
  }
}
