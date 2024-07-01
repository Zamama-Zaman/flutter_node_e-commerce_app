import '../../../lib.dart';

class OrderView extends BaseWidget<AccountController> {
  const OrderView({super.key});

  @override
  Widget get child => Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //
              Text(
                'Your Orders',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),

              //
              const Text(
                'See all',
                style: TextStyle(
                  color: AppColors.greyTextColor,
                ),
              ),
            ],
          ),

          AppGapVertical.sixteen,

          // display orders
          controller.orderList == null && controller.orderList!.isEmpty
              ? Center(
                  child: AppText.simpleText(text: "Not Card Added Yet!"),
                )
              : Container(
                  height: 170.h,
                  padding: EdgeInsets.only(left: 10.w),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: controller.orderList!.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          // Goto Product Detail Page
                          Product product = Product(
                            name: "",
                            description: "",
                            quantity: 1,
                            images: [],
                            category: "",
                            price: 1,
                            id: "Something",
                            rating: [],
                          );
                          Get.to(() => ProductDetailScreen(product: product));

                          // Order order = Order(
                          //   id: "",
                          //   products: [],
                          //   quantity: [],
                          //   address: "",
                          //   userId: "",
                          //   orderedAt: 1,
                          //   status: 1,
                          //   totalPrice: 20,
                          // );
                          // Get.to(() => OrderDetailScreen(order: order));
                        },
                        child: SingleProduct(
                          image: controller
                              .orderList!.first.cart.first.product.images.first,
                        ),
                      );
                    },
                  ),
                ),
        ],
      );
}
