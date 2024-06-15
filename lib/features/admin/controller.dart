import 'package:flutter_node_ecommerce_app_original/common/widgets/app_file_picker.dart';

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

  bool isLoading = false;
  void sellProduct() async {
    bool isNotEmtpy = productNameController.text.isNotEmpty &&
        descriptionController.text.isNotEmpty &&
        priceController.text.isNotEmpty &&
        quantityController.text.isNotEmpty;
    if (isNotEmtpy) {
      Product newProduct = Product(
        name: productNameController.text,
        description: descriptionController.text,
        quantity: double.parse(quantityController.text),
        images: [],
        category: category,
        price: double.parse(priceController.text),
      );

      isLoading = true;
      update();
      final result = await AdminService.instance.addProduct(
        product: newProduct,
        images: images,
      );

      if (result) {
        Fluttertoast.showToast(msg: "Added Succesfully");
        clearAll();
        Get.back();
      }

      isLoading = false;
      update();
    }
  }

  void selectImages() async {
    var res = await AppFilePiker.pickImages();
    images = res;
    update();
  }

  //*************** Order Detail View ****************//

  int currentStep = 0;

  // @override
  // void initState() {
  //   super.initState();
  //   currentStep = widget.order.status;
  // }

  // !!! ONLY FOR ADMIN!!!
  void changeOrderStatus(int status) {
    // adminServices.changeOrderStatus(
    //   context: context,
    //   status: status + 1,
    //   order: widget.order,
    //   onSuccess: () {
    //     setState(() {
    //       currentStep += 1;
    //     });
    //   },
    // );
  }

  void clearAll() {
    images.clear();
    productNameController.clear();
    descriptionController.clear();
    priceController.clear();
    quantityController.clear();
  }
}
