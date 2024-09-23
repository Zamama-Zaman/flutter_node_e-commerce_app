import 'package:flutter_node_ecommerce_app_original/lib.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCustomHttpClientMiddleWare extends Mock
    implements CustomHttpClientMiddleWare {}

class MockSharePreference extends Mock implements SharedPreferences {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late ProductService productService;
  late MockCustomHttpClientMiddleWare middleWareClient;
  late AppPreference appPreference;
  late MockSharePreference mockSharePreference;

  setUp(() async {
    mockSharePreference = MockSharePreference();
    appPreference = AppPreference(sharedPreferences: mockSharePreference);

    productService = ProductService.instance;
    middleWareClient = MockCustomHttpClientMiddleWare();

    productService.client = middleWareClient;
    productService.appPreference = appPreference;
  });

  group("Add To Cart -", () {
    test(
        "The API call returns a status code of 200, indicating the product was successfully added to the cart.",
        () async {
      Product product = Product.fromMap(const {"_id": "0"});
      final myJsonEncode = json.encode({
        "productId": product.id,
      });

      Map<String, String> headers = {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept-Language': 'en',
        'Authorization': 'Bearer ${appPreference.getUserModel.token}',
      };

      /// Arrange
      when(
        () => middleWareClient.post(
          Uri.parse(AppBaseUrl.addToCartUrl),
          body: myJsonEncode,
          headers: headers,
        ),
      ).thenAnswer(
        (invocation) async => Response(
          """
                {
                    "status": true,
                    "message": "Product added to cart successfully"
                }
            """,
          200,
        ),
      );

      /// Act
      final result = await productService.addToCart(product: product);

      /// Assert
      expect(result, isA<Either<String, String>>());
      expect(result.isRight(), true);
      result.fold(
        (l) => expect(l, isA<String>()),
        (r) => expect(r, isA<String>()),
      );
      expect(result.getOrElse(() => ''), 'Product added to cart successfully');
    });

    test("The API call returns a non-200 status code, indicating failure.",
        () async {
      Product product = Product.fromMap(const {"_id": "0"});
      final myJsonEncode = json.encode({
        "productId": product.id,
      });

      Map<String, String> headers = {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept-Language': 'en',
        'Authorization': 'Bearer ${appPreference.getUserModel.token}',
      };

      /// Arrange
      when(
        () => middleWareClient.post(
          Uri.parse(AppBaseUrl.addToCartUrl),
          body: myJsonEncode,
          headers: headers,
        ),
      ).thenAnswer(
        (invocation) async => Response(
          """
                {
                    "status": false,
                    "message": "Failed to add product to cart"
                }
            """,
          400,
        ),
      );

      /// Act
      final result = await productService.addToCart(product: product);

      /// Assert
      expect(result, isA<Either<String, String>>());
      expect(result.isLeft(), true);
      result.fold(
        (l) => expect(l, isA<String>()),
        (r) => expect(r, isA<String>()),
      );
      expect(result.fold((l) => l, (r) => ''), 'Failed to add product to cart');
    });

    test("An exception occurs during the API call, such as a network error.",
        () async {
      Product product = Product.fromMap(const {"_id": "0"});
      final myJsonEncode = json.encode({
        "productId": product.id,
      });

      Map<String, String> headers = {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept-Language': 'en',
        'Authorization': 'Bearer ${appPreference.getUserModel.token}',
      };

      /// Arrange
      when(
        () => middleWareClient.post(
          Uri.parse(AppBaseUrl.addToCartUrl),
          body: myJsonEncode,
          headers: headers,
        ),
      ).thenThrow(Exception('Network error'));

      /// Act
      final result = await productService.addToCart(product: product);

      /// Assert
      expect(result, isA<Either<String, String>>());
      expect(result.isLeft(), true);
      result.fold(
        (l) => expect(l, isA<String>()),
        (r) => expect(r, isA<String>()),
      );
      expect(result.fold((l) => l, (r) => ''), contains('Error Add to Cart'));
    });

    test("The product object has an invalid or empty id", () async {
      Product product = Product.fromMap(const {"_id": ""});
      final myJsonEncode = json.encode({
        "productId": product.id,
      });

      Map<String, String> headers = {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept-Language': 'en',
        'Authorization': 'Bearer ${appPreference.getUserModel.token}',
      };

      /// Arrange
      when(
        () => middleWareClient.post(
          Uri.parse(AppBaseUrl.addToCartUrl),
          body: myJsonEncode,
          headers: headers,
        ),
      ).thenAnswer(
        (invocation) async => Response(
          """
                {
                    "status": false,
                    "message": "Id is required"
                }
            """,
          404,
        ),
      );

      /// Act
      final result = await productService.addToCart(product: product);

      /// Assert
      expect(result, isA<Either<String, String>>());
      expect(result.isLeft(), true);
      result.fold(
        (l) => expect(l, isA<String>()),
        (r) => expect(r, isA<String>()),
      );
      expect(result.fold((l) => l, (r) => ''), contains('Id is required'));
    });

    test(
        "Ensure that the request contains the proper headers, including Authorization and Accept-Language.",
        () async {
      Product product = Product.fromMap(const {"_id": "0"});
      final myJsonEncode = json.encode({
        "productId": product.id,
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
          Uri.parse(AppBaseUrl.addToCartUrl),
          body: myJsonEncode,
          headers: headers,
        ),
      ).thenAnswer((invocation) async {
        capturedHeaders = invocation.namedArguments[#headers];
        return Response(
          '{"message": "Product added to cart successfully"}',
          200,
        );
      });

      /// Act
      final result = await productService.addToCart(product: product);

      /// Assert
      expect(result, isA<Either<String, String>>());
      expect(capturedHeaders['Authorization'], contains('Bearer'));
      expect(capturedHeaders['Accept-Language'], isNotNull);
    });

    test("Handles malformed JSON response", () async {
      Product product = Product.fromMap(const {"_id": "0"});
      final myJsonEncode = json.encode({
        "productId": product.id,
      });

      Map<String, String> headers = {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept-Language': 'en',
        'Authorization': 'Bearer ${appPreference.getUserModel.token}',
      };

      /// Arrange
      when(
        () => middleWareClient.post(
          Uri.parse(AppBaseUrl.addToCartUrl),
          body: myJsonEncode,
          headers: headers,
        ),
      ).thenAnswer(
        (invocation) async => Response(
          """
                {
                    "status": true,
                    "message":
                }
            """,
          200,
        ),
      );

      /// Act
      final result = await productService.addToCart(product: product);

      /// Assert
      expect(result, isA<Either<String, String>>());
      expect(result.isLeft(), true);
    });

    // Group End
  });
}
