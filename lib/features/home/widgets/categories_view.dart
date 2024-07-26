import '../views/category_detail_view.dart';
import '../../../lib.dart';

class CategoriesView extends BaseWidget<HomeController> {
  const CategoriesView({super.key});

  @override
  Widget get child => Row(
        children: [
          SizedBox(width: 16.w),
          ...List.generate(
            controller.categoryData.length,
            (index) => InkWell(
              onTap: () => Get.to(
                () => CategoryDetailView(
                  category: controller.categoryData[index].name,
                ),
              ),
              child: SizedBox(
                width: 80.w,
                height: 80.h,
                child: Column(
                  children: [
                    //*
                    Container(
                      width: 50.w,
                      height: 50.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.greyColor.withOpacity(.3),
                      ),
                      alignment: Alignment.center,
                      child: Icon(
                        controller.categoryData[index].icon,
                        color: AppColors.blackColor.withOpacity(.5),
                      ),
                    ),

                    //
                    AppGapVertical.four,

                    //*
                    AppText.commonText(
                      text: controller.categoryData[index].name,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.blackColor.withOpacity(.5),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      );
}
