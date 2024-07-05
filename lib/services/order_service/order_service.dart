import '../../lib.dart';

class OrderService {
  static final instance = OrderService();

  Map<String, String> get headers => {
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
        headers: headers,
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
        headers: headers,
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

  Future<List<OrderResModel>> getAllMyOrders() async {
    List<OrderResModel> orderList = [];

    try {
      Response response = await get(
        Uri.parse(AppBaseUrl.myOrdersUrl),
        headers: headers,
      );

      if (response.statusCode == 200) {
        for (var singleOrder in jsonDecode(response.body)['body']) {
          orderList.add(OrderResModel.fromMap(singleOrder));
        }
      }
    } catch (e) {
      debugPrint("Place Order Error $e");
      Fluttertoast.showToast(msg: "Error Place Order $e");
    }

    return orderList;
  }

  Future<bool> changeOrderStatus({
    required String orderId,
    required String status,
  }) async {
    bool isStatusChanged = false;
    final myJsonEncode = json.encode({
      "id": orderId,
      "status": status,
    });

    try {
      Response response = await post(
        Uri.parse(AppBaseUrl.orderStatusChangeUrl),
        headers: headers,
        body: myJsonEncode,
      );

      if (response.statusCode == 200) {
        isStatusChanged = true;
      }
      if (response.statusCode == 401) {
        debugPrint("User not Authroize ");
        Fluttertoast.showToast(msg: "User not Authroize");
      }
    } catch (e) {
      debugPrint("Change Order Status Error Error $e");
      Fluttertoast.showToast(msg: "Error Change Order Status $e");
    }

    return isStatusChanged;
  }
}
