import '../../../lib.dart';

class OrderDetailScreen extends BaseView<OrderController> {
  final Order order;
  const OrderDetailScreen({
    super.key,
    required this.order,
  });

  @override
  void initState(state) {
    super.initState(state);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.initFunction(order: order);
    });
  }

  @override
  PreferredSizeWidget? get appBar => AppBarWidgets.defaultAppBar(
        title: tr("order_detail"),
      );

  @override
  Widget? get body {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              tr('view_order_detail'),
              style: TextStyle(
                fontSize: 22.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(10.w),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black12,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${tr("order_date")}      ${DateFormat().format(
                    DateTime.parse(order.orderedAt),
                  )}'),
                  Text('${tr("order_id")}          ${order.id}'),
                  Text('${tr("order_total")}      \$${order.totalPrice}'),
                ],
              ),
            ),
            SizedBox(height: 10.h),
            Text(
              tr('purchase_detail'),
              style: TextStyle(
                fontSize: 22.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black12,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  for (int i = 0; i < order.products.length; i++)
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 20.h),
                          child: AppImage.cacheImage(
                            image: order.products[i].images[0],
                            height: 120.h,
                            width: 120.w,
                          ),
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                order.products[i].name,
                                style: TextStyle(
                                  fontSize: 17.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                'Qty: ${order.quantity[i]}',
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
            SizedBox(height: 10.h),

            //
            Text(
              tr('tracking'),
              style: TextStyle(
                fontSize: 22.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black12,
                ),
              ),
              child: Stepper(
                currentStep: controller.currentStep,
                connectorColor:
                    WidgetStateColor.resolveWith((_) => AppColors.blackColor),
                controlsBuilder: (context, details) {
                  if (AppPreference.instance.getUserModel.type == 'admin' &&
                      controller.currentStep < 3) {
                    return AppButton.simple(
                      text: 'Done',
                      onTap: () => AdminController.instance.changeOrderStatus(
                        status: details.currentStep,
                        order: order,
                      ),
                    );
                  }
                  return const SizedBox();
                },
                steps: [
                  Step(
                    title: Text(tr('pending')),
                    content: const Text(
                      'Your order is yet to be delivered',
                    ),
                    isActive: controller.currentStep > 0,
                    state: controller.currentStep > 0
                        ? StepState.complete
                        : StepState.indexed,
                    stepStyle: StepColors.stepStyle,
                  ),
                  Step(
                    title: Text(tr('completed')),
                    content: const Text(
                      'Your order has been delivered, you are yet to sign.',
                    ),
                    isActive: controller.currentStep > 1,
                    state: controller.currentStep > 1
                        ? StepState.complete
                        : StepState.indexed,
                    stepStyle: StepColors.stepStyle,
                  ),
                  Step(
                    title: Text(tr('received')),
                    content: const Text(
                      'Your order has been delivered and signed by you.',
                    ),
                    isActive: controller.currentStep > 2,
                    state: controller.currentStep > 2
                        ? StepState.complete
                        : StepState.indexed,
                    stepStyle: StepColors.stepStyle,
                  ),
                  Step(
                    title: Text(tr('delivered')),
                    content: const Text(
                      'Your order has been delivered and signed by you!',
                    ),
                    isActive: controller.currentStep >= 3,
                    state: controller.currentStep >= 3
                        ? StepState.complete
                        : StepState.indexed,
                    stepStyle: StepColors.stepStyle,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
