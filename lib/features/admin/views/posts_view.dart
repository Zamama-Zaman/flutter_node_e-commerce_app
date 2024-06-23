import '../../../lib.dart';

class PostsView extends BaseWidget<AdminController> {
  const PostsView({super.key});

  @override
  void initStateWidget(_) {
    super.initStateWidget(_);
    controller.fetchAllProducts();
  }

  @override
  Widget get child => GridView.builder(
        itemCount: controller.products!.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemBuilder: (context, index) {
          return Column(
            children: [
              SizedBox(
                height: 140.h,
                child: SingleProduct(
                  image: controller.products![index].images[0],
                ),
              ),
              Row(
                children: [
                  SizedBox(width: 20.w),
                  Expanded(
                    child: Text(
                      controller.products![index].name,
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
