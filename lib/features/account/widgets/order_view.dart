import 'package:flutter_node_ecommerce_app_original/features/account/widgets/order_detail_view.dart';

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
          Container(
            height: 170.h,
            padding: EdgeInsets.only(left: 10.w),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: HomeController.instance.carsoulSliderImages.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    // Goto Product Detail Page
                    Order order = Order(
                      id: "",
                      products: [],
                      quantity: [],
                      address: "",
                      userId: "",
                      orderedAt: 1,
                      status: 1,
                      totalPrice: 20,
                    );
                    Get.to(() => OrderDetailScreen(order: order));
                  },
                  child: SingleProduct(
                    image: HomeController.instance.carsoulSliderImages[index],
                  ),
                );
              },
            ),
          ),
        ],
      );
}
