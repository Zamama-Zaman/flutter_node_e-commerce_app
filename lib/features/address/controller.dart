

import '../../lib.dart';

class AddressController extends BaseController {
  static final instance = Get.find<AddressController>();

  final TextEditingController flatBuildingController = TextEditingController();
  final TextEditingController areaController = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final _addressFormKey = GlobalKey<FormState>();

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

  void onApplePayResult(res) {
    if (AppPreference.instance.getUserModel.address.isEmpty) {
      // addressServices.saveUserAddress(
      //   context: context,
      //   address: addressToBeUsed,
      // );
    }
    // addressServices.placeOrder(
    //   context: context,
    //   address: addressToBeUsed,
    //   totalSum: double.parse(widget.totalAmount),
    // );
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

  void payPressed(String addressFromProvider) {
    addressToBeUsed = "";

    bool isForm = flatBuildingController.text.isNotEmpty ||
        areaController.text.isNotEmpty ||
        pincodeController.text.isNotEmpty ||
        cityController.text.isNotEmpty;

    if (isForm) {
      if (_addressFormKey.currentState!.validate()) {
        addressToBeUsed =
            '${flatBuildingController.text}, ${areaController.text}, ${cityController.text} - ${pincodeController.text}';
      } else {
        throw Exception('Please enter all the values!');
      }
    } else if (addressFromProvider.isNotEmpty) {
      addressToBeUsed = addressFromProvider;
    } else {
      // showSnackBar(context, 'ERROR');
    }
  }
}
