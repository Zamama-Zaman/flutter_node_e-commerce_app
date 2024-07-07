import '../../../lib.dart';

class SingleProduct extends StatelessWidget {
  final String image;
  const SingleProduct({
    super.key,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black12,
            width: 1.5.w,
          ),
          borderRadius: BorderRadius.circular(5.r),
          color: Colors.white,
        ),
        child: Container(
          width: 180.w,
          padding: const EdgeInsets.all(10),
          child: AppImage.cacheImage(
            image: image,
            fit: BoxFit.fitHeight,
            width: 180.w,
          ),
        ),
      ),
    );
  }
}
