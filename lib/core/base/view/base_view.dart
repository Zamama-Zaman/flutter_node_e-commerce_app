import '../../../lib.dart';

abstract class BaseView<T extends BaseController> extends GetView<T> {
  const BaseView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<T>(
      init: controller,
      initState: initState,
      dispose: disposeState,
      builder: (_) {
        return Scaffold(
          backgroundColor: backgroundColor,
          appBar: appBar,
          body: _body,
          bottomNavigationBar: _bottomNavBar,
          extendBody: extendBody,
          floatingActionButton: floatingActionBtn,
        );
      },
    );
  }

  void initState(state) {}

  void disposeState(state) {}

  Widget? get body;

  Widget? get _body =>
      body ??
      const Center(
        child: Text("Base View"),
      );

  bool get extendBody => true;

  Color? get backgroundColor => null;

  String? get title => null;

  PreferredSizeWidget? get appBar => null;

  Widget? get trailing => null;

  Widget? get bottomNavBar => null;

  Widget? get _bottomNavBar => bottomNavBar;

  Widget? get floatingActionBtn => null;
}
