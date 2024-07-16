import '../../../lib.dart';

class SearchedProductsView extends BaseWidget<HomeController> {
  const SearchedProductsView({super.key});

  @override
  Widget get child => controller.searchedProducts != null &&
          controller.searchedProducts!.isNotEmpty
      ? Column(
          children: [
            ...List.generate(
              controller.searchedProducts!.length,
              (index) {
                return _singleSearchedProduct(
                  product: controller.searchedProducts![index],
                  onTap: () => Get.to(
                    () => ProductDetailScreen(
                      product: controller.searchedProducts![index],
                    ),
                  ),
                );
              },
            ),
          ],
        )
      : Center(
          child: AppText.simpleText(text: "No Product Founded!"),
        );

  Widget _singleSearchedProduct({
    required Product product,
    required VoidCallback onTap,
  }) {
    double avgRating = 0;
    double totalRating = 0;
    for (int i = 0; i < product.rating!.length; i++) {
      totalRating += product.rating![i].rating;
    }
    if (totalRating != 0) {
      avgRating = totalRating / product.rating!.length;
    }
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: AppPaddings.commonHorizontalPadding,
        child: Column(
          children: [
            //
            Row(
              children: [
                AppImage.cacheImage(
                  image: product.images[0],
                  width: 160.w,
                  height: 120.h,
                ),

                //
                SizedBox(width: 8.w),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //
                      AppText.commonText(
                        text: product.name,
                        fontWeight: FontWeight.w600,
                        fontSize: 16.sp,
                      ),

                      //
                      SizedBox(height: 8.h),

                      //
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppText.commonText(
                            text: "${product.price} \$",
                            fontSize: 16.sp,
                          ),

                          //*
                          RatingBar.builder(
                            initialRating: avgRating,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemSize: 16,
                            itemPadding:
                                const EdgeInsets.symmetric(horizontal: 0),
                            itemBuilder: (context, _) => const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (rating) {
                              //
                            },
                          ),
                        ],
                      ),

                      //
                      SizedBox(height: 8.h),

                      AppText.commonText(
                        text: product.description,
                      ),
                    ],
                  ),
                ),

                //
                SizedBox(width: 8.w),
              ],
            ),

            //
            SizedBox(height: 16.h),
          ],
        ),
      ),
    );
  }
}
