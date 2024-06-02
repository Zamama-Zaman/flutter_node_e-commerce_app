import 'lib.dart';

class AppBinding extends Binding {
  @override
  List<Bind> dependencies() => bindings;

  static List<Bind> bindings = [
    Bind.put(HomeController()),
    Bind.put(AuthController()),
  ];
}
