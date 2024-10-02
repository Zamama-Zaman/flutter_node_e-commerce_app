import 'package:flutter_node_ecommerce_app_original/lib.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCustomHttpClientMiddleWare extends Mock
    implements CustomHttpClientMiddleWare {}

class MockSharePreference extends Mock implements SharedPreferences {}

void main() async {
  // TestWidgetsFlutterBinding.ensureInitialized();
  late AdminService adminService;
  late MockCustomHttpClientMiddleWare middleWareClient;
  late AppPreference appPreference;
  late MockSharePreference mockSharePreference;

  setUp(() {
    mockSharePreference = MockSharePreference();
    appPreference = AppPreference(sharedPreferences: mockSharePreference);
    //
    adminService = AdminService.instance;
    middleWareClient = MockCustomHttpClientMiddleWare();

    //
    adminService.client = middleWareClient;
    adminService.appPreInstance = appPreference;
  });

  group("Add Product -", () {
    test(
        "The function successfully fetches the products from the API and returns a list of Product objects.",
        () async {
      //
      Map<String, String> headers = {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept-Language': 'en',
        'Authorization': 'Bearer ${appPreference.getUserModel.token}',
      };

      // Arrange
      when(() => middleWareClient.get(
            Uri.parse(AppBaseUrl.fetchAllProductUrl),
            headers: headers,
          )).thenAnswer((invocation) async {
        return Response(
          '''
          {
            "status": "true",
            "data": [
                      {
                      "_id": "6678d547b75d44bd2ca18de7",
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
                      "createdAt": "2024-06-24T02:09:11.370Z",
                      "updatedAt": "2024-07-11T01:33:26.303Z",
                      "__v": 2,
                      "adminId": "666ba6a610b52b5a8193681e"
                    }
                  ]
                }
              ''',
          200,
        );
      });

      // act
      final result = await adminService.fetchAllProducts();

      // assert
      expect(result, isA<Either<String, List<Product>>>());
      expect(result.isRight(), true);
      result.fold(
        (l) => expect(l, isA<String>()),
        (r) => expect(r, isA<List<Product>>()),
      );
    });

    test(
        "The API returns a non-200 status code, and the function returns an error message.",
        () async {
      //
      Map<String, String> headers = {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept-Language': 'en',
        'Authorization': 'Bearer ${appPreference.getUserModel.token}',
      };

      // Arrange
      when(() => middleWareClient.get(
            Uri.parse(AppBaseUrl.fetchAllProductUrl),
            headers: headers,
          )).thenAnswer((invocation) async {
        return Response(
          '''
          {
            "status": "true",
            "message": "Failed to fetch products"
          }
          ''',
          400,
        );
      });

      // act
      final result = await adminService.fetchAllProducts();

      // assert
      expect(result, isA<Either<String, List<Product>>>());
      expect(result.isLeft(), true);
      result.fold(
        (l) => expect(l, isA<String>()),
        (r) => expect(r, isA<List<Product>>()),
      );
      expect(result.fold((l) => l, (r) => ''), 'Failed to fetch products');
    });

    // Group End
    // Plan for next Unit test
  });
}
