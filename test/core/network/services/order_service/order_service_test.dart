import 'package:flutter_node_ecommerce_app_original/lib.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCustomHttpClientMiddleWare extends Mock
    implements CustomHttpClientMiddleWare {}

class MockSharePreference extends Mock implements SharedPreferences {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late OrderService orderService;
  late MockCustomHttpClientMiddleWare middleWareClient;
  late AppPreference appPreference;
  late MockSharePreference mockSharePreference;

  setUp(() async {
    mockSharePreference = MockSharePreference();
    appPreference = AppPreference(sharedPreferences: mockSharePreference);

    orderService = OrderService.instance;
    middleWareClient = MockCustomHttpClientMiddleWare();

    orderService.client = middleWareClient;
    orderService.appPreference = appPreference;
  });

  group("Order Services -", () {
    group("Save Orders -", () {
      test(
          "The API call returns a status code of 200, indicating a successful save.",
          () async {
        const address = "Gujranwala.";
        final myJsonEncode = json.encode({
          "address": address,
        });
        Map<String, String> headers = {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept-Language': 'en',
          'Authorization': 'Bearer ${appPreference.getUserModel.token}',
        };

        /// Arrange
        when(
          () => middleWareClient.post(
            Uri.parse(AppBaseUrl.saveUserAddressUrl),
            body: myJsonEncode,
            headers: headers,
          ),
        ).thenAnswer(
          (invocation) async => Response(
            """
                {
                    "status": true,
                    "message": "Address save successfully"
                }
            """,
            200,
          ),
        );

        /// Act
        final result = await orderService.saveAddress(address: address);

        /// Assert
        expect(result, isA<Either<String, String>>());
        expect(result.isRight(), true);
        result.fold(
          (l) => expect(l, isA<String>()),
          (r) => expect(r, isA<String>()),
        );
      });

      test("Returns left when address save fails", () async {
        const address = "Lahore, Wapda Town, Street no.18, house 27.";
        final myJsonEncode = json.encode({
          "address": address,
        });
        Map<String, String> headers = {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept-Language': 'en',
          'Authorization': 'Bearer ${appPreference.getUserModel.token}',
        };

        /// Arrange
        when(
          () => middleWareClient.post(
            Uri.parse(AppBaseUrl.saveUserAddressUrl),
            body: myJsonEncode,
            headers: headers,
          ),
        ).thenAnswer(
          (invocation) async => Response(
            """
                {
                    "status": false,
                    "message": "Invalid address"
                }
            """,
            400,
          ),
        );

        /// Act
        final result = await orderService.saveAddress(address: address);

        /// Assert
        expect(result, isA<Either<String, String>>());
        expect(result.isLeft(), true);
        expect(result.fold((l) => l, (r) => ''), 'Invalid address');
      });

      test("Returns left when an exception is thrown", () async {
        const address = "Lahore, Wapda Town, Street no.18, house 27.";
        final myJsonEncode = json.encode({
          "address": address,
        });
        Map<String, String> headers = {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept-Language': 'en',
          'Authorization': 'Bearer ${appPreference.getUserModel.token}',
        };

        /// Arrange
        when(
          () => middleWareClient.post(
            Uri.parse(AppBaseUrl.saveUserAddressUrl),
            body: myJsonEncode,
            headers: headers,
          ),
        ).thenThrow(Exception('Network error'));

        /// Act
        final result = await orderService.saveAddress(address: address);

        /// Assert
        expect(result, isA<Either<String, String>>());
        expect(result.isLeft(), true);
        expect(
          result.fold((l) => l, (r) => ''),
          contains('Error Save User Address'),
        );
      });

      test("Handles missing authorization token", () async {
        const address = "Lahore, Wapda Town, Street no.18, house 27.";
        final myJsonEncode = json.encode({
          "address": address,
        });
        Map<String, String> headers = {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept-Language': 'en',
          'Authorization': 'Bearer ${appPreference.getUserModel.token}',
        };

        /// Arrange
        when(
          () => middleWareClient.post(
            Uri.parse(AppBaseUrl.saveUserAddressUrl),
            body: myJsonEncode,
            headers: headers,
          ),
        ).thenAnswer(
          (invocation) async => Response(
            """
                {
                    "status": false,
                    "message": "Unauthorize user"
                }
            """,
            401,
          ),
        );

        /// Act
        final result = await orderService.saveAddress(address: address);

        /// Assert
        expect(result, isA<Either<String, String>>());
        expect(result.isLeft(), true);
        expect(
          result.fold((l) => l, (r) => ''),
          contains('Unauthorize user'),
        );
      });

      test("Handles invalid address input", () async {
        const address = "";
        final myJsonEncode = json.encode({
          "address": address,
        });
        Map<String, String> headers = {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept-Language': 'en',
          'Authorization': 'Bearer ${appPreference.getUserModel.token}',
        };

        /// Arrange
        when(
          () => middleWareClient.post(
            Uri.parse(AppBaseUrl.saveUserAddressUrl),
            body: myJsonEncode,
            headers: headers,
          ),
        ).thenAnswer(
          (invocation) async => Response(
            """
                {
                    "status": false,
                    "message": "Invalid input address"
                }
            """,
            422,
          ),
        );

        /// Act
        final result = await orderService.saveAddress(address: address);

        /// Assert
        expect(result, isA<Either<String, String>>());
        expect(result.isLeft(), true);
        expect(
          result.fold((l) => l, (r) => ''),
          contains('Invalid input address'),
        );
      });

      // Group End.
    });

    group("Plase Order -", () {
      test("Returns right when the order is successfully placed", () async {
        String subTotal = "100.00";
        String deliveryAddress = "123 Flutter Lane";
        final myJsonEncode = json.encode({
          "subTotal": subTotal,
          "deliveryAddress": deliveryAddress,
        });

        Map<String, String> headers = {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept-Language': 'en',
          'Authorization': 'Bearer ${appPreference.getUserModel.token}',
        };

        /// Arrange
        when(
          () => middleWareClient.post(
            Uri.parse(AppBaseUrl.placeOrderUrl),
            body: myJsonEncode,
            headers: headers,
          ),
        ).thenAnswer(
          (invocation) async => Response(
            """
                {
                    "status": true,
                    "message": "Order placed successfully"
                }
            """,
            200,
          ),
        );

        /// Act
        final result = await orderService.placeOrder(
          subTotal: subTotal,
          deliveryAddress: deliveryAddress,
        );

        /// Assert
        expect(result, isA<Either<String, String>>());
        expect(result.isRight(), true);
        result.fold(
          (l) => expect(l, isA<String>()),
          (r) => expect(r, isA<String>()),
        );
      });

      test("Returns left when the order placement fails", () async {
        String subTotal = "100.00";
        String deliveryAddress = "123 Flutter Lane";
        final myJsonEncode = json.encode({
          "subTotal": subTotal,
          "deliveryAddress": deliveryAddress,
        });

        Map<String, String> headers = {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept-Language': 'en',
          'Authorization': 'Bearer ${appPreference.getUserModel.token}',
        };

        /// Arrange
        when(
          () => middleWareClient.post(
            Uri.parse(AppBaseUrl.placeOrderUrl),
            body: myJsonEncode,
            headers: headers,
          ),
        ).thenAnswer(
          (invocation) async => Response(
            """
                {
                    "status": false,
                    "message": "Invalid order details"
                }
            """,
            400,
          ),
        );

        /// Act
        final result = await orderService.placeOrder(
          subTotal: subTotal,
          deliveryAddress: deliveryAddress,
        );

        /// Assert
        expect(result, isA<Either<String, String>>());
        expect(result.isLeft(), true);
        expect(result.fold((l) => l, (r) => ''), 'Invalid order details');
        result.fold(
          (l) => expect(l, isA<String>()),
          (r) => expect(r, isA<String>()),
        );
      });

      test("Returns left when an exception is thrown during order placement",
          () async {
        String subTotal = "100.00";
        String deliveryAddress = "123 Flutter Lane";
        final myJsonEncode = json.encode({
          "subTotal": subTotal,
          "deliveryAddress": deliveryAddress,
        });

        Map<String, String> headers = {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept-Language': 'en',
          'Authorization': 'Bearer ${appPreference.getUserModel.token}',
        };

        /// Arrange
        when(
          () => middleWareClient.post(
            Uri.parse(AppBaseUrl.placeOrderUrl),
            body: myJsonEncode,
            headers: headers,
          ),
        ).thenThrow(Exception('Network error'));

        /// Act
        final result = await orderService.placeOrder(
          subTotal: subTotal,
          deliveryAddress: deliveryAddress,
        );

        /// Assert
        expect(result, isA<Either<String, String>>());
        expect(result.isLeft(), true);
        expect(
          result.fold((l) => l, (r) => ''),
          'Place Order Error Exception: Network error',
        );
        result.fold(
          (l) => expect(l, isA<String>()),
          (r) => expect(r, isA<String>()),
        );
      });

      test("Handles invalid subtotal input", () async {
        String subTotal = "";
        String deliveryAddress = "123 Flutter Lane";
        final myJsonEncode = json.encode({
          "subTotal": subTotal,
          "deliveryAddress": deliveryAddress,
        });

        Map<String, String> headers = {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept-Language': 'en',
          'Authorization': 'Bearer ${appPreference.getUserModel.token}',
        };

        /// Arrange
        when(
          () => middleWareClient.post(
            Uri.parse(AppBaseUrl.placeOrderUrl),
            body: myJsonEncode,
            headers: headers,
          ),
        ).thenAnswer(
          (invocation) async => Response(
            """
                {
                    "status": false,
                    "message": "Subtotal is required"
                }
            """,
            401,
          ),
        );

        /// Act
        final result = await orderService.placeOrder(
          subTotal: subTotal,
          deliveryAddress: deliveryAddress,
        );

        /// Assert
        expect(result, isA<Either<String, String>>());
        expect(result.isLeft(), true);
        expect(
          result.fold((l) => l, (r) => ''),
          'Subtotal is required',
        );
        result.fold(
          (l) => expect(l, isA<String>()),
          (r) => expect(r, isA<String>()),
        );
      });

      test("Verifies that the correct headers are used", () async {
        String subTotal = "";
        String deliveryAddress = "123 Flutter Lane";
        final myJsonEncode = json.encode({
          "subTotal": subTotal,
          "deliveryAddress": deliveryAddress,
        });

        Map<String, String> headers = {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept-Language': 'en',
          'Authorization': 'Bearer ${appPreference.getUserModel.token}',
        };

        // Capture headers passed to the client
        var capturedHeaders;

        /// Arrange
        when(
          () => middleWareClient.post(
            Uri.parse(AppBaseUrl.placeOrderUrl),
            body: myJsonEncode,
            headers: headers,
          ),
        ).thenAnswer(
          (invocation) async {
            capturedHeaders = invocation.namedArguments[#headers];
            return Response('{"message": "Order placed successfully"}', 200);
          },
        );

        /// Act
        await orderService.placeOrder(
          subTotal: subTotal,
          deliveryAddress: deliveryAddress,
        );

        /// Assert
        expect(capturedHeaders['Authorization'], isNotNull);
        expect(
            capturedHeaders['Content-Type'], 'application/json; charset=UTF-8');
      });

      //Group End
    });

    group("Get all my Orders -", () {
      test(
          "Returns right with a list of orders when the API call is successful",
          () async {
        Map<String, String> headers = {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept-Language': 'en',
          'Authorization': 'Bearer ${appPreference.getUserModel.token}',
        };

        /// Arrange
        when(
          () => middleWareClient.get(
            Uri.parse(AppBaseUrl.myOrdersUrl),
            headers: headers,
          ),
        ).thenAnswer(
          (invocation) async => Response(
            """
                {
                  "status": "Success",
                  "message": "All Order fetched successfully",
                  "body": [
                      {
                        "userDetail": {
                            "userId": "6668f8c8c04a89576e2840f5",
                            "name": "Zamama Zaman"
                        },
                        "_id": "6684a90ede47e9f2d8cb4f6b",
                        "subTotal": 600,
                        "deliveryAddress": "Houser 22, Street 21, Gujranwala - 1234",
                        "cart": [
                            {
                                "product": {
                                    "name": "Mobile",
                                    "price": "200",
                                    "category": "Mobile",
                                    "quantity": "10",
                                    "description": "This is Android Mobile Redmi Note 11",
                                    "images": [
                                        "https://images.priceoye.pk/xiaomi-redmi-note-11-pakistan-priceoye-ueyau-500x500.webp",
                                        "https://images.priceoye.pk/xiaomi-redmi-note-11-pakistan-priceoye-46ipw-500x500.webp",
                                        "https://images.priceoye.pk/xiaomi-redmi-note-11-pakistan-priceoye-804gl-500x500.webp"
                                    ],
                                    "rating": [
                                        {
                                            "rate": "3",
                                            "productId": "6668fee4be8f4d853095c347",
                                            "userId": "6668f8c8c04a89576e2840f5",
                                            "_id": "666a3f7c57c924ce7c5ee024"
                                        }
                                    ],
                                    "_id": "6668fee4be8f4d853095c347",
                                    "createdAt": "2024-06-12T01:50:28.287Z",
                                    "updatedAt": "2024-07-03T01:27:42.465Z",
                                    "__v": 1,
                                    "adminId": ""
                                },
                                "quantity": 3,
                                "_id": "667cb68e1948a0942283300f"
                              }
                            ],
                              "status": 3,
                              "createdAt": "2024-07-03T01:27:42.465Z",
                              "updatedAt": "2024-08-11T15:34:26.691Z",
                              "__v": 0
                            }
                          ]
                        }
            """,
            200,
          ),
        );

        /// Act
        final result = await orderService.getAllMyOrders();

        /// Assert
        expect(result, isA<Either<String, List<OrderResModel>>>());
        expect(result.isRight(), true);
        result.fold(
          (l) => expect(l, isA<String>()),
          (r) => expect(r, isA<List<OrderResModel>>()),
        );
      });

      test("Returns left with an error message when the API call fails",
          () async {
        Map<String, String> headers = {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept-Language': 'en',
          'Authorization': 'Bearer ${appPreference.getUserModel.token}',
        };

        /// Arrange
        when(
          () => middleWareClient.get(
            Uri.parse(AppBaseUrl.myOrdersUrl),
            headers: headers,
          ),
        ).thenAnswer(
          (invocation) async => Response(
            """
                {
                  "status": "false",
                  "message": "Failed to fetch orders"
                }
            """,
            400,
          ),
        );

        /// Act
        final result = await orderService.getAllMyOrders();

        /// Assert
        expect(result, isA<Either<String, List<OrderResModel>>>());
        expect(result.isLeft(), true);
        result.fold(
          (l) => expect(l, isA<String>()),
          (r) => expect(r, isA<List<OrderResModel>>()),
        );
        expect(result.fold((l) => l, (r) => ''), 'Failed to fetch orders');
      });

      test("Returns left with an error message when an exception is thrown",
          () async {
        Map<String, String> headers = {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept-Language': 'en',
          'Authorization': 'Bearer ${appPreference.getUserModel.token}',
        };

        /// Arrange
        when(
          () => middleWareClient.get(
            Uri.parse(AppBaseUrl.myOrdersUrl),
            headers: headers,
          ),
        ).thenThrow(
          Exception('Network error'),
        );

        /// Act
        final result = await orderService.getAllMyOrders();

        /// Assert
        expect(result, isA<Either<String, List<OrderResModel>>>());
        expect(result.isLeft(), true);
        expect(result.fold((l) => l, (r) => ''), contains('Place Order Error'));
      });

      test("Returns right with an empty list when no orders are available",
          () async {
        Map<String, String> headers = {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept-Language': 'en',
          'Authorization': 'Bearer ${appPreference.getUserModel.token}',
        };

        /// Arrange
        when(
          () => middleWareClient.get(
            Uri.parse(AppBaseUrl.myOrdersUrl),
            headers: headers,
          ),
        ).thenAnswer(
          (invocation) async => Response(
            """
                {
                  "status": "Success",
                  "message": "Data fetch Successfully",
                  "body": []
                }
            """,
            200,
          ),
        );

        /// Act
        final result = await orderService.getAllMyOrders();

        /// Assert
        expect(result, isA<Either<String, List<OrderResModel>>>());
        expect(result.isRight(), true);
        expect(result.getOrElse(() => []).isEmpty, true);
      });

      test("Handles invalid data structure in API response", () async {
        Map<String, String> headers = {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept-Language': 'en',
          'Authorization': 'Bearer ${appPreference.getUserModel.token}',
        };

        /// Arrange
        when(
          () => middleWareClient.get(
            Uri.parse(AppBaseUrl.myOrdersUrl),
            headers: headers,
          ),
        ).thenAnswer(
          (invocation) async => Response(
            """
                {
                  "status": "Success",
                  "message": "Data fetch Successfully",
                  "body": "invalid_data"
                }
            """,
            200,
          ),
        );

        /// Act
        final result = await orderService.getAllMyOrders();

        /// Assert
        expect(result, isA<Either<String, List<OrderResModel>>>());
        expect(result.isLeft(), true);
      });
      // Group End
    });

    group("Change Order Status -", () {
      test("Returns right when the order status is successfully changed",
          () async {
        String orderId = '12345';
        String status = '1';

        final myJsonEncode = json.encode({
          "id": orderId,
          "status": status,
        });

        Map<String, String> headers = {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept-Language': 'en',
          'Authorization': 'Bearer ${appPreference.getUserModel.token}',
        };

        /// Arrange
        when(
          () => middleWareClient.post(
            Uri.parse(AppBaseUrl.orderStatusChangeUrl),
            body: myJsonEncode,
            headers: headers,
          ),
        ).thenAnswer(
          (invocation) async => Response(
            """
              {
                "status": "true",
                "message": "Order status changed successfully"
              }
            """,
            200,
          ),
        );

        /// Act
        final result = await orderService.changeOrderStatus(
          orderId: orderId,
          status: status,
        );

        /// Assert
        expect(result, isA<Either<String, String>>());
        expect(result.isRight(), true);
        result.fold(
          (l) => expect(l, isA<String>()),
          (r) => expect(r, isA<String>()),
        );
        expect(result.getOrElse(() => ''), 'Order status changed successfully');
      });

      test("Returns left when the order status change fails", () async {
        String orderId = '12345';
        String status = '1';

        final myJsonEncode = json.encode({
          "id": orderId,
          "status": status,
        });

        Map<String, String> headers = {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept-Language': 'en',
          'Authorization': 'Bearer ${appPreference.getUserModel.token}',
        };

        /// Arrange
        when(
          () => middleWareClient.post(
            Uri.parse(AppBaseUrl.orderStatusChangeUrl),
            body: myJsonEncode,
            headers: headers,
          ),
        ).thenAnswer(
          (invocation) async => Response(
            """
              {
                "status": "false",
                "message": "Failed to change order status"
              }
            """,
            400,
          ),
        );

        /// Act
        final result = await orderService.changeOrderStatus(
          orderId: orderId,
          status: status,
        );

        /// Assert
        expect(result, isA<Either<String, String>>());
        expect(result.isLeft(), true);
        result.fold(
          (l) => expect(l, isA<String>()),
          (r) => expect(r, isA<String>()),
        );
        expect(
            result.fold((l) => l, (r) => ''), 'Failed to change order status');
      });

      test(
          "Returns left when an exception is thrown during order status change",
          () async {
        String orderId = '12345';
        String status = '1';

        final myJsonEncode = json.encode({
          "id": orderId,
          "status": status,
        });

        Map<String, String> headers = {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept-Language': 'en',
          'Authorization': 'Bearer ${appPreference.getUserModel.token}',
        };

        /// Arrange
        when(
          () => middleWareClient.post(
            Uri.parse(AppBaseUrl.orderStatusChangeUrl),
            body: myJsonEncode,
            headers: headers,
          ),
        ).thenThrow(Exception('Network error'));

        /// Act
        final result = await orderService.changeOrderStatus(
          orderId: orderId,
          status: status,
        );

        /// Assert
        expect(result, isA<Either<String, String>>());
        expect(result.isLeft(), true);
        result.fold(
          (l) => expect(l, isA<String>()),
          (r) => expect(r, isA<String>()),
        );
        expect(result.fold((l) => l, (r) => ''),
            contains('Error Change Order Status'));
      });

      test("Handles invalid order ID", () async {
        String orderId = '';
        String status = '1';

        final myJsonEncode = json.encode({
          "id": orderId,
          "status": status,
        });

        Map<String, String> headers = {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept-Language': 'en',
          'Authorization': 'Bearer ${appPreference.getUserModel.token}',
        };

        /// Arrange
        when(
          () => middleWareClient.post(
            Uri.parse(AppBaseUrl.orderStatusChangeUrl),
            body: myJsonEncode,
            headers: headers,
          ),
        ).thenAnswer((a) async {
          return Response(
            """
            {
              "status": "false",
              "message": "invalid order id"
            }
            """,
            400,
          );
        });

        /// Act
        final result = await orderService.changeOrderStatus(
          orderId: orderId,
          status: status,
        );

        /// Assert
        expect(result, isA<Either<String, String>>());
        expect(result.isLeft(), true);
        result.fold(
          (l) => expect(l, isA<String>()),
          (r) => expect(r, isA<String>()),
        );
        expect(result.fold((l) => l, (r) => ''), contains('invalid order id'));
      });

      test("Handles invalid status input", () async {
        String orderId = '12345';
        String status = '';

        final myJsonEncode = json.encode({
          "id": orderId,
          "status": status,
        });

        Map<String, String> headers = {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept-Language': 'en',
          'Authorization': 'Bearer ${appPreference.getUserModel.token}',
        };

        /// Arrange
        when(
          () => middleWareClient.post(
            Uri.parse(AppBaseUrl.orderStatusChangeUrl),
            body: myJsonEncode,
            headers: headers,
          ),
        ).thenAnswer((a) async {
          return Response(
            """
            {
              "status": "false",
              "message": "invalid order status"
            }
            """,
            400,
          );
        });

        /// Act
        final result = await orderService.changeOrderStatus(
          orderId: orderId,
          status: status,
        );

        /// Assert
        expect(result, isA<Either<String, String>>());
        expect(result.isLeft(), true);
        result.fold(
          (l) => expect(l, isA<String>()),
          (r) => expect(r, isA<String>()),
        );
        expect(
            result.fold((l) => l, (r) => ''), contains('invalid order status'));
      });

      test("Verifies that the correct headers are used for changeOrderStatus",
          () async {
        String orderId = '12345';
        String status = '1';

        final myJsonEncode = json.encode({
          "id": orderId,
          "status": status,
        });

        Map<String, String> headers = {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept-Language': 'en',
          'Authorization': 'Bearer ${appPreference.getUserModel.token}',
        };
        var capturedHeaders;

        /// Arrange
        when(
          () => middleWareClient.post(
            Uri.parse(AppBaseUrl.orderStatusChangeUrl),
            body: myJsonEncode,
            headers: headers,
          ),
        ).thenAnswer((invocation) async {
          capturedHeaders = invocation.namedArguments[#headers];
          return Response(
            """
            {
              "status": "true",
              "message": "Order status changed successfully"
            }
            """,
            200,
          );
        });

        /// Act
        await orderService.changeOrderStatus(
          orderId: orderId,
          status: status,
        );

        /// Assert
        expect(capturedHeaders['Authorization'], isNotNull);
        expect(capturedHeaders['Content-Type'], 'application/json; charset=UTF-8');
      });
      // Group End

      //* Plan for next Unit Testing.
    });
  });
}
