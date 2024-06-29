import '../../common/models/cart_model.dart';
import '../../lib.dart';

class CartView extends BaseView<CartController> {
  const CartView({super.key});

  @override
  PreferredSizeWidget? get appBar => AppBarWidgets.defaultAppBar(title: "Cart");

  @override
  void initState(state) {
    super.initState(state);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.getCart();
    });
  }

  @override
  Widget? get body => SingleChildScrollView(
        child: Padding(
          padding: AppPaddings.commonHorizontalPadding,
          child: Column(
            children: [
              const AddressBox(),
              const CartSubtotal(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: AppButton.simple(
                  text:
                      'Proceed to Buy (${AppPreference.instance.getUserModel.cart.length} items)',
                  onTap: () => Get.to(() => const AddressView()),
                ),
              ),
              SizedBox(height: 15.w),
              Container(
                color: Colors.black12.withOpacity(0.08),
                height: 1.h,
              ),
              SizedBox(height: 5.h),
              AppGapVertical.sixteen,
              _cartList,
              AppGapVertical.fortyEight,
              AppGapVertical.fortyEight,
              AppGapVertical.sixteen,
            ],
          ),
        ),
      );

  Widget get _cartList => controller.listCart == null ||
          controller.listCart!.isEmpty
      ? Center(
          child: AppText.commonText(
            text: "No item added yet in cart!",
            fontSize: 18.sp,
            fontWeight: FontWeight.w500,
          ),
        )
      : Column(
          children: [
            ...List.generate(
              controller.listCart!.length,
              (index) => SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //*
                    Row(
                      children: [
                        Image.network(
                          controller.listCart![index].product.images[0],
                          fit: BoxFit.contain,
                          height: 135,
                          width: 135,
                        ),

                        //
                        Column(
                          children: [
                            //*
                            Container(
                              width: 235.w,
                              padding: EdgeInsets.symmetric(horizontal: 10.w),
                              child: Text(
                                controller.listCart![index].product.name,
                                style: TextStyle(
                                  fontSize: 16.sp,
                                ),
                                maxLines: 2,
                              ),
                            ),

                            //*
                            Container(
                              width: 235.w,
                              padding: EdgeInsets.only(left: 10.w, top: 5.h),
                              child: Text(
                                '\$${controller.listCart![index].product.price}',
                                style: TextStyle(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 2,
                              ),
                            ),

                            //*
                            Container(
                              width: 235.w,
                              padding: EdgeInsets.only(left: 10.w),
                              child: const Text('Eligible for FREE Shipping'),
                            ),

                            //*
                            Container(
                              width: 235.w,
                              padding: EdgeInsets.only(left: 10.w, top: 5.h),
                              child: const Text(
                                'In Stock',
                                style: TextStyle(
                                  color: Colors.teal,
                                ),
                                maxLines: 2,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    //
                    AppGapVertical.eight,
                    const Divider(
                      color: AppColors.dividerColor,
                    ),
                    AppGapVertical.eight,

                    //*
                    _addAndDeleteCard(
                      data: controller.listCart![index],
                    ),

                    //
                    AppGapVertical.sixteen,
                  ],
                ),
              ),
            ),
          ],
        );

  Widget _addAndDeleteCard({required CartModel data}) => Container(
        width: 150.w,
        height: 60.h,
        color: AppColors.greyColor,
        child: Row(
          children: [
            //* Remove
            InkWell(
              onTap: () => controller.removeFromCart(data: data),
              child: Container(
                width: 50.w,
                height: 50.h,
                alignment: Alignment.center,
                child: const Icon(Icons.remove),
              ),
            ),

            //*
            Container(
              width: 50.w,
              height: 50.h,
              color: AppColors.whiteColor,
              alignment: Alignment.center,
              child: AppText.commonText(
                text: data.quantity.toString(),
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
            ),

            //* Add
            InkWell(
              onTap: () => controller.addToCart(data: data),
              child: Container(
                width: 50.w,
                height: 50.h,
                alignment: Alignment.center,
                child: const Icon(Icons.add),
              ),
            ),
          ],
        ),
      );
}
