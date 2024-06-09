import '../../../lib.dart';

class OrdersView extends BaseWidget<AdminController> {
  const OrdersView({super.key});

  @override
  Widget get child => const Center(
        child: Text('Orders View'),
      );
}
