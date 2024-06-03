import 'package:flutter_node_ecommerce_app_original/common/common.dart';

import '../../lib.dart';

class HomeView extends BaseView<HomeController> {
  const HomeView({super.key});

  @override
  PreferredSizeWidget? get appBar => AppBarWidgets.searchAppBar(
        controller: controller.searchCtrl,
        onTap: controller.search,
      );

  @override
  Widget? get body => Center(
        child: Column(
          children: [
            //
            AppGapVertical.sixteen,

            //* slider
            const CarouselImage(),

            //
            AppGapVertical.sixteen,

            //*categories item
            Row(
              children: [
                SizedBox(width: 16.w),

                //*
                Column(
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
                        Icons.auto_graph_rounded,
                        color: AppColors.blackColor.withOpacity(.5),
                      ),
                    ),

                    //
                    AppGapVertical.four,

                    //*
                    AppText.commonText(
                      text: "Essiential",
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.blackColor.withOpacity(.5),
                    ),
                  ],
                ),
              ],
            ),

            //* Top category item
          ],
        ),
      );
}
