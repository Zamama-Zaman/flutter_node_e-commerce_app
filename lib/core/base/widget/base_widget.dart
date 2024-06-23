import '../../../lib.dart';

abstract class BaseWidget<T extends BaseController> extends GetWidget<T> {
  const BaseWidget({super.key});

  void initStateWidget(state) {}

  Widget get child;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<T>(
      initState: initStateWidget,
      builder: (_) {
        return child;
      },
    );
  }

  TextDirection get textDirection => Directionality.of(Get.context!);
}
