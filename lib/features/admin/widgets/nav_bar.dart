import '../../../lib.dart';

class AdminNavBar extends BaseWidget<AdminController> {
  const AdminNavBar({super.key});

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
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ...List.generate(
                AdminNavData.data.length,
                (index) {
                  bool isSelected = controller.navSelectedIndex == index;
                  return _navBarBtn(
                    isSelected: isSelected,
                    data: AdminNavData.data[index],
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
    required AdminNavModel data,
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
                      text: controller.isEng ? data.title : data.titleAr,
                      color: AppColors.blackColor,
                    )
                  : AppText.commonText(
                      text: controller.isEng ? data.title : data.titleAr,
                      color: AppColors.greyTextColor,
                    ),

              //
              SizedBox(height: 10.h),
            ],
          ),
        ),
      );
}
