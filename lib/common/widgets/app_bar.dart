import '../../lib.dart';

class AppBarWidgets {
  static PreferredSizeWidget defaultAppBar({required String title}) => AppBar(
        title: AppText.commonText(
          text: title,
          fontSize: 18.sp,
          fontWeight: FontWeight.w600,
        ),
        backgroundColor: AppColors.whiteColor,
        centerTitle: true,
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

//* Please add search product here
