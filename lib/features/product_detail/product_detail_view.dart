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
                  builder: (BuildContext context) => Image.network(
                    i,
                    fit: BoxFit.contain,
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
              onTap: controller.addToCart,
            ),
          ),

          //
          SizedBox(height: 10.h),

          //
          Container(
            color: Colors.black12,
            height: 5.h,
          ),

          //*
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
              'Rate The Product',
              style: TextStyle(
                fontSize: 22.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          //*
          // RatingBar.builder(
          //   initialRating: myRating,
          //   minRating: 1,
          //   direction: Axis.horizontal,
          //   allowHalfRating: true,
          //   itemCount: 5,
          //   itemPadding: const EdgeInsets.symmetric(horizontal: 4),
          //   itemBuilder: (context, _) => Icon(
          //     Icons.star,
          //     color: AppColors.secondaryColor,
          //   ),
          //   onRatingUpdate: (rating) {
          //     // productDetailsServices.rateProduct(
          //     //   context: context,
          //     //   product: widget.product,
          //     //   rating: rating,
          //     // );
          //   },
          // )
        ],
      ),
    );
  }
}
