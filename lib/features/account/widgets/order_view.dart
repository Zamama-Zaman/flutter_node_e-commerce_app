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
                          // Product product = Product(
                          //   name: "",
                          //   description: "",
                          //   quantity: 1,
                          //   images: [],
                          //   category: "",
                          //   price: 1,
                          //   id: "Something",
                          //   rating: [],
                          // );
                          // Get.to(() => ProductDetailScreen(product: product));
                          List<Product> product = [];
                          for (var cart in controller.orderList![index].cart) {
                            product.add(cart.product);
                          }

                          List<int> quantity = [];
                          for (var singleQuantity
                              in controller.orderList![index].cart) {
                            quantity.add(singleQuantity.quantity);
                          }

                          Order order = Order(
                            id: controller.orderList![index].id,
                            products: product,
                            quantity: quantity,
                            address:
                                controller.orderList![index].deliveryAddress,
                            userId:
                                controller.orderList![index].userDetail.userId,
                            orderedAt: 1,
                            status: 1,
                            totalPrice: double.parse(
                                controller.orderList![index].subTotal),
                          );
                          Get.to(() => OrderDetailScreen(order: order));
                        },
                        child: SingleProduct(
                          image: controller.orderList![index].cart.first.product
                              .images.first,
                        ),
                      );
                    },
                  ),
                ),
        ],
      );
}
