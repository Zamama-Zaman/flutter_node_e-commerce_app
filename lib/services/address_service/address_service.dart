import '../../lib.dart';

class AddressService {
  static final instance = AddressService();

  Map<String, String> get _headers => {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${AppPreference.instance.getUserModel.token}'
      };

  Future<void> saveAddress({
    required String address,
  }) async {
    final myJsonEncode = json.encode({
      "address": address,
    });

    try {
      Response response = await post(
        Uri.parse(AppBaseUrl.saveUserAddressUrl),
        body: myJsonEncode,
        headers: _headers,
      );

      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: "Successfully User Address Saved");
      }
    } catch (e) {
      debugPrint("Save User Address Error $e");
      Fluttertoast.showToast(msg: "Error Save User Address $e");
    }
  }

  Future<bool> placeOrder({
    required String subTotal,
    required String deliveryAddress,
  }) async {
    bool isPlaced = false;
    final myJsonEncode = json.encode({
      "subTotal": subTotal,
      "deliveryAddress": deliveryAddress,
    });

    try {
      Response response = await post(
        Uri.parse(AppBaseUrl.placeOrderUrl),
        body: myJsonEncode,
        headers: _headers,
      );

      if (response.statusCode == 200) {
        isPlaced = true;
      }
    } catch (e) {
      debugPrint("Place Order Error $e");
      Fluttertoast.showToast(msg: "Error Place Order $e");
    }

    return isPlaced;
  }
}
