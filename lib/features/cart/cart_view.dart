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
              AppGapVertical.sixteen,
              _cartList,
              AppGapVertical.fortyEight,
              AppGapVertical.fortyEight,
              AppGapVertical.sixteen,
            ],
          ),
        ),
      );

  Widget get _cartList => controller.listCart == null
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
                      data: controller.cartList[index],
                    ),

                    //
                    AppGapVertical.sixteen,
                  ],
                ),
              ),
            ),
          ],
        );

  Widget _addAndDeleteCard({required CartUIModel data}) => Container(
        width: 150.w,
        height: 60.h,
        color: AppColors.greyColor,
        child: Row(
          children: [
            //* Remove
            InkWell(
              onTap: () {
                data = data.copyWith(
                  quantity: data.quantity != 0 ? data.quantity-- : 1,
                );
                controller.update();
              },
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
              onTap: () {
                data = data.copyWith(
                  quantity: data.quantity++,
                );
                controller.update();
              },
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
