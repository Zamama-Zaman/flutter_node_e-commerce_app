import '../../../lib.dart';

class ProductDetailScreen extends BaseView<ProductController> {
  final Product product;
  const ProductDetailScreen({
    super.key,
    required this.product,
  });

  @override
  void initState(state) {
    super.initState(state);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.initFunction(product: product);
    });
  }

  @override
  PreferredSizeWidget? get appBar =>
      AppBarWidgets.defaultAppBar(title: tr("product_detail"));

  @override
  Widget get body {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("${tr("product_id")} ${product.id!}"),
          ),

          //
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppText.commonText(
                  text: tr("average_rating"),
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
                //*
                RatingBar.builder(
                  initialRating: controller.avgRating,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemSize: 16,
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    ///
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: 20.w,
              horizontal: 10.h,
            ),
            child: Text(
              product.name,
              style: TextStyle(
                fontSize: 15.sp,
              ),
            ),
          ),
          CarouselSlider(
            items: product.images.map(
              (i) {
                return Builder(
                  builder: (BuildContext context) => AppImage.cacheImage(
                    image: i,
                    height: 200.h,
                  ),
                );
              },
            ).toList(),
            options: CarouselOptions(
              viewportFraction: 1,
              height: 300.h,
            ),
          ),
          SizedBox(height: 10.h),
          Container(
            color: Colors.black12,
            height: 5.h,
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: RichText(
              text: TextSpan(
                text: '${tr('deal_price')} ',
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                children: [
                  TextSpan(
                    text: '\$${product.price}',
                    style: TextStyle(
                      fontSize: 22.sp,
                      color: Colors.red,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(product.description),
          ),
          Container(
            color: Colors.black12,
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: AppButton.simple(
              text: tr('buy_now'),
              onTap: () {},
            ),
          ),
          SizedBox(height: 10.h),
          Padding(
            padding: const EdgeInsets.all(10),
            child: AppButton.simple(
              text: tr('add_to_cart'),
              onTap: () => controller.addToCart(),
            ),
          ),

          //
          SizedBox(height: 10.h),

          //
          Container(
            color: Colors.black12,
            height: 5.h,
          ),

          AppGapVertical.thirtyTwo,

          controller.myRating != 0
              ? Padding(
                  padding: AppPaddings.commonHorizontalPadding,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //
                      AppText.commonText(
                        text: tr("you_rated"),
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),

                      //
                      RatingBar.builder(
                        initialRating: controller.myRating,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemSize: 16,
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {
                          ///
                        },
                      )
                    ],
                  ),
                )
              : Padding(
                  padding: EdgeInsets.symmetric(horizontal: 100.w),
                  child: AppButton.simple(
                    text: tr('rate_this_product'),
                    onTap: () {
                      Get.bottomSheet(
                        RateBottomSheet(product: product),
                        backgroundColor: Colors.white,
                        isScrollControlled: true,
                      );
                    },
                  ),
                ),
        ],
      ),
    );
  }
}
