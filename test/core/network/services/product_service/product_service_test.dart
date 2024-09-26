import 'package:flutter_node_ecommerce_app_original/common/models/cart_model.dart';
import 'package:flutter_node_ecommerce_app_original/lib.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCustomHttpClientMiddleWare extends Mock
    implements CustomHttpClientMiddleWare {}

class MockSharePreference extends Mock implements SharedPreferences {}

void main() {
  // TestWidgetsFlutterBinding.ensureInitialized();
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
  });

  group("Get Cart -", () {
    test(
        "The API call returns a status code of 200, and the cart is successfully retrieved and parsed.",
        () async {
      Map<String, String> headers = {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept-Language': 'en',
        'Authorization': 'Bearer ${appPreference.getUserModel.token}',
      };

      /// Arrange
      when(
        () => middleWareClient.get(
          Uri.parse(AppBaseUrl.getCartUrl),
          headers: headers,
        ),
      ).thenAnswer(
        (invocation) async => Response(
          """
            {
              "status": "Success",
              "message": "Successfully fetch carts",
              "body": {
                  "cart": [
                      {
                          "product": {
                              "adminId": "666ba6a610b52b5a8193681e",
                              "name": "Laptop",
                              "price": "20",
                              "category": "Mobile",
                              "quantity": "10",
                              "description": "This is an new laptop",
                              "images": [
                                  "https://res.cloudinary.com/dm0exb8fh/image/upload/v1719194944/Laptop/rvratodms2hunddeerqg.jpg",
                                  "https://res.cloudinary.com/dm0exb8fh/image/upload/v1719194948/Laptop/pcqewzi313hbxcw0e04t.jpg",
                                  "https://res.cloudinary.com/dm0exb8fh/image/upload/v1719194950/Laptop/tlesg67mahz44nqg1nz1.jpg"
                              ],
                              "rating": [
                                  {
                                      "rate": "4.5",
                                      "productId": "6678d547b75d44bd2ca18de7",
                                      "userId": "6668f8c8c04a89576e2840f5",
                                      "_id": "668ca3b6d32da622aba2f5f5"
                                  },
                                  {
                                      "rate": "4.6",
                                      "productId": "6678d547b75d44bd2ca18de7",
                                      "userId": "666ba50210b52b5a8193681b",
                                      "_id": "668f3666f093cb4d3ae98d92"
                                  }
                              ],
                              "_id": "6678d547b75d44bd2ca18de7",
                              "createdAt": "2024-06-24T02:09:11.370Z",
                              "updatedAt": "2024-09-24T15:36:29.641Z",
                              "__v": 2
                          },
                          "quantity": 1,
                          "_id": "66f2dc7d47fc602b62728b62"
                          }
                        ]
                      }
                    }
            """,
          200,
        ),
      );

      /// Act
      final result = await productService.getCart();

      /// Assert
      expect(result, isA<Either<String, List<CartModel>>>());
      expect(result.isRight(), true);
      result.fold(
        (l) => expect(l, isA<String>()),
        (r) => expect(r, isA<List<CartModel>>()),
      );
    });

    test("The API call returns a non-200 status code, indicating failure.",
        () async {
      Map<String, String> headers = {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept-Language': 'en',
        'Authorization': 'Bearer ${appPreference.getUserModel.token}',
      };

      /// Arrange
      when(
        () => middleWareClient.get(
          Uri.parse(AppBaseUrl.getCartUrl),
          headers: headers,
        ),
      ).thenAnswer(
        (invocation) async => Response(
          """
            {
              "status": "fails",
              "message": "Failed to fetch cart"
            }
            """,
          400,
        ),
      );

      /// Act
      final result = await productService.getCart();

      /// Assert
      expect(result, isA<Either<String, List<CartModel>>>());
      expect(result.isLeft(), true);
      result.fold(
        (l) => expect(l, isA<String>()),
        (r) => expect(r, isA<List<CartModel>>()),
      );
      expect(result.fold((l) => l, (r) => ''), 'Failed to fetch cart');
    });

    test("An exception occurs during the API call, such as a network error.",
        () async {
      Map<String, String> headers = {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept-Language': 'en',
        'Authorization': 'Bearer ${appPreference.getUserModel.token}',
      };

      /// Arrange
      when(
        () => middleWareClient.get(
          Uri.parse(AppBaseUrl.getCartUrl),
          headers: headers,
        ),
      ).thenThrow(Exception('Network error'));

      /// Act
      final result = await productService.getCart();

      /// Assert
      expect(result, isA<Either<String, List<CartModel>>>());
      expect(result.isLeft(), true);
      result.fold(
        (l) => expect(l, isA<String>()),
        (r) => expect(r, isA<List<CartModel>>()),
      );
      expect(result.fold((l) => l, (r) => ''), contains('Error Get Cart'));
    });

    test("The API call is successful (200) but the cart is empty.", () async {
      Map<String, String> headers = {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept-Language': 'en',
        'Authorization': 'Bearer ${appPreference.getUserModel.token}',
      };

      /// Arrange
      when(
        () => middleWareClient.get(
          Uri.parse(AppBaseUrl.getCartUrl),
          headers: headers,
        ),
      ).thenAnswer((a) async {
        return Response(
          """
          {
              "status": "Success",
              "message": "Successfully fetch carts",
              "body": {
                  "cart": []
                }
          }
          """,
          200,
        );
      });

      /// Act
      final result = await productService.getCart();

      /// Assert
      expect(result, isA<Either<String, List<CartModel>>>());
      expect(result.isRight(), true);
      result.fold(
        (l) => expect(l, isA<String>()),
        (r) => expect(r, isA<List<CartModel>>()),
      );
      expect(result.getOrElse(() => []).isEmpty, true);
    });

    // Make Plan for next Unit Test

    // Group End
  });
}
