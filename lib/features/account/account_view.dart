import '../../lib.dart';

class AccountView extends BaseView<AccountController> {
  const AccountView({super.key});

  @override
  PreferredSizeWidget? get appBar =>
      AppBarWidgets.defaultAppBar(title: "Account");

  @override
  bool get extendBody => false;

  @override
  Widget? get body => Padding(
        padding: AppPaddings.commonHorizontalPadding,
        child: Column(
          children: [
            AppGapVertical.sixteen,

            // name
            AppText.commonText(
              text: "Arbab Khan",
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),

            //
            AppGapVertical.eight,

            // email
            AppText.commonText(
              text: "Email@gmail.com",
            ),

            // Order
            const OrderView(),

            const Spacer(),

            // logout
            AppButton.simple(
              onTap: null,
              text: "Logout",
            ),

            AppGapVertical.sixteen,
          ],
        ),
      );
}
