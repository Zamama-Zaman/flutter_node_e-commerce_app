import '../../lib.dart';

class AddressController extends BaseController {
  static final instance = Get.find<AddressController>();

  final TextEditingController flatBuildingController = TextEditingController();
  final TextEditingController areaController = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();
  final TextEditingController cityController = TextEditingController();

  String addressToBeUsed = "";
  String address = "";
  List<PaymentItem> paymentItems = [];

  @override
  void dispose() {
    super.dispose();
    flatBuildingController.dispose();
    areaController.dispose();
    pincodeController.dispose();
    cityController.dispose();
  }

  Future<void> onApplePayResult(res, subTotal) async {
    if (AppPreference.instance.getUserModel.address.isEmpty) {
      await OrderService.instance.saveAddress(
        address: addressToBeUsed,
      );
    }

    final result = await OrderService.instance.placeOrder(
      subTotal: subTotal.toString(),
      deliveryAddress: addressToBeUsed,
    );
    result.fold((errorM) {
      Fluttertoast.showToast(msg: errorM);
    }, (succesM) {
      Fluttertoast.showToast(msg: succesM);
      _clearAll();
      Get.back();
    });
  }

  void onGooglePayResult(res, subTotal) async {
    if (AppPreference.instance.getUserModel.address.isEmpty) {
      await OrderService.instance.saveAddress(
        address: addressToBeUsed,
      );
    }
    final result = await OrderService.instance.placeOrder(
      subTotal: subTotal.toString(),
      deliveryAddress: addressToBeUsed,
    );

    result.fold((errorM) {
      Fluttertoast.showToast(msg: errorM);
    }, (succesM) {
      Fluttertoast.showToast(msg: succesM);
      _clearAll();
      Get.back();
    });
  }

  void payPressed(
    String addressFromProvider,
    String subTotal,
  ) {
    addressToBeUsed = "";

    bool isForm = flatBuildingController.text.isNotEmpty ||
        areaController.text.isNotEmpty ||
        pincodeController.text.isNotEmpty ||
        cityController.text.isNotEmpty;

    if (isForm) {
      addressToBeUsed =
          '${flatBuildingController.text}, ${areaController.text}, ${cityController.text} - ${pincodeController.text}';
    } else if (addressFromProvider.isNotEmpty) {
      addressToBeUsed = addressFromProvider;
    } else {
      // showSnackBar(context, 'ERROR');
    }

    onApplePayResult({}, subTotal);
  }

  void _clearAll() {
    flatBuildingController.clear();
    areaController.clear();
    pincodeController.clear();
    cityController.clear();
  }
}
