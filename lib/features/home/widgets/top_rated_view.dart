import 'package:flutter_node_ecommerce_app_original/lib.dart';

class TopRatedView extends BaseWidget<HomeController> {
  const TopRatedView({super.key});

  @override
  void initStateWidget(state) {
    super.initStateWidget(state);
    controller.topRatedProductsFetch();
  }

  @override
  Widget get child => Padding(
        padding: AppPaddings.commonHorizontalPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //
            AppText.commonText(
              text: tr("top_rated"),
              fontSize: 20.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.blackColor,
            ),

            //
            AppGapVertical.sixteen,

            //*
            Image.network(
              "https://m.media-amazon.com/images/I/71YTsbTxBsL._SX3000_.jpg",
              height: 235.h,
              fit: BoxFit.fitHeight,
            ),

            //
            AppGapVertical.eight,

            //*
            Text(
              '\$100',
              style: TextStyle(
                height: 1.4.h,
                fontSize: 18.sp,
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                top: 5.h,
                right: controller.isArabic ? 0.w : 40.w,
                left: controller.isArabic ? 40.w : 0.w,
              ),
              child: const Text(
                'Iphone',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),

            //
            AppGapVertical.sixteen,

            //*
            controller.topRatedProductsList != null &&
                    controller.topRatedProductsList!.isNotEmpty
                ? SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: controller.topRatedProductsList!
                          .map(
                            (e) => Padding(
                              padding: EdgeInsets.only(right: 16.w),
                              child: InkWell(
                                onTap: () {
                                  Get.to(() => ProductDetailScreen(product: e));
                                },
                                child: AppImage.cacheImage(
                                  image: e.images[0],
                                  fit: BoxFit.fill,
                                  width: 100.w,
                                  height: 50.w,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  )
                : const Center(
                    child: Text("No Top Rated Products added Yet!"),
                  ),

            AppGapVertical.eight,

            //*
            Text(
              tr('see_all_deals'),
              style: TextStyle(
                color: Colors.cyan[800],
              ),
            ),

            //
            AppGapVertical.fortyEight,
          ],
        ),
      );
}
