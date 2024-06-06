import '../../lib.dart';

class AppBarWidgets {
  static PreferredSizeWidget defaultAppBar() => PreferredSize(
        preferredSize: Size(double.infinity, 70.h),
        child: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              border: Border(
                bottom: BorderSide(
                  color: AppColors.dividerColor,
                  width: 1.0.w,
                ),
              ),
            ),
            padding: AppPaddings.largeHorizontalPadding,
            alignment: Alignment.center,
            child: Row(
              children: [
                //* profile image
                Container(
                  width: 37.w,
                  height: 37.h,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    shape: BoxShape.circle,
                  ),
                  child: AppImage.asset(
                    image: AppImages.profileImage,
                    fit: BoxFit.contain,
                  ),
                ),

                //
                SizedBox(width: 11.w),

                //*
                AppText.simpleText(text: "Hello Kevin!"),

                //
                const Spacer(),

                //* Icon
                InkWell(
                  onTap: null,
                  child: AppSvgImage(
                    assetName: AppSvgs.homeIcon,
                    width: 23.w,
                    height: 28.h,
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  static PreferredSizeWidget searchAppBar({
    required TextEditingController controller,
    required VoidCallback onTap,
  }) =>
      PreferredSize(
        preferredSize: Size.fromHeight(76.h),
        child: SafeArea(
          child: Padding(
            padding: AppPaddings.commonHorizontalPadding,
            child: Column(
              children: [
                //
                AppGapVertical.sixteen,

                //*
                Row(
                  children: [
                    //*
                    Expanded(
                      child: AppField.search(
                        controller: controller,
                        hintText: "Search Here...",
                      ),
                    ),

                    //
                    SizedBox(width: 16.w),

                    //*
                    IconButton(
                      onPressed: onTap,
                      icon: const Icon(
                        Icons.search,
                        color: AppColors.greyTextColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
}
