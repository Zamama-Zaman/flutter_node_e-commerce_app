import '../../lib.dart';

class AccountView extends BaseView<AccountController> {
  const AccountView({super.key});

  @override
  Widget? get body => const Center(
        child: Text('Account View'),
      );
}
