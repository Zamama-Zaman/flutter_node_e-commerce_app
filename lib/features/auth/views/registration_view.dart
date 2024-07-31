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
                text: tr("registration_view"),
                fontWeight: FontWeight.bold,
                fontSize: 20.sp,
              ),

              //
              AppGapVertical.fortyEight,

              //*
              AppField.simple(
                controller: controller.regisNameCtrl,
                hintText: tr("name_here"),
              ),

              //
              AppGapVertical.sixteen,

              //*
              AppField.simple(
                controller: controller.regisEmailCtrl,
                hintText: tr("email_here"),
              ),

              //
              AppGapVertical.sixteen,

              //*
              AppField.password(
                controller: controller.regisPassCtrl,
                hintText: tr("password_here"),
                isPassVisible: controller.loginPassVisible,
                onTap: controller.updateRegisPass,
              ),

              //
              AppGapVertical.sixteen,

              //* register Button
              AppButton.simple(
                onTap: controller.register,
                text: tr("register"),
              ),

              //
              AppGapVertical.sixteen,

              //*
              InkWell(
                onTap: Get.back,
                child: AppText.simpleText(
                  text: tr("signIn"),
                  color: AppColors.blackColor,
                ),
              ),
            ],
          ),
        ),
      );
}
