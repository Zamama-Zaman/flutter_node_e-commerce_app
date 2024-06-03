import '../../../lib.dart';

class CarouselImage extends BaseWidget<HomeController> {
  const CarouselImage({super.key});

  @override
  Widget get child => CarouselSlider(
        items: controller.carsoulSliderImages.map(
          (i) {
            return Builder(
              builder: (BuildContext context) => Image.network(
                i,
                fit: BoxFit.cover,
                height: 200,
              ),
            );
          },
        ).toList(),
        options: CarouselOptions(
          viewportFraction: 1,
          height: 200,
        ),
      );
}
