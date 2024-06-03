import '../../lib.dart';

class CartView extends BaseView<CartController>{
  const CartView({super.key});

  @override
  Widget? get body => const Center(child: Text('Cart View'),);
}