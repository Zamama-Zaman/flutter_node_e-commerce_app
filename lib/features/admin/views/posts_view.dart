import '../../../lib.dart';

class PostsView extends BaseWidget<AdminController> {
  const PostsView({super.key});

  @override
  bool get isLoading => controller.isFetching;

  @override
  void initStateWidget(state) {
    super.initStateWidget(state);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await controller.fetchAllProducts();
    });
  }

  @override
  Widget get child => controller.products == null
      ? Center(
          child: AppText.commonText(
            text: "No Product Added Yet!",
            fontSize: 18.sp,
            fontWeight: FontWeight.w500,
          ),
        )
      : GridView.builder(
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
                    IconButton(
                      onPressed: () => controller.deleteProduct(
                        controller.products![index],
                        index,
                      ),
                      icon: const Icon(
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
