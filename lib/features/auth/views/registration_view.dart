import '../../../lib.dart';

class RegistrationView extends BaseView<AuthController> {
  const RegistrationView({super.key});

  @override
  Widget? get body => Center(
        child: Padding(
          padding: AppPaddings.commonHorizontalPadding,
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
              AppGapVertical.fortyEight,

              //*
              AppField.simple(
                controller: controller.regisNameCtrl,
                hintText: "Name here...",
              ),

              //
              AppGapVertical.sixteen,

              //*
              AppField.simple(
                controller: controller.regisEmailCtrl,
                hintText: "Email here...",
              ),

              //
              AppGapVertical.sixteen,

              //*
              AppField.password(
                controller: controller.regisPassCtrl,
                hintText: "Password here...",
                isPassVisible: controller.loginPassVisible,
                onTap: controller.updateRegisPass,
              ),

              //
              AppGapVertical.sixteen,

              //* register Button
              AppButton.simple(
                onTap: controller.register,
                text: "Register",
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
        ),
      );
}
