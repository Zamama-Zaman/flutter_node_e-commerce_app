import '../../lib.dart';

class DefaultView extends BaseView<DefaultController> {
  const DefaultView({super.key});

  @override
  Widget? get body => const Center(
        child: Text('Default View'),
      );
}
