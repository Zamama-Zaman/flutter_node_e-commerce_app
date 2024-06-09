import '../../lib.dart';

class AdminView extends BaseView<AdminController> {
  const AdminView({super.key});

  @override
  Widget? get body => _body;

  @override
  bool get extendBody => false;

  Widget get _body => PageView.builder(
        physics: const NeverScrollableScrollPhysics(),
        controller: controller.pageController,
        itemCount: _navScreen.length,
        itemBuilder: (context, index) {
          return _navScreen[index];
        },
      );

  List<Widget> get _navScreen => [
        const PostsView(),
        const OrdersView(),
      ];

  @override
  Widget? get bottomNavBar => const AdminNavBar();
}
