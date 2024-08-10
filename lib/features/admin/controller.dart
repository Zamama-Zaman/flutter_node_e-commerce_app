import '../../common/widgets/app_file_picker.dart';

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

  bool isFetching = false;
  fetchAllProducts() async {
    isFetching = true;
    update();
    final result = await AdminService.instance.fetchAllProducts();

    result.fold((errorM) {
      Fluttertoast.showToast(msg: errorM);
    }, (succesR) {
      products = succesR;
    });

    isFetching = false;
    update();
  }

  void deleteProduct(Product product, int index) async {
    isFetching = true;
    update();

    final result = await AdminService.instance.deletAProduct(
      product: product,
    );

    result.fold((errorM) {
      Fluttertoast.showToast(msg: errorM);
    }, (succesR) {
      products!.removeAt(index);
    });

    isFetching = false;
    update();
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
        adminId: AppPreference.instance.getUserModel.id,
        name: productNameController.text,
        description: descriptionController.text,
        quantity: double.parse(quantityController.text),
        images: const [],
        category: category,
        price: double.parse(priceController.text),
      );

      isLoading = true;
      update();
      final result = await AdminService.instance.addProduct(
        product: newProduct,
        images: images,
      );

      result.fold((errorM) {
        Fluttertoast.showToast(msg: errorM);
      }, (successR) {
        Fluttertoast.showToast(msg: "Added Succesfully");
        clearAll();
        Get.back();
      });

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

  List<OrderResModel>? orderList = [];
  void fetchAllOrders() async {
    final result = await AdminService.instance.fetchAllOrders();

    result.fold((errorM) {
      Fluttertoast.showToast(msg: errorM);
    }, (succesR) {
      orderList = succesR;
    });

    update();
  }

  // !!! ONLY FOR ADMIN!!!
  void changeOrderStatus({required int status, required Order order}) async {
    final result = await OrderService.instance.changeOrderStatus(
      orderId: order.id,
      status: (status + 1).toString(),
    );

    result.fold(
      (errorM) {
        Fluttertoast.showToast(msg: errorM);
      },
      (succesR) {
        Fluttertoast.showToast(msg: succesR);
        OrderController.instance.currentStep += 1;
        OrderController.instance.update();
        fetchAllOrders();
      },
    );
  }

  void logout() {
    AppPreference.instance.clearUser();
    Get.offAll(() => const LoginView());
  }

  void clearAll() {
    images.clear();
    productNameController.clear();
    descriptionController.clear();
    priceController.clear();
    quantityController.clear();
  }
}
