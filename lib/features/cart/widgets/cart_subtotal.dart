import '../../../lib.dart';

class CartSubtotal extends StatelessWidget {
  const CartSubtotal({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(
      builder: (_) {
        int sum = 0;
        CartController.instance.listCart!
            .map((e) => sum += e.quantity * e.product.price.toInt())
            .toList();
        return Container(
          margin: const EdgeInsets.all(10),
          child: Row(
            children: [
              Text(
                'Subtotal ',
                style: TextStyle(
                  fontSize: 20.sp,
                ),
              ),
              Text(
                '\$${sum.toString()}',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
