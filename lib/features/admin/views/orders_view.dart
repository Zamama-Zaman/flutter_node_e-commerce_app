import '../../../lib.dart';

class OrdersView extends BaseWidget<AdminController> {
  const OrdersView({super.key});

  @override
  void initStateWidget(state) {
    super.initStateWidget(state);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchAllOrders();
    });
  }

  @override
  Widget get child => Column(
        children: [
          Expanded(
            child: GridView.builder(
              itemCount: controller.orderList!.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16.h,
              ),
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
                      address: controller.orderList![index].deliveryAddress,
                      userId: controller.orderList![index].userDetail.userId,
                      orderedAt: controller.orderList![index].createdAt,
                      status: int.parse(controller.orderList![index].status),
                      totalPrice:
                          double.parse(controller.orderList![index].subTotal),
                    );

                    /// Goto Order Detail Screen
                    Get.to(() => OrderDetailScreen(order: order));
                  },
                  child: SizedBox(
                    height: 140.h,
                    child: SingleProduct(
                      image: controller
                          .orderList![index].cart.first.product.images.first,
                    ),
                  ),
                );
              },
            ),
          ),

          //
          SizedBox(height: 16.h),

          // logout
          Padding(
            padding: AppPaddings.commonAllSidePadding,
            child: AppButton.simple(
              onTap: controller.logout,
              text: tr("log_out"),
            ),
          ),
        ],
      );
}
