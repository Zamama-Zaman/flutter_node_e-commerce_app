import 'lib.dart';

class AppBinding extends Binding {
  @override
  List<Bind> dependencies() => bindings;

  static List<Bind> bindings = [
    Bind.put(HomeController()),
    Bind.put(AuthController()),
    Bind.put(DefaultController()),
    Bind.put(CartController()),
    Bind.put(AccountController()),
    Bind.put(AdminController()),
    Bind.put(ProductController()),
    Bind.put(OrderController()),
    Bind.put(AddressController()),
  ];
}
