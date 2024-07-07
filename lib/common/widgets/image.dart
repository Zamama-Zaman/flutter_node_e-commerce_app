import '../../lib.dart';

class AppImage extends StatelessWidget {
  final Widget image;
  final double? borderRadius;
  final double? width;
  final double? height;
  final BoxFit fit;

  const AppImage({
    super.key,
    required this.image,
    this.borderRadius,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
  });

  factory AppImage.asset({
    required String image,
    double? width,
    double? height,
    BoxFit fit = BoxFit.cover,
    double borderRadius = 12,
  }) =>
      AppImage(
        image: Image.asset(
          image,
          width: width,
          height: height,
          fit: fit,
        ),
        fit: fit,
        width: width,
        borderRadius: borderRadius,
        height: height,
      );

  factory AppImage.network({
    required String image,
    double? width,
    double? height,
    BoxFit fit = BoxFit.cover,
    double borderRadius = 12,
  }) =>
      AppImage(
        image: Image.network(
          image,
          width: width,
          height: height,
          fit: fit,
        ),
        fit: fit,
        width: width,
        borderRadius: borderRadius,
        height: height,
      );

  factory AppImage.cacheImage({
    required String image,
    double? width,
    double? height,
    BoxFit fit = BoxFit.cover,
    double borderRadius = 12,
  }) =>
      AppImage(
        image: CachedNetworkImage(
          fit: fit,
          width: width,
          height: height,
          imageUrl: image,
          placeholder: (context, url) => const Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => const Icon(
            Icons.error,
          ),
        ),
        fit: fit,
        width: width,
        borderRadius: borderRadius,
        height: height,
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: _borderRadius,
        shape: BoxShape.rectangle,
      ),
      child: ClipRRect(
        borderRadius: _borderRadius,
        child: image,
      ),
    );
  }

  BorderRadius get _borderRadius => BorderRadius.circular(borderRadius ?? 0);
}
