import '../../../lib.dart';

class CategoryDetailView extends BaseView<HomeController> {
  final String category;
  const CategoryDetailView({
    super.key,
    required this.category,
  });

  @override
  PreferredSizeWidget? get appBar => AppBarWidgets.defaultAppBar(
        title: "Category Detail",
      );

  @override
  Widget get body => controller.productList == null
      ? Center(
          child: AppText.commonText(
            text: "No Products Added Yet!",
            fontWeight: FontWeight.w500,
            fontSize: 18.sp,
          ),
        )
      : Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
              alignment: Alignment.topLeft,
              child: Text(
                'Keep shopping for $category',
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            SizedBox(
              height: 170,
              child: GridView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.only(left: 15),
                itemCount: controller.productList!.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  childAspectRatio: 1.4,
                  mainAxisSpacing: 10,
                ),
                itemBuilder: (context, index) {
                  final product = controller.productList![index];
                  return GestureDetector(
                    onTap: () {
                      // Navigator.pushNamed(
                      //   context,
                      //   ProductDetailScreen.routeName,
                      //   arguments: product,
                      // );
                    },
                    child: Column(
                      children: [
                        SizedBox(
                          height: 130.h,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black12,
                                width: 0.5.w,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Image.network(
                                product.images[0],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          padding: EdgeInsets.only(
                            left: 0,
                            top: 5.h,
                            right: 15.w,
                          ),
                          child: Text(
                            product.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        );
}
