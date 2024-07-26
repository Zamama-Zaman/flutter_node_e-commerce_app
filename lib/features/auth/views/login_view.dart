import '../../../lib.dart';

class LoginView extends BaseView<AuthController> {
  const LoginView({super.key});

  @override
  Widget? get body => Center(
        child: Padding(
          padding: AppPaddings.commonHorizontalPadding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppText.commonText(
                text: Get.context!.tr("login"), // "Login View",
                fontWeight: FontWeight.bold,
                fontSize: 20.sp,
              ),

              //
              AppGapVertical.fortyEight,

              //*
              AppField.simple(
                controller: controller.loginEmailCtrl,
                hintText: "Email here...",
              ),

              AppGapVertical.sixteen,

              AppField.password(
                controller: controller.loginPassCtrl,
                hintText: "Password here...",
                isPassVisible: controller.loginPassVisible,
                onTap: controller.updateLoginPass,
              ),

              AppGapVertical.sixteen,

              //* login Button
              AppButton.simple(
                onTap: controller.login,
                text: "Login",
              ),

              AppGapVertical.sixteen,

              InkWell(
                onTap: () => Get.to(() => const RegistrationView()),
                child: AppText.simpleText(
                  text: "SignUp",
                  color: AppColors.blackColor,
                ),
              ),
            ],
          ),
        ),
      );
}
