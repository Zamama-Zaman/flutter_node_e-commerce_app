import '../../../lib.dart';

class NavData {
  static List<NavModel> get data => [
        NavModel(title: tr("home"), icon: Icons.home),
        NavModel(title: tr("cart"), icon: Icons.shopping_cart_outlined),
        NavModel(title: tr("account"), icon: Icons.account_box_outlined),
      ];
}
