import '../../lib.dart';

class AccountView extends BaseView<AccountController> {
  const AccountView({super.key});

  @override
  PreferredSizeWidget? get appBar => AppBarWidgets.defaultAppBar(
        title: tr("account"),
        onTap: controller.changeLanguage,
      );

  @override
  bool get extendBody => false;

  @override
  void initState(state) {
    super.initState(state);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.getOrders();
    });
  }

  @override
  Widget? get body => Padding(
        padding: AppPaddings.commonHorizontalPadding,
        child: Column(
          children: [
            AppGapVertical.sixteen,

            // name
            AppText.commonText(
              text: AppPreference.instance.getUserModel.name,
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),

            //
            AppGapVertical.eight,

            // email
            AppText.commonText(
              text: AppPreference.instance.getUserModel.email,
            ),

            AppGapVertical.eight,

            // email
            AppText.commonText(
              text: AppPreference.instance.getUserModel.type,
            ),

            // Order
            const OrderView(),

            const Spacer(),

            // logout
            AppButton.simple(
              onTap: controller.logout,
              text: tr("log_out"),
            ),

            AppGapVertical.sixteen,
          ],
        ),
      );
}
