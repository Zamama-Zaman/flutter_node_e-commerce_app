import '../../lib.dart';

class RateBottomSheet extends StatelessWidget {
  final Product product;
  const RateBottomSheet({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    String rate = '';
    double myRating = 0.0;

    return SizedBox(
      width: Get.width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          //
          AppGapVertical.thirtyTwo,

          //*
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
              'Rate The Product',
              style: TextStyle(
                fontSize: 22.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          //
          AppGapVertical.eight,

          //*
          RatingBar.builder(
            initialRating: myRating,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            itemPadding: const EdgeInsets.symmetric(horizontal: 4),
            itemBuilder: (context, _) => const Icon(
              Icons.star,
              color: Colors.amber,
            ),
            onRatingUpdate: (rating) {
              rate = rating.toString();
            },
          ),

          //
          AppGapVertical.sixteen,

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 100.w),
            child: AppButton.simple(
              text: 'Rate',
              onTap: () => ProductController.instance.rateAProduct(
                product: product,
                rate: rate,
              ),
            ),
          ),

          //
          AppGapVertical.thirtyTwo,
        ],
      ),
    );
  }
}
