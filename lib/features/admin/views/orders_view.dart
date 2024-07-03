import '../../../lib.dart';

class OrdersView extends BaseWidget<AdminController> {
  const OrdersView({super.key});

  @override
  Widget get child => GridView.builder(
        itemCount: HomeController.instance.carsoulSliderImages.length,
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Order order = Order(
                id: "",
                products: [],
                quantity: [],
                address: "",
                userId: "",
                orderedAt: "",
                status: 1,
                totalPrice: 20,
              );

              /// Goto Order Detail Screen
              Get.to(() => OrderDetailScreen(order: order));
            },
            child: SizedBox(
              height: 140,
              child: SingleProduct(
                image: HomeController.instance.carsoulSliderImages[index],
              ),
            ),
          );
        },
      );
}
