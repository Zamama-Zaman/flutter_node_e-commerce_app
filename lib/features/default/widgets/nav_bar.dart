import '../../../lib.dart';

class NavBar extends BaseWidget<DefaultController> {
  const NavBar({super.key});

  @override
  Widget get child => SafeArea(
        child: Container(
          width: double.infinity,
          height: 84.h,
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            border: Border.all(
              color: AppColors.outlineColor,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ...List.generate(
                NavData.data.length,
                (index) {
                  bool isSelected = controller.navSelectedIndex == index;
                  return _navBarBtn(
                    isSelected: isSelected,
                    data: NavData.data[index],
                    onTap: () => controller.navSelected(index),
                  );
                },
              ),
            ],
          ),
        ),
      );

  Widget _navBarBtn({
    required bool isSelected,
    required NavModel data,
    required VoidCallback onTap,
  }) =>
      GestureDetector(
        onTap: onTap,
        child: Container(
          height: double.infinity,
          //* This box decoration is important Don't remove it
          decoration: const BoxDecoration(),
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Column(
            children: [
              //*
              isSelected
                  ? Container(
                      width: 28.w,
                      height: 2.h,
                      decoration: const BoxDecoration(
                        color: AppColors.blackColor,
                      ),
                    )
                  : SizedBox(width: 28.w),

              //
              const Spacer(),

              //*
              Icon(
                data.icon,
                color:
                    isSelected ? AppColors.blackColor : AppColors.greyTextColor,
              ),

              //
              SizedBox(height: 8.h),

              //*
              isSelected
                  ? AppText.simpleText(
                      text: data.title,
                      color: AppColors.blackColor,
                    )
                  : AppText.commonText(
                      text: data.title,
                      color: AppColors.greyTextColor,
                    ),

              //
              SizedBox(height: 10.h),
            ],
          ),
        ),
      );
}
