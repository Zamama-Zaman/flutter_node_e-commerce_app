import '../../../lib.dart';

class ProductDetailScreen extends BaseView<ProductController> {
  final Product product;
  const ProductDetailScreen({
    super.key,
    required this.product,
  });

  @override
  PreferredSizeWidget? get appBar =>
      AppBarWidgets.defaultAppBar(title: "Product Detail");

  @override
  Widget get body {
    // final String currentId = AppPreference.instance.getUserModel.id;
    // double myRating = 0.0;
    // //
    // if (product.rating != null) {
    //   for (var singleRating in product.rating!) {
    //     bool isMatched = singleRating.userId == currentId;
    //     if (isMatched) {
    //       myRating = singleRating.rating;
    //     }
    //   }
    // }
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  product.id!,
                ),
                // Stars(
                //   rating: avgRating,
                // ),
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
            padding: EdgeInsets.all(8),
            child: RichText(
              text: TextSpan(
                text: 'Deal Price: ',
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
              text: 'Buy Now',
              onTap: () {},
            ),
          ),
          SizedBox(height: 10.h),
          Padding(
            padding: const EdgeInsets.all(10),
            child: AppButton.simple(
              text: 'Add to Cart',
              onTap: () => controller.addToCart(product: product),
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

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 100.w),
            child: AppButton.simple(
              text: 'Rate this Product',
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
