import '../../../lib.dart';

class RegistrationView extends BaseView<AuthController> {
  const RegistrationView({super.key});

  @override
  Widget? get body => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //*
            AppText.commonText(
              text: "Registration View",
              fontWeight: FontWeight.bold,
              fontSize: 20.sp,
            ),

            //
            AppGapVertical.sixteen,

            //*
            InkWell(
              onTap: Get.back,
              child: AppText.simpleText(
                text: "SignIn",
                color: AppColors.blackColor,
              ),
            ),
          ],
        ),
      );
}
