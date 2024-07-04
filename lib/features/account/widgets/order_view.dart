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
          controller.orderList == null || controller.orderList!.isEmpty
              ? SizedBox(
                  height: 170.h,
                  child: Center(
                    child: AppText.commonText(
                      text: "No Product Ordered Yet!",
                      color: AppColors.blackColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 18.sp,
                    ),
                  ),
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
                            orderedAt: controller.orderList![index].createdAt,
                            status:
                                int.parse(controller.orderList![index].status),
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
