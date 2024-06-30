import '../../services/address_service/address_service.dart';

import '../../lib.dart';

class AddressController extends BaseController {
  static final instance = Get.find<AddressController>();

  final TextEditingController flatBuildingController = TextEditingController();
  final TextEditingController areaController = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();
  final TextEditingController cityController = TextEditingController();

  String addressToBeUsed = "";
  var address = AppPreference.instance.getUserModel.address;
  List<PaymentItem> paymentItems = [];
  // final AddressServices addressServices = AddressServices();

  void initialFunction() {
    // paymentItems.add(
    //   PaymentItem(
    //     amount: widget.totalAmount,
    //     label: 'Total Amount',
    //     status: PaymentItemStatus.final_price,
    //   ),
    // );
  }

  @override
  void dispose() {
    super.dispose();
    flatBuildingController.dispose();
    areaController.dispose();
    pincodeController.dispose();
    cityController.dispose();
  }

  void onApplePayResult(res, subTotal) async {
    if (AppPreference.instance.getUserModel.address.isEmpty) {
      await AddressService.instance.saveAddress(
        address: addressToBeUsed,
      );
    }
    bool isPlased = await AddressService.instance.placeOrder(
      subTotal: subTotal.toString(),
      deliveryAddress: addressToBeUsed,
    );

    if (isPlased) {
      Fluttertoast.showToast(msg: "Placed Order Successfully");
    }
  }

  void onGooglePayResult(res) {
    // if (Provider.of<UserProvider>(context, listen: false)
    //     .user
    //     .address
    //     .isEmpty) {
    //   addressServices.saveUserAddress(
    //       context: context, address: addressToBeUsed);
    // }
    // addressServices.placeOrder(
    //   context: context,
    //   address: addressToBeUsed,
    //   totalSum: double.parse(widget.totalAmount),
    // );
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
}
