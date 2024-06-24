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
        return Stack(
          children: [
            child,
            loadingWidget,
          ],
        );
      },
    );
  }

  bool get isLoading => false;

  Widget get loadingWidget => Visibility(
        visible: isLoading,
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: AppColors.blackColor.withOpacity(.3),
          alignment: Alignment.center,
          child: const CircularProgressIndicator(
            color: AppColors.blackColor,
          ),
        ),
      );

  TextDirection get textDirection => Directionality.of(Get.context!);
}
