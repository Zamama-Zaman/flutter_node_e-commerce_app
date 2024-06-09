import 'dart:io';

import '../../lib.dart';

class AdminController extends BaseController {
  static final instance = Get.find<AdminController>();

  PageController pageController = PageController();
  int navSelectedIndex = 0;
  void navSelected(int index) {
    navSelectedIndex = index;
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeIn,
    );
    update();
  }

  //************ Post View ***************//
  List<Product>? products;

  fetchAllProducts() async {
    // products = await adminServices.fetchAllProducts(context);
    // setState(() {});
  }

  void deleteProduct(Product product, int index) {
    // adminServices.deleteProduct(
    //   context: context,
    //   product: product,
    //   onSuccess: () {
    //     products!.removeAt(index);
    //     setState(() {});
    //   },
    // );
  }

  //************ Add Product View *************//

  final TextEditingController productNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();

  String category = 'Mobiles';
  List<File> images = [];

  List<String> productCategories = [
    'Mobiles',
    'Essentials',
    'Appliances',
    'Books',
    'Fashion'
  ];

  void sellProduct() {
    // if (_addProductFormKey.currentState!.validate() && images.isNotEmpty) {
    //   adminServices.sellProduct(
    //     context: context,
    //     name: productNameController.text,
    //     description: descriptionController.text,
    //     price: double.parse(priceController.text),
    //     quantity: double.parse(quantityController.text),
    //     category: category,
    //     images: images,
    //   );
    // }
  }

  void selectImages() async {
    // var res = await pickImages();
    // setState(() {
    //   images = res;
    // });
  }
}
