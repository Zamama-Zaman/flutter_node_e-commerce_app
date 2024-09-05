import 'package:flutter_node_ecommerce_app_original/lib.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCustomHttpClientMiddleWare extends Mock
    implements CustomHttpClientMiddleWare {}

class MockSharePreference extends Mock implements SharedPreferences {}

void main() {
  // TestWidgetsFlutterBinding.ensureInitialized();
  late HomeService homeService;
  late MockCustomHttpClientMiddleWare middleWareClient;
  late AppPreference appPreference;
  late MockSharePreference mockSharePreference;

  setUp(() {
    mockSharePreference = MockSharePreference();
    appPreference = AppPreference(sharedPreferences: mockSharePreference);

    homeService = HomeService.instance;
    middleWareClient = MockCustomHttpClientMiddleWare();

    homeService.client = middleWareClient;
    homeService.appPreference = appPreference;
  });

  group("Home Services -", () {
    test("On successful response return product list", () async {
      const category = "Mobile";
      final myJsonEncode = json.encode({
        "category": category,
      });
      Map<String, String> headers = {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept-Language': 'en',
      };

      /// Arrange
      when(() => middleWareClient.post(
            Uri.parse(AppBaseUrl.getProductsByCategory),
            body: myJsonEncode,
            headers: headers,
          )).thenAnswer(
        (invocation) async => Response(
          """
                {
                    "status": true,
                    "data": [
                        {
                            "_id": "66897181bb7174743e932d58",
                            "name": "Lamp",
                            "price": "5",
                            "category": "Appliances",
                            "quantity": "20",
                            "description": "These are assentials",
                            "images": [
                                "https://res.cloudinary.com/dm0exb8fh/image/upload/v1720283518/Lamp/wdrq2f4lvs1naegjntqc.jpg",
                                "https://res.cloudinary.com/dm0exb8fh/image/upload/v1720283520/Lamp/th6mnikgmlhkdeu5zqvq.jpg"
                            ],
                            "rating": [
                                {
                                    "rate": "2.5",
                                    "productId": "66897181bb7174743e932d58",
                                    "userId": "6668f8c8c04a89576e2840f5",
                                    "_id": "668de5c486485c9bc20261d7"
                                },
                                {
                                    "rate": "5.0",
                                    "productId": "66897181bb7174743e932d58",
                                    "userId": "666ba50210b52b5a8193681b",
                                    "_id": "668f3f51f093cb4d3ae98de9"
                                }
                            ],
                            "createdAt": "2024-07-06T16:32:01.313Z",
                            "updatedAt": "2024-07-11T02:11:29.114Z",
                            "__v": 2,
                            "adminId": "666ba6a610b52b5a8193681e"
                        }
                    ]
                }
            """,
          200,
        ),
      );

      /// Act
      final result = await homeService.getProductByCategory(category: category);

      /// Assert
      expect(result, isA<Either<String, List<Product>>>());
      expect(result.isRight(), true);
      result.fold(
        (l) => expect(l, isA<String>()),
        (r) => expect(r, isA<List<Product>>()),
      );
    });

    test("returns success message when product response come with empty data",
        () async {
      const category = "null";
      final myJsonEncode = json.encode({
        "category": category,
      });
      Map<String, String> headers = {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept-Language': 'en',
      };

      // Arrange
      when(() => middleWareClient.post(
            Uri.parse(AppBaseUrl.getProductsByCategory),
            body: myJsonEncode,
            headers: headers,
          )).thenAnswer(
        (invocation) async => Response(
          """{
              "status": true,
              "data": []
          }""",
          200,
        ),
      );

      /// Act
      final result = await homeService.getProductByCategory(category: category);

      /// Assert
      expect(result, isA<Either<String, List<Product>>>());
      expect(result.isRight(), true);
      result.fold(
        (l) => expect(l, isA<String>()),
        (r) => expect(r, isA<List<Product>>()),
      );
    });
  });

  // Next for all unsuccessfull scenarios.
}
