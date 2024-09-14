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
      test("Save order successfully", () async {
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
    });
  });
}
