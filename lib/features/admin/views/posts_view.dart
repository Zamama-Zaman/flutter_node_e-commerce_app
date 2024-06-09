import '../../../lib.dart';

class PostsView extends BaseWidget<AdminController> {
  const PostsView({super.key});

  @override
  Widget get child => GridView.builder(
        itemCount: HomeController.instance.carsoulSliderImages.length,
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (context, index) {
          return Column(
            children: [
              SizedBox(
                height: 140.h,
                child: SingleProduct(
                  image: HomeController.instance.carsoulSliderImages[0],
                ),
              ),
              Row(
                children: [
                  SizedBox(width: 20.w),
                  const Expanded(
                    child: Text(
                      "Some Name",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
                  const IconButton(
                    onPressed:
                        null, // () => controller.deleteProduct(Pro, index),
                    icon: Icon(
                      Icons.delete_outline,
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      );
}
