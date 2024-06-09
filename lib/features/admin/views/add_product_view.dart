import '../../../lib.dart';

class AddProductView extends BaseView<AdminController> {
  const AddProductView({super.key});

  @override
  PreferredSizeWidget? get appBar => AppBarWidgets.defaultAppBar(
        title: "Add Product",
      );

  @override
  Widget? get body => SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              controller.images.isNotEmpty
                  ? CarouselSlider(
                      items: controller.images.map(
                        (i) {
                          return Builder(
                            builder: (BuildContext context) => Image.file(
                              i,
                              fit: BoxFit.cover,
                              height: 200.h,
                            ),
                          );
                        },
                      ).toList(),
                      options: CarouselOptions(
                        viewportFraction: 1,
                        height: 200,
                      ),
                    )
                  : GestureDetector(
                      onTap: controller.selectImages,
                      child: DottedBorder(
                        borderType: BorderType.RRect,
                        radius: Radius.circular(10.r),
                        dashPattern: const [10, 4],
                        strokeCap: StrokeCap.round,
                        child: Container(
                          width: double.infinity,
                          height: 150.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.folder_open,
                                size: 40,
                              ),
                              SizedBox(height: 15.h),
                              Text(
                                'Select Product Images',
                                style: TextStyle(
                                  fontSize: 15.sp,
                                  color: Colors.grey.shade400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
              SizedBox(height: 30.h),
              AppField.simple(
                controller: controller.productNameController,
                hintText: 'Product Name',
              ),
              SizedBox(height: 10.h),
              AppField.simple(
                controller: controller.descriptionController,
                hintText: 'Description',
                // maxLines: 7,
              ),
              SizedBox(height: 10.h),
              AppField.simple(
                controller: controller.priceController,
                hintText: 'Price',
              ),
              SizedBox(height: 10.h),
              AppField.simple(
                controller: controller.quantityController,
                hintText: 'Quantity',
              ),
              SizedBox(height: 10.h),
              SizedBox(
                width: double.infinity,
                child: DropdownButton(
                  value: controller.category,
                  icon: const Icon(Icons.keyboard_arrow_down),
                  items: controller.productCategories.map((String item) {
                    return DropdownMenuItem(
                      value: item,
                      child: Text(item),
                    );
                  }).toList(),
                  onChanged: (String? newVal) {
                    controller.category = newVal!;
                    controller.update();
                  },
                ),
              ),
              SizedBox(height: 10.h),
              AppButton.simple(
                text: 'Sell',
                onTap: controller.sellProduct,
              ),
            ],
          ),
        ),
      );
}
