import '../../../../lib.dart';

class OrderService {
  static final instance = OrderService();
  CustomHttpClientMiddleWare client = CustomHttpClientMiddleWare(Client());
  AppPreference appPreference = AppPreference.instance;

  Map<String, String> headers = {
    'Content-Type': 'application/json; charset=UTF-8',
  };

  Future<Either<String, String>> saveAddress({
    required String address,
  }) async {
    final myJsonEncode = json.encode({
      "address": address,
    });

    try {
      headers['Accept-Language'] = appPreference.getLocale;
      headers['Authorization'] = 'Bearer AuthToken';
      appPreference.getUserModel.token;
      Response response = await client.post(
        Uri.parse(AppBaseUrl.saveUserAddressUrl),
        body: myJsonEncode,
        headers: headers,
      );

      if (response.statusCode == 200) {
        final myDecodedRes = json.decode(response.body);
        return right(myDecodedRes['message']);
      } else {
        final myDecodedRes = json.decode(response.body);
        debugPrint(myDecodedRes['message']);
        return left(myDecodedRes['message']);
      }
    } catch (e) {
      debugPrint("Error Save User Address $e");
      return left("Error Save User Address $e");
    }
  }

  Future<Either<String, String>> placeOrder({
    required String subTotal,
    required String deliveryAddress,
  }) async {
    final myJsonEncode = json.encode({
      "subTotal": subTotal,
      "deliveryAddress": deliveryAddress,
    });

    try {
      Response response = await client.post(
        Uri.parse(AppBaseUrl.placeOrderUrl),
        body: myJsonEncode,
        headers: headers,
      );

      if (response.statusCode == 200) {
        final myDecodedRes = json.decode(response.body);
        return right(myDecodedRes['message']);
      } else {
        final myDecodedRes = json.decode(response.body);
        return left(myDecodedRes['message']);
      }
    } catch (e) {
      debugPrint("Place Order Error $e");
      return left("Place Order Error $e");
    }
  }

  Future<Either<String, List<OrderResModel>>> getAllMyOrders() async {
    List<OrderResModel> orderList = [];

    try {
      Response response = await client.get(
        Uri.parse(AppBaseUrl.myOrdersUrl),
        headers: headers,
      );

      if (response.statusCode == 200) {
        for (var singleOrder in jsonDecode(response.body)['body']) {
          orderList.add(OrderResModel.fromMap(singleOrder));
        }
        return right(orderList);
      } else {
        final myDecodedRes = json.decode(response.body);
        return left(myDecodedRes['message']);
      }
    } catch (e) {
      debugPrint("Place Order Error $e");
      return left("Place Order Error $e");
    }
  }

  Future<Either<String, String>> changeOrderStatus({
    required String orderId,
    required String status,
  }) async {
    final myJsonEncode = json.encode({
      "id": orderId,
      "status": status,
    });

    try {
      Response response = await client.post(
        Uri.parse(AppBaseUrl.orderStatusChangeUrl),
        headers: headers,
        body: myJsonEncode,
      );

      if (response.statusCode == 200) {
        final myDecodedRes = json.decode(response.body);
        return right(myDecodedRes['message']);
      } else {
        final myDecodedRes = json.decode(response.body);
        return left(myDecodedRes['message']);
      }
    } catch (e) {
      debugPrint("Error Change Order Status $e");
      return left("Error Change Order Status $e");
    }
  }
}
