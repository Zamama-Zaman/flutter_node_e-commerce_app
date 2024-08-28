import 'package:flutter_node_ecommerce_app_original/lib.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCustomHttpClientMiddleWare extends Mock
    implements CustomHttpClientMiddleWare {}

void main() {
  late MockCustomHttpClientMiddleWare middleWareClient;
  late HomeService homeService;

  setUp(() {
    middleWareClient = MockCustomHttpClientMiddleWare();
    homeService = HomeService.instance;
  });

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
          Uri.parse(AppBaseUrl.loginUrl),
          body: myJsonEncode,
          headers: headers,
        )).thenAnswer(
      (a) async => Response("{}", 200),
    );

    /// Act
    final result = await homeService.getProductByCategory(category: category);

    /// Assert
    expect(result, isA<Either<String, List<Product>>>());
    expect(result.isRight(), true);
    result.fold((l) => isA<String>(), (r) => isA<List<Product>>());
  });
}
