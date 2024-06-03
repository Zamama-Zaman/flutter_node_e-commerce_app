import '../../lib.dart';

class DefaultView extends BaseView<DefaultController> {
  const DefaultView({super.key});

  @override
  Widget? get body => _body;

  Widget get _body => PageView.builder(
        physics: const NeverScrollableScrollPhysics(),
        controller: controller.pageController,
        itemCount: _navScreen.length,
        itemBuilder: (context, index) {
          return _navScreen[index];
        },
      );

  List<Widget> get _navScreen => [
        const HomeView(),
        const CartView(),
        const AccountView(),
      ];

  @override
  Widget? get bottomNavBar => const NavBar();
}
