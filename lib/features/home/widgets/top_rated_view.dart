import 'package:flutter_node_ecommerce_app_original/lib.dart';

class TopRatedView extends BaseWidget<HomeController> {
  const TopRatedView({super.key});

  @override
  Widget get child => Padding(
        padding: AppPaddings.commonHorizontalPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //
            AppText.commonText(
              text: "Top Rated:",
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
            Container(
              alignment: Alignment.topLeft,
              child: Text(
                '\$100',
                style: TextStyle(
                  height: 1.4.h,
                  fontSize: 18.sp,
                ),
              ),
            ),
            Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.only(
                top: 5.w,
                right: 40.h,
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
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: controller.carsoulSliderImages
                    .map(
                      (e) => Padding(
                        padding: EdgeInsets.only(right: 16.w),
                        child: Image.network(
                          e,
                          fit: BoxFit.fill,
                          width: 100.w,
                          height: 50.w,
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),

            AppGapVertical.eight,

            //*
            Container(
              alignment: Alignment.topLeft,
              child: Text(
                'See all deals',
                style: TextStyle(
                  color: Colors.cyan[800],
                ),
              ),
            ),

            //
            AppGapVertical.fortyEight,
          ],
        ),
      );
}
