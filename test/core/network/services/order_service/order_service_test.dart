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
  });
}
