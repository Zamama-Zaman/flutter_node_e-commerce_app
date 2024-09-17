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
          'Authorization': 'Bearer AuthToken',
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
          'Authorization': 'Bearer AuthToken',
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
          'Authorization': 'Bearer AuthToken',
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
          'Authorization': 'Bearer AuthToken',
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
          'Authorization': 'Bearer AuthToken',
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

    group("Plase Order -", () {});
    // Planed for next things.
  });
}
